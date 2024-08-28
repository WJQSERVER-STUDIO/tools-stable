#!/bin/bash

# 获取宿主机信息
host_info=$(pveperf status | grep "Host information")
echo "宿主机信息:"
echo "$host_info"
echo

# 获取资源占用率
cpu_usage=$(pveperf status | grep "CPU usage" | awk -F': ' '{print $2}')
mem_usage=$(pveperf status | grep "Memory usage" | awk -F': ' '{print $2}')
disk_usage=$(pveperf status | grep "Disk usage" | awk -F': ' '{print $2}')
network_usage=$(pveperf status | grep "Network usage" | awk -F': ' '{print $2}')
echo "资源占用率:"
echo "CPU 使用率: $cpu_usage"
echo "内存使用率: $mem_usage"
echo "磁盘使用率: $disk_usage"
echo "网络使用率: $network_usage"
echo

# 获取文件系统信息
fs_info=$(pvesm status)
echo "文件系统信息:"
echo "$fs_info"
echo

# 获取虚拟机状态
vm_status=$(vm list)
echo "虚拟机状态:"
echo "$vm_status"
echo

# 获取 CT 状态
ct_status=$(pct list --vmid 100-199)
echo "CT 状态:"
echo "$ct_status"
