#!/bin/sh
PE_VERSION=$1
FAMILY=`echo $PE_VERSION | sed "s/\(.*\..*\)\..*/\1/"`
X_FAMILY=`echo $FAMILY | sed "s/\(.*\)\..*/\1/"`
Y_FAMILY=`echo $FAMILY | sed "s/.*\.\(.*\)/\1/"`

# supported_upgrade_defaults logic
# incase we are basing the release branch off of master
upgrade_default_name="p_${X_FAMILY}_${Y_FAMILY}_installer_vanagon_settings"
grep_output=`grep ${upgrade_default_name} jenkii/enterprise/projects/pe-installer-vanagon.yaml`
FAMILY_SETTING="${X_FAMILY}_${Y_FAMILY}"
if [ -z "$grep_output" ]; then
    FAMILY_SETTING="master"
fi

echo "
        - 'pe-installer-vanagon-with-pez-and-ui-acceptance':
            component_scm_branch: '${PE_VERSION}-release'
            vanagon_scm_branch: '${PE_VERSION}-release'
            promote_branch: '${PE_VERSION}-release'
            <<: *p_${FAMILY_SETTING}_installer_vanagon_settings" >> ./jenkii/enterprise/projects/pe-installer-vanagon.yaml

##TO DO create a PR and push it
