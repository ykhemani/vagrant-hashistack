#!/bin/bash

hashi_download_dir=${hashi_download_dir:-/data/src/hashicorp}
install_dir=${install_dir:-/usr/local/bin}
hashi_base_url=${hashi_base_url:-https://releases.hashicorp.com}

software=${software}
software_version=${software_version}
software_enterprise=${software_enterprise}
sofware_beta=${software_beta}

function usage() {
  echo "Download and install HashiCorp Software."
  echo 
  echo "Usage: "
  echo "  software=<software> \\"
  echo "  software_version=<software_version> \\"
  echo "  [software_enterprise=ent] \\"
  echo "  [sofware_beta=<beta> \\"
  echo "  [hashi_download_dir=<hashi_download_dir>] \\"
  echo "  [install_dir=<install_dir>] \\"
  echo "  [hashi_base_url=<hashi_base_url>] \\"
  echo "  $0"

  echo 

  echo " e.g.: "
  echo "  software=vault \\"
  echo "  software_version=1.6.2 \\"
  echo "  $0"

  echo " e.g.: "
  echo "  software=consul \\"
  echo "  software_version=1.9.3 \\"
  echo "  software_enterprise=ent \\"
  echo "  sofware_beta=beta2 \\"
  echo "  $0"

  echo " e.g.: "
  echo "  software=vault-plugin-database-oracle \\"
  echo "  software_version=0.3.0 \\"
  echo "  install_dir=/data/vault/plugins \\"
  echo "  $0"
}

function show_inputs() {
  echo "hashi_download_dir is ${hashi_download_dir}"
  echo "install_dir is ${install_dir}"
  echo "hashi_base_url is ${hashi_base_url}"
  echo "software is ${software}"
  echo "software_version is ${software_version}"
  echo "software_enterprise is ${software_enterprise}"
  echo "sofware_beta is ${sofware_beta}"
}

error=0
if [ "${hashi_download_dir}" == "" ]
then
  error=1
elif [ "${install_dir}" == "" ]
then
  error=1
elif [ "${hashi_base_url}" == "" ]
then
  error=1
elif [ "${software}" == "" ]
then
  error=1
fi

if [ "${error}" != "0" ]
then
  usage
  echo 
  show_inputs
  exit ${error}
fi

if [ "${software_version}" == "" ] || [ "${software_version}" == "latest" ]
then
  echo "getting latest ${software} version ${software_enterprise} ${software_beta}"
  url=$(curl -sL ${hashi_base_url}/${software}/index.json | jq -r '.versions[].builds[].url' | egrep "${software}_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}[\+]?${software_enterprise}${software_beta}_linux.*amd64" | sort -V | tail -1)
else
  if [ "${software_enterprise}" != "" ]
  then
    software_enterprise="+${software_enterprise}"
  fi

  if [ "${software_beta}" != "" ]
  then
    software_beta="-${software_beta}"
  fi
  url=${hashi_base_url}/${software}/${software_version}${software_enterprise}${software_beta}/${software}_${software_version}${software_enterprise}${software_beta}_linux_amd64.zip
fi

echo "Downloading $url"

mkdir -p ${hashi_download_dir} ${install_dir} && \
  curl \
    --silent \
    --location \
    ${url} \
    --output ${hashi_download_dir}/${software}.zip && \
  unzip -q -d ${install_dir} ${hashi_download_dir}/${software}.zip

echo $(${install_dir}/${software} -version)
