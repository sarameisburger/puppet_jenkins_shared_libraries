// src/com/puppet/jenkinsSharedLibraries.groovy
package com.puppet.jenkinsSharedLibraries

class Vanagon implements Serializable {
  def steps
  Vanagon(steps) {this.steps = steps}

  def promote(args) {
    steps.git url: "git@github.com:puppetlabs/${repo}"
    steps.sh "ls"
    steps.sh "echo 'vanagon promotion happens here'"
  }
}