#!/bin/bash

# 使用root权限调用passwd命令修改密码
sudo passwd root

# 检查密码修改是否成功
if [ $? -eq 0 ]; then
  echo "Root密码修改成功。"
else
  echo "无法修改Root密码。"
fi
