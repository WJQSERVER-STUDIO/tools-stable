#!/bin/bash

# 查看Docker全局信息并进行归类总结
docker_info=$(docker info)

# 服务器信息
server_info=$(echo "$docker_info" | sed -n '/Server Version/p')
api_version=$(echo "$docker_info" | sed -n '/API version/p')
go_version=$(echo "$docker_info" | sed -n '/Go version/p')
git_commit=$(echo "$docker_info" | sed -n '/Git Commit/p')
build_time=$(echo "$docker_info" | sed -n '/Build Time/p')
operating_system=$(echo "$docker_info" | sed -n '/Operating System/p')
kernel_version=$(echo "$docker_info" | sed -n '/Kernel Version/p')

# 容器信息
container_total=$(echo "$docker_info" | sed -n '/Containers:/p' | awk '{print $2}')
container_running=$(echo "$docker_info" | sed -n '/Running:/p' | awk '{print $2}')
container_stopped=$(echo "$docker_info" | sed -n '/Stopped:/p' | awk '{print $2}')
container_paused=$(echo "$docker_info" | sed -n '/Paused:/p' | awk '{print $2}')
container_total=$((container_total - container_stopped - container_paused))

# 镜像信息
image_total=$(echo "$docker_info" | sed -n '/Images:/p' | awk '{print $2}')
image_deleted=$(echo "$docker_info" | sed -n '/Deleted:/p' | awk '{print $2}')
image_unreferenced=$(echo "$docker_info" | sed -n '/Unreferenced:/p' | awk '{print $2}')

# 存储信息
storage_driver=$(echo "$docker_info" | sed -n '/Storage Driver:/p' | awk '{print $3}')
storage_total=$(echo "$docker_info" | sed -n '/Total Space:/p' | awk '{print $3}')
storage_available=$(echo "$docker_info" | sed -n '/Space Available:/p' | awk '{print $3}')

# 运行时信息
experimental=$(echo "$docker_info" | sed -n '/Experimental:/p' | awk '{print $2}')
container_runtime=$(echo "$docker_info" | sed -n '/Container Runtime:/p' | awk '{print $3}')
default_runtime=$(echo "$docker_info" | sed -n '/Default Runtime:/p' | awk '{print $3}')

# 安全信息
security_scan=$(echo "$docker_info" | sed -n '/Live Restore Enabled:/p' | awk '{print $4}')
vulnerability_scan=$(echo "$docker_info" | sed -n '/Security Options:/p' | awk '{print $3}')

# 输出归类总结
echo "服务器信息:"
echo "  $server_info"
echo "  $api_version"
echo "  $go_version"
echo "  $git_commit"
echo "  $build_time"
echo "  $operating_system"
echo "  $kernel_version"
echo ""

echo "容器信息:"
echo "  容器总数: $container_total"
echo "  运行中的容器: $container_running"
echo "  停止的容器: $container_stopped"
echo "  暂停的容器: $container_paused"
echo ""

echo "镜像信息:"
echo "  镜像总数: $image_total"
echo "  已删除的镜像: $image_deleted"
echo "  无引用的镜像: $image_unreferenced"
echo ""

echo "存储信息:"
echo "  存储驱动程序: $storage_driver"
echo "  总空间: $storage_total"
echo "  可用空间: $storage_available"
echo ""

echo "运行时信息:"
echo "  是否启用实验性功能: $experimental"
echo "  容器运行时: $container_runtime"
echo "  默认运行时规范: $default_runtime"
echo ""

echo "安全信息:"
echo "  实时安全扫描: $security_scan"
echo "  实时漏洞扫描: $vulnerability_scan"

#回到root目录
cd /root

# 导入配置文件
source "repo_url.conf"

#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O docker-manager-menu.sh ${repo_url}docker-manager/docker-manager-menu.sh && chmod +x docker-manager-menu.sh && ./docker-manager-menu.sh
else
    echo "脚本结束"
fi