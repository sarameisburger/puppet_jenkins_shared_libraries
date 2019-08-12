package com.puppet.jenkinsSharedLibraries

class Beaker extends RvmEnvironment {
    String beakerScript
    Beaker(String rubyVersion, String beakerCommand) {
        super(rubyVersion)
        this.beakerScript = this.rvmCommand + """
export BUNDLE_BIN=.bundle/bin
export BUNDLE_PATH=.bundle/gems
bundle exec beaker ${beakerCommand}
"""
    }
}
