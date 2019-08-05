package com.puppet.jenkinsSharedLibraries

class RvmEnvironment implements Serializable {
    String rubyVersion, rvmCommand
    RvmEnvironment(String rubyVersion) {
        this.rubyVersion = rubyVersion
        this.rvmCommand = """#!/bin/bash
set +x
source /usr/local/rvm/scripts/rvm
rvm use ${rubyVersion}
set -x
"""
    }
}
