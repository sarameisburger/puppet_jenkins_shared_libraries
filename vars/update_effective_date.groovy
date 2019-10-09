def call(String effectiveDate, String branch, String ticket) {

  if (effectiveDate =~ '^20[0-9]{2}[.](0[1-9]|1[0-2])[.](0[1-9]|[12][0-9]|3[01])$') {
    println "${effectiveDate} is a valid EFFECTIVE_DATE"
  } else {
    println "${effectiveDate} is an invalid EFFECTIVE_DATE. Must be in the format YYYY.MM.DD with valid dates."
    throw new Exception("Invalid effective date")
  }

  sh """
  #!/usr/bin/env bash

  rm -rf ./pe-installer-shim
  git clone git@github.com:puppetlabs/pe-installer-shim ./pe-installer-shim
  cd pe-installer-shim
  git checkout "${branch}"
  sed -i "/readonly EFFECTIVE_DATE=.*/c\readonly EFFECTIVE_DATE='${effectiveDate}'" ./puppet-enterprise-installer
  git add puppet-enterprise-installer

  git commit -m "(${ticket}) Update EFFECTIVE_DATE to ${effectiveDate}"
  git push origin "${branch}"

  # Cleanup
  cd ..
  rm -rf pe-installer-shim
  """
}