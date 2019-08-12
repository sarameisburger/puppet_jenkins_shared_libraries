package com.puppet.jenkinsSharedLibraries

class BundleExec extends RvmEnvironment {
    String bundleExec
    BundleExec(String rubyVersion, String bundleExecCommand) {
        super(rubyVersion)
        this.bundleExec = this.rvmCommand + """
export BUNDLE_BIN=.bundle/bin
export BUNDLE_PATH=.bundle/gems
bundle exec ${bundleExecCommand}
"""
    }
}

