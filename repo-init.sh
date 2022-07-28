#!/bin/bash
echo "creating inventory path and copying sample to inventory/my-cluster.."
cp -R inventory/sample inventory/my-cluster
echo "Done."
echo "===================================================================="
echo "Next step: Edit your inventory/my-cluster/hosts.ini"
echo "Second: Edit inventory/my-cluster/group_vars/all.yml to your liking"
echo "===================================================================="
echo "more information and detailed steps in the README or on https://thepcgeek.net"