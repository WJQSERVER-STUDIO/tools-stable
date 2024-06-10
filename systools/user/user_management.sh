#!/bin/bash

# 添加用户
add_user() {
    read -p "请输入要添加的用户名: " username
    sudo adduser "$username"
    echo "用户 $username 添加成功。"
}

# 删除用户
delete_user() {
    read -p "请输入要删除的用户名: " username
    sudo deluser "$username"
    echo "用户 $username 删除成功。"
}

# 列出用户
list_users() {
    echo "系统中的用户:"
    sudo cat /etc/passwd | cut -d: -f1
}

# 主菜单
while true; do
    echo "请选择操作:"
    echo "1. 添加用户"
    echo "2. 删除用户"
    echo "3. 列出用户"
    echo "4. 退出"
    read -p "请输入选项编号: " choice

    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) list_users ;;
        4) break ;;
        *) echo "无效的选项，请重新输入。" ;;
    esac

    echo
done
