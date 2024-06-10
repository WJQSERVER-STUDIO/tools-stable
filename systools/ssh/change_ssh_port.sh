#!/bin/bash

# 定义正常的端口范围
min_port=1
max_port=65535

# 提示用户输入新的SSH端口号，并进行验证
read -p "请输入新的SSH端口号（$min_port-$max_port）: " new_port

# 检查输入的端口号是否为数字
if ! [[ "$new_port" =~ ^[0-9]+$ ]]; then
  echo "无效的端口号。请输入一个有效的数字端口号。"
  exit 1
fi

# 检查端口号是否在合法范围内
if ((new_port < min_port || new_port > max_port)); then
  echo "端口号超出范围。请输入一个介于$min_port和$max_port之间的端口号。"
  exit 1
fi

# 备份SSH配置文件
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# 修改SSH配置文件中的端口号
sudo sed -i "s/^Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config

# 重启SSH服务
sudo service ssh restart

# 输出修改后的SSH端口号信息
echo "SSH端口已成功修改为 $new_port"