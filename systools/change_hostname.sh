#!/bin/bash

# 函数：修改主机名
change_hostname() {
    local new_hostname=$1

    # 修改主机名
    hostnamectl set-hostname "$new_hostname"

    # 更新 /etc/hosts 文件中的主机名
    sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts

    echo "主机名已成功修改为：$new_hostname"
}

# 显示当前主机名
current_hostname=$(hostname)
echo "当前主机名：$current_hostname"

# 提示用户输入新的主机名
read -p "请输入新的主机名： " new_hostname

# 修改主机名
change_hostname "$new_hostname"