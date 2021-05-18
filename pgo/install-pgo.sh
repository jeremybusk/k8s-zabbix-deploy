#!/usr/bin/env bash
set -e

microk8s.kubectl create namespace pgo || true
rm -rf postgres-operator || true
git clone https://github.com/CrunchyData/postgres-operator.git
cd postgres-operator
git checkout REL_4_6
cd installers/kubectl
microk8s.kubectl apply -f postgres-operator.yml
sed -i 's/^PGO_CMD.*/PGO_CMD="${PGO_CMD-microk8s.kubectl}"/' client-setup.sh

export PGOUSER="${HOME?}/.pgo/pgo/pgouser"
export PGO_CA_CERT="${HOME?}/.pgo/pgo/client.crt"
export PGO_CLIENT_CERT="${HOME?}/.pgo/pgo/client.crt"
export PGO_CLIENT_KEY="${HOME?}/.pgo/pgo/client.key"
export PGO_APISERVER_URL='https://127.0.0.1:8443'
export PGO_NAMESPACE=pgo

cat <<EOF >> ~/.bashrc
export PGOUSER="${HOME?}/.pgo/pgo/pgouser"
export PGO_CA_CERT="${HOME?}/.pgo/pgo/client.crt"
export PGO_CLIENT_CERT="${HOME?}/.pgo/pgo/client.crt"
export PGO_CLIENT_KEY="${HOME?}/.pgo/pgo/client.key"
export PGO_APISERVER_URL='https://127.0.0.1:8443'
export PGO_NAMESPACE=pgo
EOF

./client-setup.sh

export PATH="$HOME/.pgo/pgo:$PATH"
grep "export PATH" ~/.bashrc && echo PATH update exists || echo export PATH="$HOME/.pgo/pgo:$PATH" >> ~/.bashrc
# if [ -z "${PATH-}" ]; then export PATH=/usr/local/bin:/usr/bin:/bin; fi
sed -i ~/.bashrc export PATH="$HOME/.pgo/pgo:$PATH"
/root/.pgo/pgo/pgo -h
pgo -h

# rm -rf postgres-operator
