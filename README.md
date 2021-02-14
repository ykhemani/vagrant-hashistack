# vagrant-hashistack

Vagrantfile for creating a [Vagrant](https://vagrantup.com) box based on [ubuntu/xenial (Ubuntu 18.04)](https://app.vagrantup.com/ubuntu/boxes/xenial64) with the following [HashiCorp](https://hashicorp.com) Software:
* [Vault](https://vaultproject.io) 1.6.2
* [Consul](https://consul.io) 1.9.3
* [Nomad](https://nomadproject.io) 1.0.3
* [Terraform](https://terraform.io) 0.14.6
* [Packer](https://packer.io) 1.6.6
* [consul-template](https://github.com/hashicorp/consul-template) 0.25.1
* [envconsul](https://github.com/hashicorp/envconsul) 0.11.0

## Software Versions and Enterprise Support

You may override the version of each of the aforementioned pieces of software by setting the appropriate environment variable, or by updating [Vagrantfile](Vagrantfile).

* Vault: `vault_version`
* Consul: `consul_version`
* Nomad: `nomad_version`
* Terraform: `terraform_version`
* Packer: `packer_version`
* consul-template: `consul_template_version`
* envconsul: `envconsul_version`

By default, the Open Source edition of each software will be installed. You may install the Enterprise edition of Vault, Consul or Nomad by setting the appropriate environment variable, or by updating [Vagrantfile](Vagrantfile).

* Vault Enterprise: set `vault_enterprise` to `ent` for Vault Enterpsie or to `ent.hsm` for Vault Enterprise with HSM Support.
* Consul Enterprise: set `consul_enterprise` to `ent`
* Nomad Enterprise: set `nomad_enterprise` to `ent`

For example:

```
export vault_version="1.5.4"
export vault_enterprise="ent.hsm"
```

## Prerequisites

Download and install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) if you don't already have it installed.

The instructions below reference the use of [Homebrew](https://brew.sh/). You can also download and install the software interactively.

1. [VirtualBox](https://www.virtualbox.org/).

```
brew install virtualbox
```

2. [Vagrant](https://www.vagrantup.com/).

```
brew install vagrant
```

## Building, Packaging and Publishing the HashiStack Box

Thie instructions below are for building and publishing a HashiStack image. If you want to use the resulting box, please see the [Usage](#Usage) section below.

Bring up a box using the Vagrantfile in this repo.

```
vagrant up
```

SSH into the box and clean up the guest host in preparation for packaging and publishing the box.

```
vagrant ssh
```

Clean up the guest host filesystem.

```
sudo su - 

apt-get -y autoremove
apt-get clean
apt-get autoclean
unset HISTFILE
rm -f /root/.bash_history /home/vagrant/.bash_history
find /var/log -type f | while read f; do echo -ne '' > $f; done
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
exit
```

Package up the box.
```
vagrant package --output hashistack.box
```

Calculate the sha256sum. This will be required when you publish the box to Vagrant Cloud.
```
shasum -a 256 -b hashistack.box
```

Destroy the guest VM.
```
vagrant destroy --force --graceful
```

Upload the Box to Vagrant Cloud.

## Usage

Both Enterprise and Open Source editions of the boxes from the Vagrantfile in this repo are published and available on [Vagrant Cloud](https://app.vagrantup.com).

* [HashiStack Enterprise](https://app.vagrantup.com/khemani/boxes/ubuntu-bionic64-hashistack-enterprise)
* [HashiStack Open Source](https://app.vagrantup.com/khemani/boxes/ubuntu-bionic64-hashistack)

Follow the instructions in Vagrant Cloud for using the image.

