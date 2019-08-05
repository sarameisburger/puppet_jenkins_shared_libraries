package com.puppet.jenkinsSharedLibraries

class BundleInstall extends RvmEnvironment {
    String bundleInstall
    BundleInstall(String rubyVersion) {
        super(rubyVersion)
        this.bundleInstall = this.rvmCommand + """
export BUNDLE_BIN=.bundle/bin
export BUNDLE_PATH=.bundle/gems
bundle install
"""
    }

    BundleInstall(String rubyVersion, String gemfile) {
        super(rubyVersion)
        this.bundleInstall = this.rvmCommand + """
export BUNDLE_BIN=.bundle/bin
export BUNDLE_PATH=.bundle/gems
bundle install --gemfile ${gemfile}
"""
    }
}
