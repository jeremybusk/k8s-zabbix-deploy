# zabbix-k8s
simple zabbix deploy in microk8s and other k8s 

```
git clone https://github.com/jeremybusk/k8s-zabbix-deploy
cd k8s-zabbix-deploy
```

Change namespace if wanted
```
find . -type f -exec sed -i 's/mon-zabbix-zabbix/mon-zabbix-myzabbix/g' {} \;
```
Start it up
```
./up
```

Base64 encoded strings
```
# apt-get install -y cl-base64  # If needed
echo myrootpass | base64
echo bXlyb290cGFzcwo= | base64 --decode
```

Volumes
```
# apt install -y uuid
```

Login to container
```
microk8s.kubectl -n mon-zabbix exec -it zabbix-server-0 -- /bin/bash
```

Login to Zabbix Web
```
username: Admin
userpass: zabbix
```
