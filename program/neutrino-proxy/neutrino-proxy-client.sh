#!/bin/bash

#Script original by WJQserver-Studio&&Neutrino-Proxy Original by Dromara

clear

# 创建目录
mkdir -p /root/data/neutrino-proxy
cd /root/data/neutrino-proxy

#由WJQserver-Studio提供的镜像仓库下载
wget https://raw.githubusercontent.com/WJQSERVER/neutrino-proxy/main/linux/neutrino-proxy-client.tar.gz

#解压缩
tar -xzvf neutrino-proxy-client.tar.gz
rm neutrino-proxy-client.tar.gz

#赋权
chmod +x /root/data/neutrino-proxy/neutrino-proxy-client

# 从用户输入中获取端口
read -p "请输入服务器地址: " serverip
read -p "请输入服务器端口: " serverport
read -p "请输入Key: " key

# 创建 app.yml 文件
cat > app.yml <<EOF
solon.logging.logger:
  "root":
    level: info

neutrino:
  proxy:
    tunnel:
      # 线程池相关配置，用于技术调优，可忽略
      thread-count: 50
      # 隧道SSL证书配置
      #key-store-password: 123456
      #jks-path: classpath:/test.jks
      # 服务端IP
      server-ip: $serverip
      # 服务端端口(对应服务端app.yml中的tunnel.port、tunnel.ssl-port)
      server-port: $serverport
      # 是否启用SSL(注意：该配置必须和server-port对应上)
      ssl-enable: false
      # 客户端连接唯一凭证
      license-key: $key
      # 客户端唯一身份标识（可忽略，若不设置首次启动会自动生成）
      client-id:
      # 是否开启隧道传输报文日志(日志级别为debug时开启才有效)
      transfer-log-enable: false
      # 是否开启心跳日志
      heartbeat-log-enable: false
      # 重连设置
      reconnection:
        # 重连间隔（秒）
        interval-seconds: 10
        # 是否开启无限重连(未开启时，客户端license不合法会自动停止应用，开启了则不会，请谨慎开启)
        unlimited: false
    client:
      udp:
        # 线程池相关配置，用于技术调优，可忽略
        boss-thread-count: 5
        work-thread-count: 20
        # udp傀儡端口范围
        puppet-port-range: 10000-10500
        # 是否开启隧道传输报文日志(日志级别为debug时开启才有效)
        transfer-log-enable: false

EOF

# 创建服务文件
cat <<EOF > /etc/systemd/system/neutrino-client.service
[Unit]
Description=Neutrino Proxy Service Client
After=network.target

[Service]
ExecStart=/root/data/neutrino-proxy/neutrino-proxy-client
WorkingDirectory=/root/data/neutrino-proxy
Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd服务
systemctl daemon-reload

# 启用服务
systemctl enable neutrino-client.service

# 启动服务
systemctl start neutrino-client.service

# 检查服务状态
systemctl status neutrino-client.service

# 提示服务访问地址
echo "服务已成功启动！"

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