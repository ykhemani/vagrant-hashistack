# vagrant-hashistack

Vagrantfile for creating a Vagrant box based on [ubuntu/xenial (Ubuntu 18.04)](https://app.vagrantup.com/ubuntu/boxes/xenial64) with the following [HashiCorp](https://hashicorp.com) Software:
* Vault Enterprise 1.6.2 with HSM Support
* Consul Enterprise 1.9.3
* Nomad Enterprise 1.0.3
* Terraform 0.14.6
* Packer 1.6.6
* consul-template 0.25.1
* envconsul 0.11.0

## Prerequisites

Download and install the required software if you don't already have it installed.

The instructions below reference the use of [Homebrew](https://brew.sh/). You can also download and install the software interactively.

1. [VirtualBox](https://www.virtualbox.org/).

```
brew install virtualbox
```

2. [Vagrant](https://www.vagrantup.com/).

```
brew install vagrant
```

## Building

```
vagrant up
```

## Usage

The resulting box is available on [Vagrant Cloud](https://app.vagrantup.com/khemani/boxes/ubuntu-bionic64-hashistack-enterprise). Follow the instructions in Vagrant Cloud for using the image.

