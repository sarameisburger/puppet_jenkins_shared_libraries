#USAGE: ./tag_enterprise_dist_next_rc.sh <version> <branch_from>

version=$1
branch_from=$2

rm -rf ./${GITHUB_PROJECT}
git clone git@github.com:puppetlabs/${GITHUB_PROJECT} ./${GITHUB_PROJECT}
cd ${GITHUB_PROJECT}

# checkout release branch and push empty commit then tag
git checkout ${version}-release
bundle exec rake new_release:push_empty_commit PE_BRANCH_NAME=${version}-release
bundle exec rake new_release:create_and_push_rc_tag PE_BRANCH_NAME=${version}-release

# checkout branch_from branch, push empty commit, and tag next version rc
git checkout branch_from
bundle exec rake new_release:push_empty_commit PE_BRANCH_NAME=branch_from
# If branch_from is master we tag next release with next Y (2019.4.0 -> 2019.5.0)
# Otherwise we're branching from an LTS branch so tag next Z (2018.1.11 -> 2018.1.12)
if [[ branch_from == "master" ]]
	bundle exec rake new_release:create_and_push_new_y_tag PE_BRANCH_NAME=branch_from
else
	bundle exec rake new_release:create_and_push_new_z_tag PE_BRANCH_NAME=branch_from
fi

cd ..
rm -rf ${GITHUB_PROJECT}
