FROM debian:12.5-slim

# 更新并安装所需的软件包
RUN apt-get update && apt-get install -y \
    sed wget curl vim tar zstd

# 下载和安装 Caddy
RUN mkdir -p /data/caddy/config
RUN mkdir -p /data/caddy/config.d
RUN wget -O /data/caddy/caddy.tar.gz https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/program/caddy/caddy.tar.gz
RUN tar -xzvf /data/caddy/caddy.tar.gz -C /data/caddy 
RUN rm /data/caddy/caddy.tar.gz 
RUN chmod +x /data/caddy/caddy 
RUN chown www-data:www-data /data/caddy/caddy 
RUN wget -O /data/caddy/Caddyfile https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/caddy/Caddyfile
RUN wget -O /usr/local/bin/init.sh https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/web/caddy/init.sh 
RUN chmod +x /usr/local/bin/init.sh

CMD ["/usr/local/bin/init.sh"]
