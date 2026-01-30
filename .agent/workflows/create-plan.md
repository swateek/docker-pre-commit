---
description: Create a detailed implementation plan before starting execution
---

This workflow guides you through the process of creating a comprehensive implementation plan to ensure all requirements are met and the technical approach is sound.

1. **Understand Requirements**
   - Read the user request carefully.
   - List the core objectives and any constraints mentioned.
   - If anything is unclear, use `notify_user` to ask clarifying questions.

2. **Explore Codebase**
   - Use `find_by_name` or `list_dir` to locate relevant files.
   - Use `view_file` or `view_file_outline` to understand the current implementation.
   - Use `grep_search` to find usages of relevant functions or classes.

3. **Technical Design**
   - Identify the components that need modification.
   - Determine if any new files, dependencies, or APIs are required.
   - Think through potential edge cases and security implications.

4. **Create Implementation Plan**
   - Create the `implementation_plan.md` artifact in the brain directory.
   - Use the standard template:
     - **Goal Description**: Brief summary of changes.
     - **User Review Required**: Highlight breaking changes or design decisions.
     - **Proposed Changes**: Grouped by component, use `[MODIFY]`, `[NEW]`, or `[DELETE]`.
     - **Verification Plan**: Automated tests and manual verification steps.

5. **Request User Review**
   - Use `notify_user` with `PathsToReview` including the `implementation_plan.md` path.
   - Set `BlockedOnUser: true` to wait for approval before proceeding to execution.
