#!/bin/bash

step_version=${step_version:-0.15.7}
step_ca_version=${step_ca_version:-0.15.8}

src_dir=${src_dir:-/data/src}
install_dir=${install_dir:-/usr/local/bin}

step_url="https://github.com/smallstep/cli/releases/download/v${step_version}/step_linux_${step_version}_amd64.tar.gz"

step_ca_url="https://github.com/smallstep/certificates/releases/download/v${step_ca_version}/step-certificates_linux_${step_ca_version}_amd64.tar.gz"

password_url=${password_url:-https://github.com/ykhemani/password/releases/download/v0.1/password-linux-amd64.zip}

mkdir -p ${src_dir}

cd ${src_dir}

curl \
  --silent \
  --location \
  ${step_url} \
  --output step_linux_${step_version}_amd64.tar.gz

curl \
  --silent \
  --location \
  ${step_ca_url} \
  --output step-certificates_linux_${step_ca_version}_amd64.tar.gz

curl \
  --silent \
  --location \
  ${password_url} \
  --output password-linux-amd64.zip

tar xvfz step_linux_${step_version}_amd64.tar.gz
tar xvfz step-certificates_linux_${step_ca_version}_amd64.tar.gz

unzip -q -d ${install_dir} password-linux-amd64.zip

cp step-certificates_${step_ca_version}/bin/step-ca ${install_dir}
cp step_${step_version}/bin/step ${install_dir}
