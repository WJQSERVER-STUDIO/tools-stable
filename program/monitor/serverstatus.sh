#!/bin/bash

# 创建目录并进入
mkdir sss
cd sss

# 下载脚本
wget --no-check-certificate https://raw.githubusercontent.com/lidalao/ServerStatus/master/sss.sh

# 添加执行权限
chmod +x ./sss.sh

# 询问用户输入Telegram相关变量
read -p "请输入您的Telegram聊天ID: " tg_chat_id
read -p "请输入您的Telegram机器人令牌: " tg_bot_token

# 执行脚本，并传入用户输入的Telegram变量
sudo ./sss.sh "$tg_chat_id" "$tg_bot_token"
