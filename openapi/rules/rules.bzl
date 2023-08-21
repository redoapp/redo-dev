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
