#!/bin/sh
PE_VERSION=$1

sed -i "/init release anchor point/a \
\        - pm_conditional-step:\n\
\            m_scm_branch: '${PE_VERSION}-release'\n\
\            m_name: '{name}'\n\
\            m_value_stream: '{value_stream}'\n\
\            m_projects: '{value_stream}_pe-acceptance-tests_packaging_promotion_${PE_VERSION}-release,{value_stream}_{name}_init-cinext_smoke-upgrade_${PE_VERSION}-release,{value_stream}_{name}_init-cinext_split-smoke-upgrade_${PE_VERSION}-release,{value_stream}_jar-jar_component-update_${PE_VERSION}-release'" resources/job-templates/init.yaml

##TO DO create a PR and push it
