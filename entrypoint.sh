#!/bin/sh -l
set -eu

TERRAFORM_VERSION="${1}"

ARCHITECTURE="amd64"

if [[ ! -d "${GITHUB_WORKSPACE}" ]]; then
	mkdir -p /github/workspace
	cd /github/workspace
	cp -ar /sample-hcl/. /github/workspace
fi
if ! which terraform > /dev/null 2>&1; then
	cd /tmp
	wget \
		--quiet \
		"$(printf '%s' \
		"https://releases.hashicorp.com/terraform" \
		"/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCHITECTURE}.zip" \
		)"
	unzip terraform_*.zip
	mv "terraform" "/usr/local/bin/terraform"
	terraform version
fi
cd "${GITHUB_WORKSPACE}"
terraform init > /dev/null
terraform plan -out=tfplan > /dev/null
terraform show -json tfplan | jq '.planned_values' > /tmp/planned.tf.json
cat /tmp/planned.tf.json

#echo 'test<<EOF' >> $GITHUB_OUTPUT
#cat $0 >> $GITHUB_OUTPUT
#echo 'EOF' >> $GITHUB_OUTPUT
