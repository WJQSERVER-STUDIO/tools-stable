#!/bin/bash

# 提示用户输入日志大小限制
read -p "请输入日志大小限制（例如 500M）： " LIMIT
CONFIG_FILE="/etc/systemd/journald.conf"

# 清理日志
echo "正在清理 journal 日志，直到总大小降到 ${LIMIT} ..."
sudo journalctl --vacuum-size=${LIMIT}

# 显示当前日志使用情况
echo "当前 journal 日志使用情况："
journalctl --disk-usage | sed 's/^/  /'  # 使用 sed 格式化输出

# 编辑配置文件以设置永久化日志大小限制
if grep -q "^SystemMaxUse=" "$CONFIG_FILE"; then
    # 如果已经存在该行，则更新它
    sudo sed -i "s/^SystemMaxUse=.*/SystemMaxUse=${LIMIT}/" "$CONFIG_FILE"
else
    # 如果不存在，则添加该行
    echo "SystemMaxUse=${LIMIT}" | sudo tee -a "$CONFIG_FILE" > /dev/null
fi

# 重启 journald 服务以使配置生效
sudo systemctl restart systemd-journald

echo "已更新 journald 配置，设置日志大小限制为 ${LIMIT}。"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O log_menu.sh ${repo_url}systools/log/log_menu.sh && chmod +x log_menu.sh && ./log_menu.sh
else
    echo "脚本结束"
fi