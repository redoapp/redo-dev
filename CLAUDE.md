# CLAUDE.md - Redo Developer Repository Guide

## Commands

- **Build**: `bazel build //...` (all targets) or `bazel build //path/to:target`
- **Build API Schema**: `bazel build redo/api-schema/openapi`
- **Lint**: `bazel run //:lint` or `bazel run //tools/lint:lint`
- **Test**: `bazel test //...` (all tests) or `bazel test //path/to:test_target`
- **Single Test**: `bazel test //path/to:specific_test --test_output=all`
- **YAML Lint**: `bazel run //tools/lint:yaml_lint`
- **Prettier Lint**: `bazel run //tools/lint:prettier_lint`

## Code Style Guidelines

- **OpenAPI Schema**: Organize API definitions in `/redo/api-schema/src/` with
  proper schema references
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
