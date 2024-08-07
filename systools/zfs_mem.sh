#!/bin/bash

# 检查输入参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <max_memory>"
    echo "Example: $0 1G or $0 1200M"
    exit 1
fi

# 解析输入
max_input=$1

# 转换输入为字节
case ${max_input: -1} in
    G) max_bytes=$(( ${max_input%G} * 1024 * 1024 * 1024 )) ;;
    M) max_bytes=$(( ${max_input%M} * 1024 * 1024 )) ;;
    K) max_bytes=$(( ${max_input%K} * 1024 )) ;;
    *) echo "Invalid size format. Use 1G, 1200M, etc."; exit 1 ;;
esac

# 设置 zfs_arc_max
echo "Setting zfs_arc_max to $max_bytes bytes"
echo $max_bytes | sudo tee /sys/module/zfs/parameters/zfs_arc_max

# 计算并设置 zfs_arc_min
min_bytes=$(( max_bytes - 1024 * 1024 ))
echo "Setting zfs_arc_min to $min_bytes bytes"
echo $min_bytes | sudo tee /sys/module/zfs/parameters/zfs_arc_min

# 持久化设置
echo "options zfs zfs_arc_max=$max_bytes" | sudo tee -a /etc/modprobe.d/zfs.conf
echo "options zfs zfs_arc_min=$min_bytes" | sudo tee -a /etc/modprobe.d/zfs.conf

# 更新 initramfs
sudo update-initramfs -u

echo "ZFS memory settings updated successfully."