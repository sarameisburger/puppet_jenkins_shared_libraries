package com.puppet.jenkinsSharedLibraries

class ChangeDirectory {
   def steps
   ChangeDirectory(steps) { this.steps = steps }

   def chDir(dir){
      steps.sh "cd ${dir}"
   }
}
