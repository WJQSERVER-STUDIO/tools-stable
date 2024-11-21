#!/bin/bash
# 卸载华为云控

# 判断root
if [ $(id -u)!= "0" ]; then
    echo "Error: You must be root to run this script."
    exit 1
fi

# 卸载华为云控
echo "卸载华为云控..."
# 判断包管理器是rpm还是dpkg
if rpm --version >/dev/null 2>&1; then
    rpm -e hostguard
else
    dpkg --purge hostguard
fi
echo "华为云控卸载完成！"