# Solo Developer Workflow

## Scenario
A solo developer is creating a new feature from scratch and wants to ensure code quality without the overhead of heavy coordination. They need a fast, structured, and reliable feedback loop.

## Persona
Solo Developer

## Skills Used
- `karsa-bootstrap`
- `karsa-dev-loop`
- `implementation-audit`

## Workflow Steps
1. **Initialize**: Invoke `karsa-bootstrap` to lay out the project foundation and configure linters.
2. **Implement**: Write code for the initial feature module.
3. **Iterate**: Use `karsa-dev-loop` to perform a micro-review of the feature progress, adjusting logic as needed based on local feedback.
4. **Audit**: Once the feature is ostensibly complete, run `implementation-audit` to detect edge cases or structural flaws before committing.
5. **Remediate**: Fix any findings raised by the audit.
6. **Finalize**: Proceed to commit and merge the code.

## Expected Outputs
- `bootstrap-report` (Project initialization configuration).
- `iteration-log` (Record of iterations performed during the dev loop).
- `implementation-audit-report` (Verification that code meets structural requirements).
