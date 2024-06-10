#!/bin/bash

# 列出所有镜像
list_images() {
    docker images
}

# 拉取镜像
pull_image() {
    image_name=$1
    docker pull $image_name
}

# 构建镜像
build_image() {
    dockerfile_path=$1
    image_name=$2
    docker build -t $image_name $dockerfile_path
}

# 删除镜像
delete_image() {
    image_name=$1
    docker rmi $image_name
}

# 清理无用的镜像
cleanup_images() {
    docker image prune -f
}

# 搜索镜像
search_image() {
    search_term=$1
    docker search $search_term
}

# 主菜单
main_menu() {
    echo "Docker镜像管理脚本"
    echo "1. 列出所有镜像"
    echo "2. 拉取镜像"
    echo "3. 构建镜像"
    echo "4. 删除镜像"
    echo "5. 清理无用的镜像"
    echo "6. 搜索镜像"
    echo "0. 退出"

    read -p "请输入选项: " option

    case $option in
        1) list_images ;;
        2) read -p "请输入要拉取的镜像名称: " image_name
           pull_image $image_name ;;
        3) read -p "请输入Dockerfile所在路径: " dockerfile_path
           read -p "请输入要构建的镜像名称: " image_name
           build_image $dockerfile_path $image_name ;;
        4) read -p "请输入要删除的镜像名称: " image_name
           delete_image $image_name ;;
        5) cleanup_images ;;
        6) read -p "请输入要搜索的镜像名称或关键字: " search_term
           search_image $search_term ;;
        0) echo "再见！"
           exit ;;
        *) echo "无效的选项" ;;
    esac

    echo ""
    main_menu
}

# 运行主菜单
main_menu