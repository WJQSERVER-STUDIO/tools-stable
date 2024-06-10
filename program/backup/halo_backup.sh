#! /bin/bash

mkdir -p /root/data/backup
cd /root/data/docker_data/halo
tar -cf /root/data/backup/halo_backup.tar .
cd /root/data/backup
zstd -f halo_backup.tar -o halo_backup.tar.zst
rm halo_backup.tar