# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set HashiCorp Software Versions
vault_version           = ENV['vault_version']           || '1.6.2'
consul_version          = ENV['consul_version']          || '1.9.3'
nomad_version           = ENV['nomad_version']           || '1.0.3'
terraform_version       = ENV['terraform_version']       || '0.14.7'
packer_version          = ENV['packer_version']          || '1.7.0'
consul_template_version = ENV['consul_template_version'] || '0.25.2'
envconsul_version       = ENV['envconsul_version']       || '0.11.0'

vault_enterprise        = ENV['vault_enterprise']        || '' # set to 'ent' to install Vault Enterprise or 'ent.hsm' to instsall Vault Enterprise with HSM support; leave it blank for Vault Open Source.
consul_enterprise       = ENV['consul_enterprise']       || '' # set to 'ent' to install Consul Enterprise
nomad_enterprise        = ENV['nomad_enterprise']        || '' # set to 'ent' to install Nomad Enterprise

step_ca_version         = ENV['step_ca_version']         || '0.15.8'
step_version            = ENV['step_version']            || '0.15.7'

box                     = ENV['box']                     || 'ubuntu/bionic64'
box_version             = ENV['box_version']             || '20210218.0.0'

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
  config.vm.box         = box
  config.vm.box_version = box_version

  # bootstrap
  config.vm.provision "file", source: "./files/.", destination: bootstrap_dir

  config.vm.provision "shell", inline: bootstrap_script

  # step-ca download
  config.vm.provision "shell" do |step|
    step.env = {
      'step_ca_version'     => step_ca_version,
      'step_version'        => step_version
    }
    step.path = 'files/step_ca_install.sh'
  end

  # vault download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'vault',
      'software_version'    => vault_version,
      'software_enterprise' => vault_enterprise
    }
    s.path = 'files/hashi_install.sh'
  end

  # consul download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'consul',
      'software_version'    => consul_version,
      'software_enterprise' => consul_enterprise
    }
    s.path = 'files/hashi_install.sh'
  end

  # nomad download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'nomad',
      'software_version'    => nomad_version,
      'software_enterprise' => nomad_enterprise
    }
    s.path = 'files/hashi_install.sh'
  end

  # terraform download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'terraform',
      'software_version'    => terraform_version
    }
    s.path = 'files/hashi_install.sh'
  end

  # packer download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'packer',
      'software_version'    => packer_version
    }
    s.path = 'files/hashi_install.sh'
  end

  # consul-template download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'consul-template',
      'software_version'    => consul_template_version
    }
    s.path = 'files/hashi_install.sh'
  end

  # envconsul download
  config.vm.provision "shell" do |s|
    s.env = {
      'software'            => 'envconsul',
      'software_version'    => envconsul_version
    }
    s.path = 'files/hashi_install.sh'
  end

end

