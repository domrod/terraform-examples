#cloud-config
package_upgrade: true
packages:
  - nginx
  - python-pip
# Cloud config for gitlab server
repo_update: true
repo_upgrade: all

output:
  all: '| tee -a /var/log/cloud-init-output.log'