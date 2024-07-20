#!/bin/bash

#安装依赖
apt install util-linux -y

# 检查是否已经存在 Swap 文件
if grep -q "swapfile" /etc/fstab; then
  echo "Swap 文件已存在，是否删除？(y/n)"
  read answer
  if [ "$answer" == "y" ]; then
    # 停用和删除 Swap 文件
    sudo swapoff /swapfile
    sudo rm /swapfile
    sudo sed -i '/swapfile/d' /etc/fstab
    echo "Swap 文件已删除！"
  else
    echo "Swap 文件未删除。"
  fi
fi

echo "是否创建新的 Swap 文件？(y/n)"
read answer
if [ "$answer" == "y" ]; then
  echo "请输入 Swap 文件的大小 (例如 512M，1G)："
  read swap_size

  # 提取 Swap 文件大小和单位
  swap_size_value=${swap_size%[MG]}
  swap_size_unit=${swap_size: -1}

  # 根据单位计算 Swap 文件大小
  if [ "$swap_size_unit" == "G" ]; then
    swap_size_mb=$(($swap_size_value * 1024))
  else
    swap_size_mb=$swap_size_value
  fi

  # 创建 Swap 文件
  echo "正在创建 Swap 文件..."
  sudo fallocate -l "$swap_size_mb"M /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile

  # 启用 Swap 文件
  echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
  echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
  echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p

  echo "Swap 文件创建并启用成功！"
else
  echo "未创建新的 Swap 文件。"
fi

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O systools-menu.sh ${repo_url}systools/systools-menu.sh && chmod +x systools-menu.sh && ./systools-menu.sh
else
    echo "脚本结束"
fi
