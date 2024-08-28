#!/bin/bash

# 检查是否以 root 用户运行
if [ "$(id -u)" -ne 0 ]; then
  echo "请以 root 用户运行此脚本"
  exit 1
fi

# 提示用户输入 VM 或 LXC ID
read -p "请输入要强制关闭的 VM 或 LXC ID: " vmid

# 检查 ID 是否存在
if qm status $vmid >/dev/null 2>&1; then
  echo "正在强制关闭虚拟机 $vmid..."
  qm stop $vmid
elif pct status $vmid >/dev/null 2>&1; then
  echo "正在强制关闭 LXC 容器 $vmid..."
  pct stop $vmid
else
  echo "错误: 找不到 ID $vmid 的虚拟机或 LXC 容器"
  exit 1
fi

echo "操作完成。"