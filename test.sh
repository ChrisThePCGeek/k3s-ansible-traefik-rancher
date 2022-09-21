#!/bin/bash

#ansible-playbook site.yml -i inventory/my-cluster/hosts.ini --ask-pass --ask-become-pass
ansible-playbook --syntax-check site.yml -i inventory/my-cluster/hosts.ini