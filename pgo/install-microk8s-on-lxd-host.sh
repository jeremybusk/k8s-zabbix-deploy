#!/usr/bin/env bash
set -e

snap install microk8s --classic

cat > /etc/rc.local <<EOF
#!/bin/bash
apparmor_parser --replace /var/lib/snapd/apparmor/profiles/snap.microk8s.*
exit 0
EOF
chmod +x /etc/rc.local

microk8s enable dns ingress storage
