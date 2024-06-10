#! /bin/bash

mkdir -p /root/data/backup
cd /root/data/docker_data/vanblog
tar -cf /root/data/backup/vanblog_backup.tar .
cd /root/data/backup
zstd -f vanblog_backup.tar -o vanblog_backup.tar.zst
rm vanblog_backup.tar