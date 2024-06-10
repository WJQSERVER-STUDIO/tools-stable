#!/bin/bash

clear

# 创建目录
mkdir -p /root/data/#
cd /root/data/#

#下载
wget https://github.com/user/program/releases/latest/download/

#解压
tar -xzvf #
rm #

#赋权
chmod +x /root/data/#/#

# 创建服务文件
cat <<EOF > /etc/systemd/system/#.service
#
EOF

# 重新加载systemd服务
systemctl daemon-reload

# 启用服务
systemctl enable #.service

# 启动服务
systemctl start #.service

# 检查服务状态
systemctl status #.service

# 提示服务访问地址
echo "服务已成功启动！"
echo "请访问以下地址来访问您的服务："
echo "http://<服务器IP>:$PORT"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O program-menu.sh ${repo_url}program/program-menu.sh && chmod +x program-menu.sh && ./program-menu.sh
else
    echo "脚本结束"
fi