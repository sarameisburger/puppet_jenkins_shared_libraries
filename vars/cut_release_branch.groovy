def call(String version, String branch_from) {

  if (version =~ '^20[0-9]{2}[.]([0-9]*)[.]([0-9]*)$') {
    println "${version} is a valid version"
  } else {
    println "${version} is an invalid version"
    throw new Exception("Invalid version")
  }

  def cmd = ["/bin/bash", "-c", "bash/cut_release_branch.sh", version, branch_from]
  println cmd.execute().text
}