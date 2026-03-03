#!/bin/bash
# GitHub Sync Script for AI Government
# Usage: ./sync.sh [push|pull]

set -e

REPO_URL="https://github.com/fenix19830717a-sudo/China-opencrew.git"
LOCAL_TASKS_DIR="$HOME/.openclaw/ai-government/tasks"
MODE_FILE="$HOME/.openclaw/config/mode"

# Detect mode (capital or regional)
if [ -f "$MODE_FILE" ]; then
    MODE=$(cat "$MODE_FILE" | grep MODE | cut -d= -f2)
else
    MODE="regional"
fi

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Pull tasks from GitHub
pull_tasks() {
    log "Pulling tasks from GitHub..."
    
    cd "$LOCAL_TASKS_DIR/.."
    git pull origin main
    
    log "Tasks synced from GitHub"
    
    # Show pending tasks for this node
    if [ "$MODE" = "regional" ]; then
        echo ""
        echo "Pending tasks for you:"
        ls -la "$LOCAL_TASKS_DIR/pending/" | grep -E "\.(md|txt)$" || echo "  No pending tasks"
    fi
}

# Push local task updates to GitHub
push_tasks() {
    log "Pushing task updates to GitHub..."
    
    cd "$LOCAL_TASKS_DIR/.."
    
    # Check if there are changes
    if [ -z "$(git status --porcelain)" ]; then
        log "No changes to push"
        return 0
    fi
    
    # Add task changes
    git add tasks/
    
    # Commit with timestamp
    git commit -m "sync: $(date '+%Y-%m-%d %H:%M:%S') - $MODE update

- Task status changes
- Results from $MODE execution" || true
    
    # Push
    git push origin main
    
    log "Tasks pushed to GitHub"
}

# Auto sync (pull then push)
auto_sync() {
    pull_tasks
    push_tasks
}

# Main
case "${1:-auto}" in
    pull)
        pull_tasks
        ;;
    push)
        push_tasks
        ;;
    auto)
        auto_sync
        ;;
    *)
        echo "Usage: $0 [pull|push|auto]"
        echo "  pull  - Pull tasks from GitHub"
        echo "  push  - Push task updates to GitHub"
        echo "  auto  - Pull then push (default)"
        exit 1
        ;;
esac
