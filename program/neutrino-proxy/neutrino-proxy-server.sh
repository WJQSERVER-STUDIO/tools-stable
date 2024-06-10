#!/bin/bash

#Script original by WJQserver-Studio&&Neutrino-Proxy Original by Dromara

clear

# 创建目录
mkdir -p /root/data/neutrino-proxy
cd /root/data/neutrino-proxy

#由WJQserver-Studio提供的镜像仓库下载
wget https://raw.githubusercontent.com/WJQSERVER/neutrino-proxy/main/linux/neutrino-proxy-server.tar.gz

#解压缩
tar -xzvf neutrino-proxy-server.tar.gz
rm neutrino-proxy-server.tar.gz

#赋权
chmod +x /root/data/neutrino-proxy/neutrino-proxy-server

# 从用户输入中获取端口
read -p "请输入WebUI端口: " webui
read -p "请输入隧道端口: " tunnel
read -p "请输入隧道SSL端口: " tunnelssl
read -p "请输入HTTP端口: " http
read -p "请输入HTTPS端口: " https
read -p "请设定数据库用户名: " user
read -p "请设定数据库密码: " password

# 创建 app.yml 文件
cat > app.yml <<EOF
server:
  # 服务端web端口，用于支持HTTP接口，管理后台页面访问
  port: $webui
# 日志级别
solon.logging:
  logger:
    "root":
      level: info
  appender:
    file:
      level: info

neutrino:
  proxy:
    # 隧道相关配置-用于维持服务端与客户端的通信
    tunnel:
      # 线程池相关配置，用于技术调优，可忽略
      boss-thread-count: 2
      work-thread-count: 10
      # 隧道非SSL端口
      port: $tunnel
      # 隧道SSL端口
      ssl-port: $tunnelssl
      # 隧道SSL证书配置
      key-store-password: 123456
      key-manager-password: 123456
      jks-path: classpath:/test.jks
      # 是否开启隧道传输报文日志(日志级别为debug时开启才有效)
      transfer-log-enable: false
      # 是否开启心跳日志
      heartbeat-log-enable: false
    server:
      tcp:
        # 线程池相关配置，用于技术调优，可忽略
        boss-thread-count: 5
        work-thread-count: 20
        # http代理端口，默认80
        http-proxy-port: $http
        # https代理端口，默认443 （需要配置域名、证书）
        https-proxy-port: $https
        # 如果不配置，则不支持域名映射
        #domain-name:
        # https证书配置
        #key-store-password:
        #jks-path:
        # 是否开启代理服务报文日志(日志级别为debug时开启才有效)
        transfer-log-enable: false
      udp:
        # 线程池相关配置，用于技术调优，可忽略
        boss-thread-count: 5
        work-thread-count: 20
        # 是否开启代理服务报文日志(日志级别为debug时开启才有效)
        transfer-log-enable: false
  data:
    db:
      # 数据库类型，目前支持h2、mysql、mariadb
      type: h2
      # 数据库连接URL
      url: jdbc:h2:file:./data/db;MODE=MySQL;AUTO_SERVER=TRUE
      # 数据库用户名
      username: $user
      # 数据库密码
      password: $password
EOF

# 创建服务文件
cat <<EOF > /etc/systemd/system/neutrino-proxy.service
[Unit]
Description=Neutrino Proxy Service
After=network.target

[Service]
ExecStart=/root/data/neutrino-proxy/neutrino-proxy-server
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
systemctl enable neutrino-proxy.service

# 启动服务
systemctl start neutrino-proxy.service

# 检查服务状态
systemctl status neutrino-proxy.service

# 提示服务访问地址
echo "服务已成功启动！"
echo "面板默认账户:admin"
echo "面板默认密码:123456"
echo "请访问以下地址来访问您的服务："
echo "http://<服务器IP>:$webui"

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