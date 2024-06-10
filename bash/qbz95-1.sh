#! /bin/bash
#Advanced Experimental Kit (Code95-1) By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

if [[ -f "/etc/os-release" ]]; then
    source /etc/os-release
    distribution=$NAME
    version=$VERSION_ID

    if [[ $distribution == "Debian GNU/Linux" && $version == "12"* ]]; then
        echo "Debian12 Pass"
    else
        echo "ERROR"
        exit 1
    fi
else
    echo "ERROR"
    exit 1
fi

read -p "请输入SSH端口(请确保输入正确以开启UFW防火墙): " PORT

cat > /etc/apt/sources.list <<EOF
deb https://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb-src https://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src https://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb-src https://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src https://mirrors.ustc.edu.cn/debian-security/ bookworm-security main contrib non-free non-free-firmware
EOF

echo "开始更新软件包"
apt update
apt install wget curl vim git sudo -y
apt upgrade -y

echo "开始安装Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo curl -L "https://gh.1888866.xyz/https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker --version
docker-compose --version

cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "16m",
        "max-file": "4"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:a380:a320:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF

systemctl restart docker
sleep 3
docker network create --subnet=172.20.0.0/16 --ipv6 --subnet=fd00:a380:a321:c0::/80 hypernet

echo "开始安装Caddy2"
mkdir -p /root/data/caddy
cd /root/data/caddy
wget https://gh.1888866.xyz/https://github.com/caddyserver/caddy/releases/latest/download/caddy_2.7.6_linux_amd64.tar.gz
tar -xzvf caddy_2.7.6_linux_amd64.tar.gz
rm caddy_2.7.6_linux_amd64.tar.gz
chmod +x /root/data/caddy/caddy
chown root:root /root/data/caddy/caddy

cat <<EOF > /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=root
Group=root
ExecStart=/root/data/caddy/caddy run --environ --config /root/data/caddy/Caddyfile
ExecReload=/root/data/caddy/caddy reload --config /root/data/caddy/Caddyfile --force
WorkingDirectory=/root/data/caddy
TimeoutStopSec=5s
LimitNOFILE=1048576
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF

mkdir -p /root/data/caddy/page

cat <<EOF > /root/data/caddy/page/index.html
<html>
 <head>
 </head>
 <body>
   <h1> Hello World </h1>
   <h2> Hello World </h2>
   <h3> Hello World </h3>
   <h4> Hello World </h4>
   <h5> Hello World </h5>
   <h6> Hello World </h6>
 </body>
</html>

EOF

cat <<EOF > /root/data/caddy/Caddyfile
{
    debug
    http_port 80
    https_port 443
    order cache before rewrite
    cache {
        cache_name CaddyCache
    }
    log {
        level INFO
        output file /root/data/caddy/log/caddy.log {
            roll_size 10MB
            roll_keep 10
        }            
    }        
}

:80 {
	root * /root/data/caddy/page
	try_files {path}/index.html
    file_server
    cache {
         allowed_http_verbs GET
         stale 100s
         ttl 200s
    }
    handle_errors {
	    rewrite * /{err.status_code}
	    reverse_proxy https://http.cat {
		    header_up Host {upstream_hostport}
	    }
    }     
    encode gzip zstd br
}

:9000 {
    reverse_proxy * 172.20.20.10:5001
    cache {
        allowed_http_verbs GET
        stale 300s
        ttl 600s
    }
    encode {
        gzip 5
        br 4
    }
    handle_errors {
	    rewrite * /{err.status_code}
	    reverse_proxy https://http.cat {
		    header_up Host {upstream_hostport}
	    }
    }
}
EOF

./caddy add-package github.com/caddyserver/cache-handler
./caddy add-package github.com/ueffel/caddy-brotli
chown root:root /root/data/caddy/Caddyfile
systemctl daemon-reload
systemctl enable caddy.service
systemctl start caddy.service

echo "开始安装Dockge(将在9000端口启动)"
mkdir -p /root/data/docker_data/dockge
cd /root/data/docker_data/dockge

cat > docker-compose.yml <<EOF
version: "3.8"
services:
  dockge:
    image: louislam/dockge:1
    restart: unless-stopped
    networks:
      hypernet:
        ipv4_address: 172.20.20.10
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./data:/app/data
      - /root/data/docker_data:/root/data/docker_data
    environment:
      - DOCKGE_STACKS_DIR=/root/data/docker_data
      
networks:
  hypernet:
    external: true
    
EOF

docker-compose up -d

echo "开始安装Speedtest-X(将在9001端口启动)"
mkdir -p /root/data/docker_data/speedtest-x
cd /root/data/docker_data/speedtest-x

cat > docker-compose.yml <<EOF
version: '3.9'
services:
    speedtest-x:
        image: badapple9/speedtest-x
        tty: true
        stdin_open: true
        restart: always
        network_mode: host
        environment:
            - WEBPORT=9001
            - IP_SERVICE=ipinfo.io
            - SAME_IP_MULTI_LOGS=true
            - MAX_LOG_COUNT=200
EOF

docker-compose up -d

echo "开始安装UFW"
sudo apt-get update
sudo apt-get install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow $PORT
sudo ufw allow 80
sudo ufw allow 443 
sudo ufw enable
sudo ufw deny from 162.142.125.0/24
sudo ufw deny from 167.94.138.0/24
sudo ufw deny from 167.94.145.0/24
sudo ufw deny from 167.94.146.0/24
sudo ufw deny from 167.248.133.0/24
sudo ufw deny from 2602:80d:1000:b0cc:e::/80
sudo ufw deny from 2620:96:e000:b0cc:e::/80
sudo ufw allow 9000
sudo ufw allow 9001

echo "环境部署完成"