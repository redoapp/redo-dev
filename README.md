# Redo Developer Documentation

Official documentation for the Redo returns and exchanges platform API. See
[Documentation](https://developer.getredo.com/).

## Development

See [Development]()

View your local preview at `http://localhost:3000`.

### Generating openapi files

Do not adjust the redo/api-schema/openapi.yaml directly. Instead,

1. Make changes to the necessary files in api-schema/src

2. Build the openapi file:

```bash
bazel build redo/api-schema:openapi
```

3. Copy the generated file from the bazel output location into the api-schema
   folder:

```bash
bazel run openapi_gen
```

**Note: You must be in the root folder to run any bazel commands and must be in
the redo folder to run any mint commands**

## Documentation Structure

- **Home** - Welcome page and platform overview
- **Guides** - Integration guides with code examples
- **API Reference** - Complete API documentation with endpoints

## Support

For questions or assistance, contact
[support@getredo.com](mailto:support@getredo.com).
