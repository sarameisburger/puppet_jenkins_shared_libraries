def call(String version) {

  if (version =~ '^20[0-9]{2}[.]([0-9]*)[.]([0-9]*)$') {
    println "${version} is a valid version"
  } else {
    println "${version} is an invalid version"
    throw new Exception("Invalid version")
  }


  sh """
  #!/usr/bin/env bash

  rm -rf ./${GITHUB_PROJECT}
  git clone git@github.com:puppetlabs/${GITHUB_PROJECT} ./${GITHUB_PROJECT}
  cd ${GITHUB_PROJECT}

  PE_VERSION=${version}

  if [ -z "$BRANCH_FROM" ]
  then
    FAMILY=`echo $PE_VERSION | sed "s/\(.*\..*\)\..*/\1/"`
    BRANCH_FOUND=`git branch --list $FAMILY.x`

    # is the X.Y.Z branch isn't created then we're basing inital checkout off of master
    if [ -z "$BRANCH_FOUND" ]
    then
      git checkout master
    else
      git checkout ${FAMILY}.x
    fi
  else
    git checkout ${BRANCH_FROM}
  fi

  git checkout -b ${PE_VERSION}-release
  git push origin ${PE_VERSION}-release

  cd ..
  rm -rf ${GITHUB_PROJECT}

  """
}