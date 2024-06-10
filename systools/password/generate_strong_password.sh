#!/bin/bash

# 函数：生成随机密码
generate_password() {
    local length=$1
    local use_lowercase=$2
    local use_uppercase=$3
    local use_special_chars=$4
    local password=""

    # 定义密码字符集
    local chars=""

    if [[ $use_lowercase == "true" ]]; then
        chars+="abcdefghijklmnopqrstuvwxyz"
    fi

    if [[ $use_uppercase == "true" ]]; then
        chars+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fi

    if [[ $use_special_chars == "true" ]]; then
        chars+="!@#$%^&*()_+-="
    fi

    if [[ -z $chars ]]; then
        echo "密码字符集为空，请至少选择一种字符集。"
        exit 1
    fi

    # 生成随机密码
    for ((i=0; i<$length; i++)); do
        local index=$((RANDOM % ${#chars}))
        password+=${chars:index:1}
    done

    echo "$password"
}

# 提示用户输入密码长度
read -p "请输入密码长度: " password_length

# 提示用户是否需要小写字母
read -p "是否需要包含小写字母？(y/n): " lowercase

# 提示用户是否需要大写字母
read -p "是否需要包含大写字母？(y/n): " uppercase

# 提示用户是否需要特殊字符
read -p "是否需要包含特殊字符？(y/n): " special_chars

# 根据用户选择生成密码
use_lowercase="false"
use_uppercase="false"
use_special_chars="false"

if [[ $lowercase == "y" || $lowercase == "Y" ]]; then
    use_lowercase="true"
fi

if [[ $uppercase == "y" || $uppercase == "Y" ]]; then
    use_uppercase="true"
fi

if [[ $special_chars == "y" || $special_chars == "Y" ]]; then
    use_special_chars="true"
fi

# 生成密码
password=$(generate_password "$password_length" "$use_lowercase" "$use_uppercase" "$use_special_chars")

echo "生成的随机密码: $password"

#等待5s
sleep 5
echo "5秒后返回菜单"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O password_menu.sh ${repo_url}systools/password/password_menu.sh && chmod +x password_menu.sh && ./password_menu.sh
else
    echo "脚本结束"
fi
