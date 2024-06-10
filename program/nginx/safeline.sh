# 检查是否已经安装 Docker 和 Docker Compose
if ! command -v docker >/dev/null || ! command -v docker-compose >/dev/null; then
    echo "请先安装 Docker 和 Docker Compose。"
    exit 1
fi

#官方安装脚本
bash -c "$(curl -fsSLk https://waf-ce.chaitin.cn/release/latest/setup.sh)"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 3

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O nginx_menu.sh ${repo_url}program/nginx/nginx_menu.sh && chmod +x nginx_menu.sh && ./nginx_menu.sh
else
    echo "脚本结束"
fi