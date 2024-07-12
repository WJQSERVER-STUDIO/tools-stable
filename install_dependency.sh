#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-stable

# 导入配置文件
source "repo_url.conf"

install() {
    if [ $# -eq 0 ]; then
        echo "ARGS NOT FOUND"
        return 1
    fi

    for package in "$@"; do
        if ! command -v "$package" &>/dev/null; then
            if command -v dnf &>/dev/null; then
                dnf -y update && dnf install -y "$package"
            elif command -v yum &>/dev/null; then
                yum -y update && yum -y install "$package"
            elif command -v apt &>/dev/null; then
                apt update -y && apt install -y "$package"
            elif command -v apk &>/dev/null; then
                apk update && apk add "$package"
            else
                echo "UNKNOW PACKAGE MANAGER"
                return 1
            fi
        fi
    done

    return 0
}

upgrade() {
    if command -v dnf &>/dev/null; then
        dnf -y upgrade
    elif command -v yum &>/dev/null; then
        yum -y update
    elif command -v apt &>/dev/null; then
        apt update -y && apt upgrade -y
    elif command -v apk &>/dev/null; then
        apk update && apk upgrade
    else
        echo "UNKNOWN PACKAGE MANAGER"
        return 1
    fi

    return 0
}

install wget curl vim git sudo tar
upgrade

wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && clear && ./main.sh
