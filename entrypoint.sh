#!/bin/sh -l
set -eu

TERRAFORM_VERSION="${1}"

ARCHITECTURE="amd64"
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

cd -

echo 'test<<EOF' >> $GITHUB_OUTPUT
cat entrypoint.sh >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT
#echo "Hello $1"
#time=$(date)
#echo "time=$time" >> $GITHUB_OUTPUT
