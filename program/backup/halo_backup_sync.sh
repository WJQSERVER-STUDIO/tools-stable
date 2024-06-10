#! /bin/bash

cd /root/data/docker_data/halo
docker compose down
rm -rf /root/data/docker_data/halo
mkdir -p /root/data/docker_data/halo
cd /root/data/backup
tar -I zstd -xvf halo_backup.tar.zst -C /root/data/docker_data/halo
cd /root/data/docker_data/halo
docker compose up -d