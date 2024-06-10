#! /bin/bash

cd /root/data/docker_data/vanblog
docker compose down
rm -rf /root/data/docker_data/vanblog
mkdir -p /root/data/docker_data/vanblog
cd /root/data/backup
tar -I zstd -xvf vanblog_backup.tar.zst -C /root/data/docker_data/vanblog
cd /root/data/docker_data/vanblog
docker compose up -d