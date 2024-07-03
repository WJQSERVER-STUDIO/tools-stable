#! /bin/bash
#https://github.com/WJQSERVER/tools-stable
# deploy golang environment

echo -e "[${yellow}RUN${white}] $mikublue 開始安裝GO環境" $white
echo -e "${green}>${white} $mikublue 拉取安裝包" $white
wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue 清理目錄" $white
echo -e "${green}>${white} $mikublue 解壓安裝包" $white
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
echo -e "${green}>${white} $mikublue 添加環境變量" $white
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
echo -e "${green}>${white} $mikublue 導入變量" $white
source /etc/profile
echo -e "${green}>${white} $mikublue 測試安裝狀態" $white
go version
