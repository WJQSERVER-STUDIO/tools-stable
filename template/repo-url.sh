#BETA版
repo_url="https://raw.githubusercontent.com/WJQSERVER/tools-dev/BETA/"

# 检查配置文件是否存在
conf_file="repo_url.conf"
if [ ! -f "$conf_file" ]; then
    # 创建配置文件并写入变量
    echo "repo_url=$repo_url" > "$conf_file"
else
    # 配置文件已存在，不进行任何操作
    echo "配置文件已存在"
fi

# 导入配置文件
source "repo_url.conf"