#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

# 检查是否以 root 权限运行
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 权限运行此脚本"
  exit 1
fi

# 检测系统是否为Debian
if ! command -v lsb_release &> /dev/null; then
  echo "未找到 lsb_release 命令，无法检测系统发行版"
  exit 1
fi

if [ "$(lsb_release -is)" != "Debian" ]; then
  echo "此脚本仅适用于 Debian 系统"
  echo "即将返回上级菜单"
  sleep 1
  wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
else
  echo
fi

# 检测/etc/sysctl.d/99-sysctl.conf是否存在
if [! -f /etc/sysctl.d/99-sysctl.conf ]; then
  echo "未找到 /etc/sysctl.d/99-sysctl.conf 文件"
fi 

cp /etc/sysctl.d/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf.bak

cat <<EOF > /etc/sysctl.d/99-sysctl.conf
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_rmem = 8192 131072 16777216
net.ipv4.tcp_wmem = 4096 65535 16777216
net.ipv4.tcp_adv_win_scale = -2
net.ipv4.tcp_collapse_max_bytes = 4194304
net.ipv4.tcp_notsent_lowat = 65535
net.ipv4.ip_local_port_range = 1024 65535
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.somaxconn = 4096
net.core.netdev_max_backlog = 4096
net.ipv4.tcp_max_tw_buckets = 32768
net.ipv4.tcp_abort_on_overflow = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_synack_retries = 3
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_intvl = 3
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_retries1 = 3
net.ipv4.tcp_retries2 = 5
net.ipv4.tcp_frto = 2
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
net.ipv4.tcp_pacing_ca_ratio=110
fs.file-max = 104857600
fs.inotify.max_user_instances = 8192
fs.nr_open = 1048576

EOF

sudo sysctl -p

congestion_algorithm=$(sysctl -n net.ipv4.tcp_congestion_control)
queue_algorithm=$(sysctl -n net.core.default_qdisc)

echo -e "${mikublue}網路擁塞算法: ${yellow}$congestion_algorithm $queue_algorithm ${white}"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
else
    echo "脚本结束"
fi
