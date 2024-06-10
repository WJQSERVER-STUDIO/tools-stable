#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
# https://github.com/WJQSERVER/tools-stable

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
                echo "UNKNOWN PACKAGE MANAGER"
                return 1
            fi
        fi
    done

    return 0
}

# 检查参数是否为空
if [ $# -eq 0 ]; then
    echo "No packages specified."
    exit 1
fi

# 执行安装操作
install "$@"