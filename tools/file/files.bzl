package(default_visibility = ["//visibility:public"])

filegroup(
    name = "bazel_files",
    srcs = glob(["files/**/*.bazel", "files/**/*.bzl"]),
)

filegroup(
    name = "prettier_files",
    srcs = glob(
        [
            "files/**/*.md",
            "files/**/*.yaml",
        ],
    ),
)
