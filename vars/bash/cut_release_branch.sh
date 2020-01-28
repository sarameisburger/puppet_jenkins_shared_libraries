  #USAGE: cut_release_branch <version> <branch_from>
  
  version=$1
  branch_from=$2

  rm -rf ./${GITHUB_PROJECT}
  git clone git@github.com:puppetlabs/${GITHUB_PROJECT} ./${GITHUB_PROJECT}
  cd ${GITHUB_PROJECT}

  git ls-remote | grep "${version}"-release

  if [[ ( "$?" == 0 ) ]]
  then
    echo "${version}-release branch already exists. Exiting release creation."
    exit 1
  fi

  if [ -z \"$branch_from\" ]
  then
    FAMILY=`echo ${version} | sed \"s/\\(.*\\..*\\)\\..*/\\1/\"`
    BRANCH_FOUND=`git branch --list \$FAMILY.x`

    # is the X.Y.Z branch isn't created then we're basing inital checkout off of master
    if [ -z \"\$BRANCH_FOUND\" ]
    then
      git checkout master
    else
      git checkout \${FAMILY}.x
    fi
  else
    git checkout ${branch_from}
  fi

  git checkout -b ${version}-release
  git push origin ${version}-release

  cd ..
  rm -rf \${GITHUB_PROJECT}
