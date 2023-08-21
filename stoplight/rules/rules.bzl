load("@bazel_skylib//lib:shell.bzl", "shell")
load("@rules_file//util:path.bzl", "runfile_path")

def _stoplight_push_impl(ctx):
    actions = ctx.actions
    bash_runfiles_default = ctx.attr._bash_runfiles[DefaultInfo]
    label = ctx.label
    name = ctx.attr.name
    runner = ctx.file._runner
    root = ctx.attr.root
    srcs = ctx.files.srcs
    stoplight = ctx.executable.stoplight
    stoplight_default = ctx.attr.stoplight[DefaultInfo]
    workspace = ctx.workspace_name

    if root.startswith("/"):
        root = root[len("/"):]
    else:
        parts = [workspace, label.package, root]
        root = "/".join([path for path in parts if path])

    executable = actions.declare_file(name)
    actions.expand_template(
        is_executable = True,
        substitutions = {
            "%{root}": shell.quote(root),
            "%{stoplight}": shell.quote(runfile_path(workspace, stoplight)),
        },
        template = runner,
        output = executable,
    )

    runfiles = ctx.runfiles(files = srcs)
    runfiles = runfiles.merge(bash_runfiles_default.default_runfiles)
    runfiles = runfiles.merge(stoplight_default.default_runfiles)
    default_info = DefaultInfo(executable = executable, runfiles = runfiles)

    return [default_info]

stoplight_push = rule(
    attrs = {
        "root": attr.string(),
        "srcs": attr.label_list(allow_files = True),
        "stoplight": attr.label(cfg = "target", executable = True, mandatory = True),
        "_bash_runfiles": attr.label(
            default = "@bazel_tools//tools/bash/runfiles",
        ),
        "_runner": attr.label(allow_single_file = True, default = "push-runner.sh.tpl"),
    },
    executable = True,
    implementation = _stoplight_push_impl,
)
