# A2A Protocol (AI Government Edition)

## Permission Matrix

### Central Layer
- main(CoS) → policy-draft, execution (not direct to ministries)
- policy-draft → policy-review
- policy-review → execution  
- execution → all six ministries

### Ministry Layer
- resources → local-resources
- engineering → local-engineering (guidance only)
- operations → local-operations
- security → local-security
- knowledge → local-knowledge
- people → local-people

### Key Rules
1. main(CoS) cannot directly assign to ministries
2. Ministries cannot directly command local
3. Local only executes, never assigns

## Workflow
User → main(CoS) → policy-draft → policy-review → execution → ministries → local

## Channels
- #main: main(CoS)
- #policy: policy-draft + policy-review
- #execution: execution
- #engineering: engineering
- (other ministry channels)
