#!/bin/bash

# 检测发行版类型
if [ -f /etc/os-release ]; then
    source /etc/os-release
    DISTRIBUTION=$ID
elif [ -f /etc/redhat-release ]; then
    DISTRIBUTION="rhel"
elif [ -f /etc/openwrt_release ]; then
    DISTRIBUTION="openwrt"
elif [ -f /etc/alpine-release ]; then
    DISTRIBUTION="alpine"    
else
    echo "暂不支持该发行版"
    exit 1
fi

# 根据发行版类型执行相应的命令
case $DISTRIBUTION in
    "ubuntu")
        #apt update
        ;;
    "debian")
        #apt-get update
        ;;
    "centos" | "rhel")
        #yum update
        ;;
    "openwrt")
        #opkg update
        ;;
    "alpine")
        #apk update
        ;;    
    *)
        echo "暂不支持该发行版"
        exit 1
        ;;
esac
