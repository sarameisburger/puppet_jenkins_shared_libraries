#!/bin/sh
PE_VERSION=$1
REPO='ci-job-configs'
JOB_NAME='monorepo_release_job_creation'
YAML_FILEPATH=./jenkii/enterprise/projects/monorepo-promote.yaml
TEMP_BRANCH="auto/${JOB_NAME}/${PE_VERSION}-release"

rm -rf ./${REPO}
git clone git@github.com:puppetlabs/${REPO} ./${REPO}
cd ${REPO}
git checkout -b $TEMP_BRANCH

echo "
        - 'monorepo-component-pipeline':
            unit_ruby_versions:
              - ruby-2.5.1
            p_component_branch: '${PE_VERSION}-release'
            qualifier: '${PE_VERSION}-release'
            next_branch: ''
            p_vanagon_repo_branch: '${PE_VERSION}-release'
            component_scm_branch: '${PE_VERSION}-release'
            vanagon_scm_branch: '${PE_VERSION}-release'
            promote_branch: '${PE_VERSION}-release'
            pe_promotion: 'FALSE'" >> $YAML_FILEPATH

## create a PR and push it
git add $YAML_FILEPATH
git commit -m "${JOB_NAME} for ${PE_VERSION}-release"
git push origin $TEMP_BRANCH
PULL_REQUEST="$(git show -s --pretty='format:%s%n%n%b' | hub pull-request -b master -F -)"
echo "Opened PR for $(pwd): ${PULL_REQUEST}"
