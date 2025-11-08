# CLAUDE.md - Redo Developer Repository Guide

## Commands

- **Build**: `bazel build //...` (all targets) or `bazel build //path/to:target`
- **Build API Schema**: `bazel build redo/api-schema/openapi`
- **Generate OpenAPI**: `bazel run openapi_gen` (copy generated OpenAPI to source)
- **Lint**: `bazel run //:lint` or `bazel run //tools/lint:lint`
- **Test**: `bazel test //...` (all tests) or `bazel test //path/to:test_target`
- **Single Test**: `bazel test //path/to:specific_test --test_output=all`
- **YAML Lint**: `bazel run //tools/lint:yaml_lint`
- **Prettier Lint**: `bazel run //tools/lint:prettier_lint`
- **Documentation Server**: `bazel run docs` (start Mintlify dev server)
- **Check Broken Links**: `bazel run docs -- broken-links`
- **OpenAPI Validation**: `bazel run docs -- openapi-check redo/api-schema/openapi.yaml`
- **Custom Port**: `bazel run docs -- --port 3333`

## Code Style Guidelines

- **OpenAPI Schema**: Organize API definitions in `/redo/api-schema/src/` with
  proper schema references
  - **CRITICAL**: NEVER edit `redo/api-schema/openapi.yaml` directly
  - Always make changes in `redo/api-schema/src/` files
  - After editing, run `bazel run openapi_gen` to update the generated OpenAPI
    file
  - After generation, validate with
    `bazel run docs -- openapi-check redo/api-schema/openapi.yaml`
- **Naming**: Use kebab-case for file names, camelCase for properties in schemas
- **Types**: Use TypeScript with strict typing when available
- **Formatting**: Use Prettier for code formatting with provided configuration
- **Error Handling**: Follow OpenAPI error schema definitions for API responses
- **File Structure**:
  - API paths in `path/` directory
  - Schemas in `schema/` directory
  - Parameters in `param/` directory
  - Headers in `header/` directory

## Repository Structure

This repository primarily contains OpenAPI schema definitions and Bazel build
configurations for the Redo API.

## Working relationship

- You can push back on ideas-this can lead to better documentation. Cite sources
  and explain your reasoning when you do so
- ALWAYS ask for clarification rather than making assumptions
- NEVER lie, guess, or make up information

## Project context

- Format: MDX files with YAML frontmatter
- Config: redo/docs/docs.json for navigation, theme, settings
- Components: Mintlify components

## Content strategy

- Document just enough for user success - not too much, not too little
- Prioritize accuracy and usability of information
- Make content evergreen when possible
- Search for existing information before adding new content. Avoid duplication
  unless it is done for a strategic reason
- Check existing patterns for consistency
- Start by making the smallest reasonable changes

## Frontmatter requirements for pages

- title: Clear, descriptive page title
- description: Concise summary for SEO/navigation

## Writing standards

- Second-person voice ("you")
- Prerequisites at start of procedural content
- Test all code examples before publishing
- Match style and formatting of existing pages
- Include both basic and advanced use cases
- Language tags on all code blocks
- Alt text on all images
- Relative paths for internal links

## Git workflow

- NEVER use --no-verify when committing
- Ask how to handle uncommitted changes before starting
- Create a new branch when no clear branch exists for changes
- Commit frequently throughout development
- NEVER skip or disable pre-commit hooks

## Do not

- Skip frontmatter on any MDX file
- Use absolute URLs for internal links
- Include untested code examples
- Make assumptions - always ask for clarification
- **NEVER edit `redo/api-schema/openapi.yaml` directly** - always edit source
  files in `redo/api-schema/src/` and run `bazel run openapi_gen`
