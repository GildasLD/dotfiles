# Services

```sh
vim /etc/systemd/system/small-c-server.service
```

```sh
cat <<EOF > /etc/systemd/system/small-c-server.service
[Unit]
Description=Service pour exécuter small-c-server au démarrage
After=network.target

[Service]
ExecStart=/home/gildas/small-c-server/small-c-server.bin
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
```

```sh
systemctl daemon-reload
systemctl start small-c-server.service
```
