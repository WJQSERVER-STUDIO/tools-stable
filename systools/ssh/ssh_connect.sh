#!/bin/bash

# 获取用户输入的服务器地址
read -p "请输入服务器地址: " server_address

# 获取用户输入的服务器端口
read -p "请输入服务器端口 (默认为 22): " server_port
server_port=${server_port:-22}

# 获取用户输入的用户名
read -p "请输入用户名: " username

# 输出服务器地址供用户确认
echo "连接到服务器：$server_address"

# 检查用户输入的服务器地址是IPv4还是IPv6
if [[ $server_address =~ .*:.* ]]; then
  # IPv6地址
  ssh_command="ssh -6"
else
  # IPv4地址
  ssh_command="ssh"
fi

# 连接到服务器
$ssh_command -p $server_port $username@$server_address