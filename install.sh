#!/bin/bash
#
# AI Government - One-Line Installer
# Usage: curl -fsSL .../install.sh | bash -s -- [options]
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
MODE=""
CAPITAL=false
REGIONAL=false
MINIMAL=false
DEBUG=false
SLACK_BOT_TOKEN=""
SLACK_APP_TOKEN=""
CAPITAL_HOST=""
PROJECT_NAME=""
REGION="aliyun"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --capital)
      CAPITAL=true
      MODE="capital"
      shift
      ;;
    --regional)
      REGIONAL=true
      MODE="regional"
      shift
      ;;
    --minimal)
      MINIMAL=true
      MODE="minimal"
      shift
      ;;
    --slack-token)
      SLACK_BOT_TOKEN="$2"
      shift 2
      ;;
    --slack-app-token)
      SLACK_APP_TOKEN="$2"
      shift 2
      ;;
    --capital-host)
      CAPITAL_HOST="$2"
      shift 2
      ;;
    --project)
      PROJECT_NAME="$2"
      shift 2
      ;;
    --region)
      REGION="$2"
      shift 2
      ;;
    --debug)
      DEBUG=true
      set -x
      shift
      ;;
    --help|-h)
      echo "Usage: install.sh [OPTIONS]"
      echo ""
      echo "Modes:"
      echo "  --capital          Install as Capital (central hub)"
      echo "  --regional         Install as Regional (project server)"
      echo "  --minimal          Minimal installation (dev mode)"
      echo ""
      echo "Options:"
      echo "  --slack-token      Slack Bot Token (xoxb-...)"
      echo "  --slack-app-token  Slack App Token (xapp-...)"
      echo "  --capital-host     Capital server URL (for regional)"
      echo "  --project          Project name (for regional)"
      echo "  --region           Cloud region (aliyun/aws/gcp)"
      echo "  --debug            Enable debug mode"
      echo "  --help             Show this help"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Functions
log_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

check_prerequisites() {
  log_info "Checking prerequisites..."
  
  # Check OS
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
  else
    log_error "Unsupported OS: $OSTYPE"
    exit 1
  fi
  
  # Check dependencies
  if ! command -v git &> /dev/null; then
    log_error "git is required but not installed"
    exit 1
  fi
  
  if ! command -v curl &> /dev/null; then
    log_error "curl is required but not installed"
    exit 1
  fi
  
  log_success "Prerequisites check passed"
}

detect_mode() {
  if [ -z "$MODE" ]; then
    log_warn "No mode specified, defaulting to --regional"
    REGIONAL=true
    MODE="regional"
  fi
  
  if [ "$CAPITAL" = true ]; then
    log_info "Installing as CAPITAL (中枢/首都)"
  elif [ "$REGIONAL" = true ]; then
    log_info "Installing as REGIONAL (地方/州)"
  elif [ "$MINIMAL" = true ]; then
    log_info "Installing as MINIMAL (最小安装)"
  fi
}

install_openclaw() {
  log_info "Installing OpenClaw..."
  
  if command -v openclaw &> /dev/null; then
    log_warn "OpenClaw already installed"
    openclaw --version
    return
  fi
  
  if command -v npm &> /dev/null; then
    npm install -g openclaw
  else
    log_error "npm not found. Please install Node.js first:"
    log_error "  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -"
    log_error "  sudo apt-get install -y nodejs"
    exit 1
  fi
  
  log_success "OpenClaw installed"
}

clone_repository() {
  log_info "Cloning AI Government repository..."
  
  REPO_URL="https://github.com/fenix19830717a-sudo/China-opencrew.git"
  INSTALL_DIR="${HOME}/.openclaw/ai-government"
  
  if [ -d "$INSTALL_DIR" ]; then
    log_warn "Directory exists, updating..."
    cd "$INSTALL_DIR"
    git pull origin main
  else
    mkdir -p ~/.openclaw
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
  fi
  
  log_success "Repository ready at $INSTALL_DIR"
}

setup_capital() {
  log_info "Setting up CAPITAL (中枢)..."
  
  INSTALL_DIR="${HOME}/.openclaw/ai-government"
  
  # Copy central configuration
  log_info "Copying central configuration..."
  cp -r "${INSTALL_DIR}/central/"* "${HOME}/.openclaw/"
  
  # Create mode file
  mkdir -p "${HOME}/.openclaw/config"
  cat > "${HOME}/.openclaw/config/mode" << 'EOF'
MODE=capital
CAPITAL=true
INSTALL_DATE=$(date -Iseconds)
EOF
  
  # Copy and configure openclaw.json
  if [ ! -f "${HOME}/.openclaw/openclaw.json" ]; then
    cp "${INSTALL_DIR}/config/openclaw.json" "${HOME}/.openclaw/"
    
    # Replace tokens if provided
    if [ -n "$SLACK_BOT_TOKEN" ]; then
      sed -i "s/xoxb-YOUR-BOT-TOKEN/$SLACK_BOT_TOKEN/g" "${HOME}/.openclaw/openclaw.json"
    fi
    if [ -n "$SLACK_APP_TOKEN" ]; then
      sed -i "s/xapp-YOUR-APP-TOKEN/$SLACK_APP_TOKEN/g" "${HOME}/.openclaw/openclaw.json"
    fi
  fi
  
  # Create systemd service (Linux)
  if [ "$OS" = "linux" ] && command -v systemctl &> /dev/null; then
    setup_systemd_service
  fi
  
  log_success "Capital setup complete"
}

setup_regional() {
  log_info "Setting up REGIONAL (地方)..."
  
  INSTALL_DIR="${HOME}/.openclaw/ai-government"
  
  # Validate required parameters
  if [ -z "$CAPITAL_HOST" ]; then
    log_warn "--capital-host not specified, using default: https://localhost:3000"
    CAPITAL_HOST="https://localhost:3000"
  fi
  
  if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="default-project"
    log_warn "--project not specified, using default: $PROJECT_NAME"
  fi
  
  # Copy regional template
  log_info "Copying regional configuration..."
  mkdir -p "${HOME}/.openclaw/regional"
  cp -r "${INSTALL_DIR}/templates/regions/${REGION}" "${HOME}/.openclaw/regional/${PROJECT_NAME}"
  
  # Create mode file
  mkdir -p "${HOME}/.openclaw/config"
  cat > "${HOME}/.openclaw/config/mode" << EOF
MODE=regional
CAPITAL_HOST=${CAPITAL_HOST}
PROJECT_NAME=${PROJECT_NAME}
INSTALL_DATE=$(date -Iseconds)
EOF
  
  # Create sync configuration
  cat > "${HOME}/.openclaw/config/sync" << EOF
SYNC_MODE=github
CAPITAL_API=${CAPITAL_HOST}/api
PROJECT=${PROJECT_NAME}
SYNC_INTERVAL=300
EOF
  
  log_success "Regional setup complete"
}

setup_minimal() {
  log_info "Setting up MINIMAL (最小安装)..."
  
  INSTALL_DIR="${HOME}/.openclaw/ai-government"
  
  # Copy only essential agents
  mkdir -p "${HOME}/.openclaw/minimal"
  cp -r "${INSTALL_DIR}/central/main" "${HOME}/.openclaw/minimal/"
  cp -r "${INSTALL_DIR}/central/execution" "${HOME}/.openclaw/minimal/"
  cp -r "${INSTALL_DIR}/central/ministries/engineering" "${HOME}/.openclaw/minimal/"
  
  # Create mode file
  mkdir -p "${HOME}/.openclaw/config"
  cat > "${HOME}/.openclaw/config/mode" << 'EOF'
MODE=minimal
INSTALL_DATE=$(date -Iseconds)
EOF
  
  log_success "Minimal setup complete"
}

setup_systemd_service() {
  log_info "Setting up systemd service..."
  
  cat > /tmp/ai-government.service << 'EOF'
[Unit]
Description=AI Government Agent System
After=network.target

[Service]
Type=simple
User=%USER%
WorkingDirectory=%HOME%/.openclaw
Environment="PATH=%PATH%"
ExecStart=%NPX% openclaw gateway start
ExecStop=%NPX% openclaw gateway stop
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
  
  # Replace variables
  sed -i "s|%USER%|$(whoami)|g" /tmp/ai-government.service
  sed -i "s|%HOME%|${HOME}|g" /tmp/ai-government.service
  sed -i "s|%PATH%|${PATH}|g" /tmp/ai-government.service
  sed -i "s|%NPX%|$(which npx)|g" /tmp/ai-government.service
  
  sudo mv /tmp/ai-government.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable ai-government.service
  
  log_info "Service installed. Start with: sudo systemctl start ai-government"
}

configure_slack() {
  if [ -z "$SLACK_BOT_TOKEN" ] || [ -z "$SLACK_APP_TOKEN" ]; then
    log_warn "Slack tokens not provided. You'll need to configure manually."
    return
  fi
  
  log_info "Configuring Slack integration..."
  
  # Update openclaw.json
  sed -i "s/xoxb-YOUR-BOT-TOKEN/$SLACK_BOT_TOKEN/g" "${HOME}/.openclaw/openclaw.json"
  sed -i "s/xapp-YOUR-APP-TOKEN/$SLACK_APP_TOKEN/g" "${HOME}/.openclaw/openclaw.json"
  
  log_success "Slack configured"
}

initialize_gateway() {
  log_info "Initializing OpenClaw Gateway..."
  
  # Check if gateway is already running
  if openclaw gateway status &> /dev/null; then
    log_warn "Gateway already running, restarting..."
    openclaw gateway restart || true
  else
    openclaw gateway start || true
  fi
  
  sleep 2
  
  # Verify
  if openclaw gateway status &> /dev/null; then
    log_success "Gateway is running"
  else
    log_warn "Gateway may not be fully started yet"
  fi
}

print_summary() {
  echo ""
  echo "========================================="
  echo -e "${GREEN}AI Government Installation Complete!${NC}"
  echo "========================================="
  echo ""
  echo "Installation Mode: $MODE"
  echo "Install Directory: ${HOME}/.openclaw"
  echo ""
  
  if [ "$CAPITAL" = true ]; then
    echo "You are running as CAPITAL (中枢/首都)"
    echo ""
    echo "Next steps:"
    echo "  1. Configure Slack tokens in ~/.openclaw/openclaw.json"
    echo "  2. Restart gateway: openclaw gateway restart"
    echo "  3. Test: openclaw status"
    echo ""
    echo "Slack Channels:"
    echo "  #main        - User interface"
    echo "  #policy      - Policy drafting/review"
    echo "  #execution   - Project management"
    echo "  #engineering - Development"
    echo "  #operations  - System operations"
    echo "  #security    - Security & audit"
    echo "  #knowledge   - Knowledge & research"
    echo "  #people      - Performance & training"
    
  elif [ "$REGIONAL" = true ]; then
    echo "You are running as REGIONAL (地方/州)"
    echo "Project: $PROJECT_NAME"
    echo "Capital Host: $CAPITAL_HOST"
    echo ""
    echo "Next steps:"
    echo "  1. Ensure Capital server is accessible"
    echo "  2. Configure GitHub sync in ~/.openclaw/config/sync"
    echo "  3. Start sync service: ./scripts/start-sync.sh"
    
  elif [ "$MINIMAL" = true ]; then
    echo "You are running in MINIMAL mode"
    echo ""
    echo "Available agents:"
    echo "  - main (CoS)"
    echo "  - execution"
    echo "  - engineering"
  fi
  
  echo ""
  echo "Documentation: https://github.com/fenix19830717a-sudo/China-opencrew"
  echo ""
  echo -e "${GREEN}Happy governing!${NC}"
}

# Main installation flow
main() {
  echo "========================================="
  echo "AI Government Installer"
  echo "========================================="
  echo ""
  
  check_prerequisites
  detect_mode
  install_openclaw
  clone_repository
  
  if [ "$CAPITAL" = true ]; then
    setup_capital
  elif [ "$REGIONAL" = true ]; then
    setup_regional
  elif [ "$MINIMAL" = true ]; then
    setup_minimal
  fi
  
  configure_slack
  initialize_gateway
  print_summary
}

# Run main
main
