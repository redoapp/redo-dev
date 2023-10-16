load("@rules_file//generate:providers.bzl", "FormatterInfo")

def _yaml_sort_format(ctx, src, out, bin):
    args = ctx.actions.args()
    args.add(bin)
    args.add(src)
    args.add(out)

    # args.add("-P", "sort_keys(..)")
    ctx.actions.run_shell(
        arguments = [args],
        command = '"$1" "sort_keys(..)" < "$2" > "$3"',
        inputs = [bin, src],
        outputs = [out],
        tools = [bin],
    )

def _yaml_sorter_impl(ctx):
    yq_info = ctx.toolchains["@aspect_bazel_lib//lib:yq_toolchain_type"].yqinfo
    yq_bin = yq_info.bin

    def format(ctx, path, src, out):
        _yaml_sort_format(ctx, src, out, yq_bin)

    format_info = FormatterInfo(fn = format)

    return [format_info]

yaml_sorter = rule(
    implementation = _yaml_sorter_impl,
    toolchains = ["@aspect_bazel_lib//lib:yq_toolchain_type"],
)

def _yq_bin_impl(ctx):
    actions = ctx.actions
    name = ctx.attr.name
    yq_info = ctx.toolchains["@aspect_bazel_lib//lib:yq_toolchain_type"].yqinfo

    executable = actions.declare_file(name)
    actions.symlink(
        output = executable,
        target_file = yq_info.bin,
    )

    default_info = DefaultInfo(executable = executable)

    return [default_info]

yq_bin = rule(
    executable = True,
    implementation = _yq_bin_impl,
    toolchains = ["@aspect_bazel_lib//lib:yq_toolchain_type"],
)
