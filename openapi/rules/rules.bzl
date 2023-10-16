def _openapi_bundle_impl(ctx):
    actions = ctx.actions
    redocly = ctx.executable._redocly
    redocly_default = ctx.attr._redocly[DefaultInfo]
    main = ctx.file.main
    srcs = [ctx.file.main] + ctx.files.srcs
    output = ctx.attr.output or actions.declare_file("%s.yaml" % ctx.attr.name)

    args = actions.args()
    args.add("bundle")
    args.add("-o", output)
    args.add(main)
    actions.run(
        executable = redocly,
        arguments = [args],
        inputs = srcs,
        outputs = [output],
        tools = [redocly_default.files_to_run],
    )

    default_info = DefaultInfo(files = depset([output]))

    return [default_info]

openapi_bundle = rule(
    attrs = {
        "main": attr.label(allow_single_file = [".json", ".yaml", ".yml"]),
        "output": attr.output(),
        "srcs": attr.label_list(allow_files = [".json", ".yaml", ".yml"]),
        "_redocly": attr.label(cfg = "exec", executable = True, default = "//tools/redocly:bin"),
    },
    implementation = _openapi_bundle_impl,
)

def _openapi_ts_impl(ctx):
    actions = ctx.actions
    openapi_typescript = ctx.executable.openapi_typescript
    openapi_typescript_default = ctx.attr.openapi_typescript[DefaultInfo]
    options = ctx.attr.options
    output = ctx.outputs.output
    src = ctx.file.src

    args = actions.args()
    args.add("-o", output)
    for option in options:
        args.add(option)
    args.add(src)
    actions.run(
        arguments = [args],
        executable = openapi_typescript,
        inputs = [src],
        outputs = [output],
    )

    default_info = DefaultInfo(files = depset([output]))

    return [default_info]

openapi_ts = rule(
    attrs = {
        "openapi_typescript": attr.label(
            cfg = "exec",
            executable = True,
            mandatory = True,
        ),
        "src": attr.label(allow_single_file = [".json", ".yml", ".yaml"], mandatory = True),
        "options": attr.string_list(default = ["--alphabetize"]),
        "output": attr.output(mandatory = True),
    },
    implementation = _openapi_ts_impl,
)
