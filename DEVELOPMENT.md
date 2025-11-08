# Development

Preview changes locally to update the Redo docs

## Prerequisites

- Bazel installed and configured
- Mintlify CLI installed globally (`npm i -g mint`)

## Documentation Structure

- **Home** - Welcome page and platform overview
- **Guides** - Integration guides with code examples
- **API Reference** - Complete API documentation with endpoints

## Preview Documentation Locally

Run the following command from the repository root to start the Mintlify
development server:

```bash
bazel run docs
```

A local preview of your documentation will be available at
`http://localhost:3000`.

## Generating OpenAPI files

Do not adjust the redo/api-schema/openapi.yaml directly. Instead:

1. Make changes to the necessary files in api-schema/src
2. Build and copy the generated file from the bazel output location into the
   api-schema folder:

```bash
bazel run openapi_gen
```

## Custom ports

By default, Mintlify uses port 3000. You can customize the port Mintlify runs on
by using the `--port` flag. For example, to run Mintlify on port 3333, use this
command:

```bash
bazel run docs -- --port 3333
```

If you attempt to run Mintlify on a port that's already in use, it will use the
next available port:

```
Port 3000 is already in use. Trying 3001 instead.
```

## Mintlify versions

Please note that each CLI release is associated with a specific version of
Mintlify. If your local preview does not align with the production version,
please update the CLI:

```bash
npm update -g mint
```

## Verify the OpenAPI file is valid to the OpenAPI specification

```bash
bazel run docs -- openapi-check api-schema/openapi.yaml
```

## Validating links

The CLI can assist with validating links in your documentation. To identify any
broken links, use the following command:

```bash
bazel run docs -- broken-links
```

## Code formatting

We suggest using extensions on your IDE to recognize and format MDX. If you're a
VSCode user, consider the
[MDX VSCode extension](https://marketplace.visualstudio.com/items?itemName=unifiedjs.vscode-mdx)
for syntax highlighting, and
[Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
for code formatting.

## Troubleshooting

### Error: Could not load the "sharp" module using the darwin-arm64 runtime

This may be due to an outdated version of node. Try the following:

1. Remove the currently-installed version of the CLI: `npm remove -g mint`
2. Upgrade to Node v19 or higher.
3. Reinstall the CLI: `npm i -g mint`

### Issue: Encountering an unknown error

Solution: Go to the root of your device and delete the `~/.mintlify` folder.
Then run `bazel run docs` again.

---

Curious about what changed in the latest CLI version? Check out the
[CLI changelog](https://www.npmjs.com/package/mintlify?activeTab=versions).
