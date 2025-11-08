# Mintlify technical writing rule

## Project context

- This is a documentation project on the Mintlify platform
- We use MDX files with YAML frontmatter
- Navigation is configured in `docs.json`
- We follow technical writing best practices

## Project-specific commands

### Bazel commands

- `bazel build //...` - Build all targets
- `bazel run openapi_gen` - Generate OpenAPI file from source (use after editing
  API schema)
- `bazel run //:lint` - Run all linters
- `bazel run docs` - Start Mintlify dev server for documentation preview
- `bazel run docs -- broken-links` - Check for broken documentation links
- `bazel run docs -- openapi-check api-schema/openapi.yaml` - Validate OpenAPI
  spec
- `bazel run docs -- --port 3333` - Run docs server on custom port

### OpenAPI editing workflow

**CRITICAL**: NEVER edit `redo/api-schema/openapi.yaml` directly.

The proper workflow is:

1. Make changes in `redo/api-schema/src/` files (paths, schemas, params,
   headers)
2. Run `bazel run openapi_gen` to regenerate the OpenAPI file
3. Validate the generated file with
   `bazel run docs -- openapi-check api-schema/openapi.yaml`
4. The generated `openapi.yaml` will be automatically updated

File structure in `redo/api-schema/src/`:

- `path/` - API endpoint definitions
- `schema/` - Object schemas
- `param/` - Parameter definitions
- `header/` - Header definitions

## Writing standards

- Use second person ("you") for instructions
- Write in active voice and present tense
- Start procedures with prerequisites
- Include expected outcomes for major steps
- Use descriptive, keyword-rich headings
- Keep sentences concise but informative

## Required page structure

Every page must start with frontmatter:

```yaml
---
title: "Clear, specific title"
description: "Concise description for SEO and navigation"
---
```

## Mintlify components

### Callouts

- `<Note>` for helpful supplementary information
- `<Warning>` for important cautions and breaking changes
- `<Tip>` for best practices and expert advice
- `<Info>` for neutral contextual information
- `<Check>` for success confirmations

### Code examples

- When appropriate, include complete, runnable examples
- Use `<CodeGroup>` for multiple language examples
- Specify language tags on all code blocks
- Include realistic data, not placeholders
- Use `<RequestExample>` and `<ResponseExample>` for API docs

### Procedures

- Use `<Steps>` component for sequential instructions
- Include verification steps with `<Check>` components when relevant
- Break complex procedures into smaller steps

### Content organization

- Use `<Tabs>` for platform-specific content
- Use `<Accordion>` for progressive disclosure
- Use `<Card>` and `<CardGroup>` for highlighting content
- Wrap images in `<Frame>` components with descriptive alt text

## API documentation requirements

- Document all parameters with `<ParamField>`
- Show response structure with `<ResponseField>`
- Include both success and error examples
- Use `<Expandable>` for nested object properties
- Always include authentication examples

## Quality standards

- Test all code examples before publishing
- Use relative paths for internal links
- Include alt text for all images
- Ensure proper heading hierarchy (start with h2)
- Check existing patterns for consistency
