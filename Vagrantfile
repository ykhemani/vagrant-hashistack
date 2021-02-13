# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set HashiCorp Software Versions
vault_version           = "1.6.2"
consul_version          = "1.9.3"
nomad_version           = "1.0.3"
terraform_version       = "0.14.6"
packer_version          = "1.6.6"
consul_template_version = "0.25.1"
envconsul_version       = "0.11.0"

vault_enterprise        = 'ent.hsm'
consul_enterprise       = 'ent'
nomad_enterprise        = 'ent'

# The rest of these variables can be set as is, but override as needed.
install_dir             = '/usr/local/bin'
hashi_base_url          = 'https://releases.hashicorp.com'
hashi_download_dir      = '/data/src/hashicorp'

bootstrap_dir           = '/tmp/hashi_bootstrap'
bootstrap_script        = bootstrap_dir + '/bootstrap.sh'

vault                   = install_dir + '/vault'
vault_config_dir        = '/etc/vault.d'
vault_user              = 'vault'

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # bootstrap
  config.vm.provision "file", source: "./files/.", destination: bootstrap_dir

  config.vm.provision "shell", inline: bootstrap_script

  # vault download
  config.vm.provision "shell" do |s|
    s.inline = <<-VAULT
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    VAULT
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'vault', 
      vault_version, 
      vault_enterprise
    ]
  end

  # consul download
  config.vm.provision "shell" do |s|
    s.inline = <<-CONSUL
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    CONSUL
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'consul', 
      consul_version, 
      consul_enterprise
    ]
  end

  # nomad download
  config.vm.provision "shell" do |s|
    s.inline = <<-NOMAD
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    NOMAD
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'nomad', 
      nomad_version, 
      nomad_enterprise
    ]
  end

  # terraform download
  config.vm.provision "shell" do |s|
    s.inline = <<-TERRAFORM
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    TERRAFORM
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'terraform', 
      terraform_version
    ]
  end

  # packer download
  config.vm.provision "shell" do |s|
    s.inline = <<-PACKER
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
      PACKER
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'packer', 
      packer_version
    ]
  end

  # consul-template download
  config.vm.provision "shell" do |s|
    s.inline = <<-CONSUL_TEMPLATE
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    CONSUL_TEMPLATE
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'consul-template', 
      consul_template_version
    ]
  end

  # envconsul download
  config.vm.provision "shell" do |s|
    s.inline = <<-CONSUL_TEMPLATE
      sudo mkdir -p $1
      sudo bash /tmp/hashi_bootstrap/hashi_install.sh $1 $2 $3 $4 $5 $6
    CONSUL_TEMPLATE
    s.args = [
      hashi_download_dir, 
      install_dir, 
      hashi_base_url, 
      'envconsul', 
      envconsul_version
    ]
  end

end

