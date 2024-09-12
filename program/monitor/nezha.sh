#!/bin/bash

# 主命令
main_command="curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh"

# 备用命令
backup_command="curl -L https://gitee.com/naibahq/nezha/raw/master/script/install.sh -o nezha.sh && chmod +x nezha.sh && sudo CN=true ./nezha.sh"

# 设置超时时间为10秒
timeout=10

# 执行主命令，并设置超时时间
timeout $timeout bash -c "$main_command"

# 检查主命令的返回值
if [ $? -eq 124 ]; then
  echo "Github不可达,切换至镜像下载"
  $backup_command
fi