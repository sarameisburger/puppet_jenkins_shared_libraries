#!/bin/sh
PE_VERSION=$1
FAMILY=`echo $PE_VERSION | sed "s/\(.*\..*\)\..*/\1/"`
X_FAMILY=`echo $FAMILY | sed "s/\(.*\)\..*/\1/"`
Y_FAMILY=`echo $FAMILY | sed "s/.*\.\(.*\)/\1/"`

echo "
        # ---- ${PE_VERSION}-release ----
        # this is triggered by the PE compose hook and is not part of the normal pipeline
        - '{value_stream}_jar-jar_component-update_{qualifier}':
            scm_branch: '${PE_VERSION}-release'
            pe_family: '${FAMILY}'
            pgdb_user: 'jar_jar'
            pgdb_password: 'how_wude'
            tpb_projects:
                - '{value_stream}_{name}_release-clj_{scm_branch}'
            tpb_property_file: release.props

        - '{value_stream}_{name}_release-clj_{qualifier}':
            slnotifier_notify_success: True
            scm_branch: '${PE_VERSION}-release'" >> ./jenkii/enterprise/projects/jar-jar.yaml


##TO DO create a PR and push it
