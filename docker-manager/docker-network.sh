#!/bin/bash

# 创建Docker网络
create_network() {
    read -p "请输入网络名称: " network_name
    read -p "请输入网络子网 (CIDR 格式): " subnet
    docker network create "$network_name" --driver "$driver" --subnet "$subnet"
    echo "已创建网络: $network_name"
}

# 删除Docker网络
delete_network() {
    read -p "请输入要删除的网络名称: " network_name
    docker network rm "$network_name"
    echo "已删除网络: $network_name"
}

# 列出所有Docker网络
list_networks() {
    docker network ls
}

# 主菜单
main_menu() {
    echo "Docker网络管理脚本"
    echo "1. 创建Docker网络"
    echo "2. 删除Docker网络"
    echo "3. 列出所有Docker网络"
    echo "0. 退出"

    read -p "请输入选项: " option

    case $option in
        1) create_network ;;
        2) delete_network ;;
        3) list_networks ;;
        0) echo "再见！"
           exit ;;
        *) echo "无效的选项" ;;
    esac

    echo ""
    main_menu
}

# 解析参数
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--driver)
                driver="$2"
                if [[ "$driver" != "bridge" && "$driver" != "host" && "$driver" != "none" ]]; then
                    echo "无效的驱动程序: $driver"
                    exit 1
                fi
                shift 2
                ;;
            -s|--subnet)
                subnet="$2"
                shift 2
                ;;
            *)
                echo "未知的参数: $1"
                exit 1
                ;;
        esac
    done
}

# 默认选项
driver="bridge"
subnet=""

# 解析命令行参数
parse_args "$@"

# 运行主菜单
main_menu