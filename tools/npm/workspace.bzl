load("@better_rules_javascript//commonjs:workspace.bzl", "cjs_directory_npm_plugin")
load("@better_rules_javascript//typescript:workspace.bzl", "ts_directory_npm_plugin")
load("@better_rules_javascript//npm:workspace.bzl", "npm")
load(":npm.bzl", "PACKAGES", "ROOTS")

def npm_repositories():
    plugins = [
        cjs_directory_npm_plugin(),
        ts_directory_npm_plugin(),
    ]
    packages = {}
    for id, package in PACKAGES.items():
        if package["name"] in ("@puppeteer/browsers", "puppeteer-core"):
            package = dict(package)
            package["deps"] = [dep for dep in package["deps"] if not dep["id"].startswith("typescript@")]
        packages[id] = package
    npm("npm", roots = ROOTS, packages = packages, plugins = plugins)
