#!/bin/bash

# 添加警告提示
read -p "警告：执行此脚本将配置 UFW 并启用防火墙。确保您具有必要的权限并理解脚本的功能。继续吗？(Y/N): " confirm
if [[ $confirm != "Y" && $confirm != "y" ]]; then
  echo "脚本已取消。"
  exit 0
fi

# 安装 UFW
echo "正在安装 UFW..."
sudo apt-get update
sudo apt-get install ufw -y

# 配置 UFW 默认规则
echo "配置 UFW 默认规则..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 获取自定义 SSH 端口号
read -p "请输入自定义的 SSH 端口号: " ssh_port

# 打开自定义的 SSH 端口
echo "打开 SSH 端口 $ssh_port..."
sudo ufw allow $ssh_port

# 打开其他所需的端口
echo "打开其他所需的端口..."
sudo ufw allow 80    # 修改为您的 HTTP 端口号
sudo ufw allow 443   # 修改为您的 HTTPS 端口号

# 启用 UFW
echo "启用 UFW..."
sudo ufw enable

echo "UFW 已成功部署！"
echo "防火墙已启用，并且只允许指定的端口通过。"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O firewall_menu.sh ${repo_url}systools/firewall/firewall_menu.sh && chmod +x firewall_menu.sh && ./firewall_menu.sh
else
    echo "脚本结束"
fi
