#! /bin/bash
# https://github.com/WJQSERVER/tools-stable
# deploy golang environment

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

# 获取最新的 Go 版本信息
get_latest_go_info() {
    local response=$(curl -s https://go.dev/VERSION?m=text)

    # 检查curl是否成功
    if [ $? -ne 0 ]; then
        echo -e "${red}Error:${white} 获取最新版本信息失败，curl命令执行失败！"
        return 1
    fi

    # 解析响应体
    local lines=$(echo "$response" | tr '\n' '\0' | sed 's/\x0/\n/g') # 将 \0 转换成 \n

    # 获取行数
    local line_count=$(echo "$lines" | wc -l)

    if [ "$line_count" -lt 2 ]; then
        echo -e "${red}Error:${white} 获取最新版本信息失败,返回结果格式不正确! 返回内容: $response"
        return 1
    fi

    # 提取版本号
    local version=$(echo "$lines" | head -n 1 | sed 's/go//')

    # 提取时间戳
    local timestamp=$(echo "$lines" | tail -n 1 | sed 's/time //')

    echo "version=$version"
    echo "timestamp=$timestamp"
    return 0
}

# 获取版本信息
if ! get_latest_go_info; then
    echo -e "${red}Error:${white} 获取最新版本信息失败, 停止安装！"
    exit 1
fi
eval $(get_latest_go_info) # 执行函数并将结果赋值给 version 和 timestamp 变量
# 使用正则表达式提取版本号，例如：1.23.5
# version=$(echo "$version" | sed -E 's/^go([0-9]+)\.([0-9]+)\.([0-9]+)$/\1.\2.\3/g')

echo -e "[${green}RUN${white}] $mikublue 開始安裝GO環境" $white
echo -e "${green}>${white} $mikublue     檢測最新版本: $version" $white
echo -e "${green}>${white} $mikublue     拉取安裝包" $white
wget -q https://go.dev/dl/go${version}.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue     清理目錄" $white
echo -e "${green}>${white} $mikublue     解壓安裝包" $white
rm -rf /usr/local/go && tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue     清理安裝包" $white
rm -f go${version}.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue     添加環境變量" $white
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
echo -e "${green}>${white} $mikublue     導入變量" $white
source /etc/profile
echo -e "${green}>${white} $mikublue     測試安裝狀態" $white
go version

# 回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

# 等待1s
sleep 1

# 返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O environment-menu.sh ${repo_url}environment/environment-menu.sh && chmod +x environment-menu.sh && ./environment-menu.sh
else
    echo "脚本结束"
fi
