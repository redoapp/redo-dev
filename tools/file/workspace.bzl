load("@rules_file//file:workspace.bzl", "files")

def file_repositories():
    files(
        name = "files",
        build = "//tools/file:files.bzl",
        ignores = [
            ".git",
            ".repos",
            "data",
            "node_modules",
            "redo/merchant-app/.nuxt",
            "redo/merchant-app/dist",
            "redo/merchant-app/node_modules",
            "tools/npm/.yarn",
        ],
        root_file = "//:WORKSPACE.bazel",
    )
