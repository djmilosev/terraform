# GCP-dmilosevic

Capstone project on DevOps to Infrastructure Engineer (GCP) course.

## Prerequisites

- [Ansible v2.7.x](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed,
- [Terraform v0.12.x](https://www.terraform.io/downloads.html) installed.

## Ansible

Contains a playbook for:

- Installing Apache Web Server on Ubuntu 16 GCE instances,
- Seting up template of simple HTML page.


## Terrafrom

Contains terraform files to setup the following:

- Create 3 Google Compute Engine instances,
- Set up firewall rules allowing ports 22 and 80, so instances are accessible through SSH and WebServers are accessible via the internet,
- Create instance group of 3 hosts to run apache,
- Set up TCP healthcheck,
- Set up ILB: global backend service + forwarding rule

## Usage

  Configure infrastructure with Terraform:

    cd terraform; terraform apply .

  Provision Apache HTTP Web Server with simple HTML website:

    cd ansible; ansible-playbook -i inventory/ansible-hosts deploy.yml
