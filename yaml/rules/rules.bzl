load("@rules_file//generate:providers.bzl", "FormatterInfo")

def _yaml_sort_format(ctx, src, out, bin):
    args = ctx.actions.args()
    args.add("-i", src)
    args.add("-o", out)
    ctx.actions.run(
        arguments = [args],
        executable = bin.executable,
        inputs = [src],
        outputs = [out],
        tools = [bin],
    )

def _yaml_sort_impl(ctx):
    bin = ctx.attr.bin[DefaultInfo]

    def format(ctx, path, src, out):
        _yaml_sort_format(ctx, src, out, bin.files_to_run)

    format_info = FormatterInfo(fn = format)

    return [format_info]

yaml_sort = rule(
    implementation = _yaml_sort_impl,
    attrs = {
        "bin": attr.label(
            cfg = "exec",
            executable = True,
            mandatory = True,
        ),
    },
)
