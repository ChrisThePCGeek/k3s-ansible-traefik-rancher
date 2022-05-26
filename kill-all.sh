#!/bin/bash

ansible-playbook reset.yml -i inventory/my-cluster/hosts.ini
#ansible-playbook reset.yml -i inventory/my-cluster/hosts.ini --ask-pass --ask-become-pass
