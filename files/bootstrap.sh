#!/bin/bash

# This script updates the OS and installs the packes listed below.

sleep 30
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
  gnupg \
  openssl \
  jq \
  unzip \
  htop \
  ldap-utils \
  libltdl7 \
  libsofthsm2 \
  softhsm2 \
  opensc
