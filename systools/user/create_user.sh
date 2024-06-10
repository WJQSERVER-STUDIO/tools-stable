#!/bin/bash

# 检查是否已安装sudo命令
if ! command -v sudo &> /dev/null; then
  echo "未找到sudo命令。正在安装sudo..."

  # 检查系统发行版，并使用相应的包管理器更新软件源并安装sudo
  if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get -y install sudo
  elif command -v yum &> /dev/null; then
    sudo yum check-update
    sudo yum -y install sudo
  elif command -v dnf &> /dev/null; then
    sudo dnf check-update
    sudo dnf -y install sudo
  else
    echo "无法找到适用的包管理器进行sudo安装。请手动安装sudo并重新运行脚本。"
    exit 1
  fi

  echo "sudo安装完成。"
fi

# 提示用户输入新用户的用户名
read -p "请输入新用户的用户名: " username

# 创建新用户
sudo adduser $username

# 添加sudo权限给新用户
sudo usermod -aG sudo $username

# 使用visudo修改sudo配置文件
sudo visudo << EOF
# 在文件末尾添加新用户的sudo权限，允许无密码执行sudo命令
$username ALL=(ALL) NOPASSWD: ALL
EOF

# 备份SSH配置文件
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# 禁止root账户SSH登录
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 重启SSH服务
sudo service ssh restart

# 输出创建用户和修改SSH配置的信息
echo "已创建用户 $username，并禁止root账户SSH登录。"
echo "新用户 $username 已被授予sudo权限，并允许无密码执行sudo命令。"
