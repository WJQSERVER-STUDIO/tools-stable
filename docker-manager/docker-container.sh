#!/bin/bash

start_container() {
    local container_name=$1
    docker start $container_name
    echo "已启动容器：$container_name"
}

stop_container() {
    local container_name=$1
    docker stop $container_name
    echo "已停止容器：$container_name"
}

restart_container() {
    local container_name=$1
    docker restart $container_name
    echo "已重启容器：$container_name"
}

status_container() {
    local container_name=$1
    docker ps -f name=$container_name
}

select_container() {
    local containers=($(docker ps --format "{{.Names}}"))
    if [[ ${#containers[@]} -eq 0 ]]; then
        echo "没有可用的容器."
        return
    fi

    echo "请选择要管理的容器:"
    for i in "${!containers[@]}"; do
        echo "$i. ${containers[$i]}"
    done
    echo "q. 取消"

    read -p "请输入选项数字: " choice

    if [[ $choice == "q" ]]; then
        echo "取消操作."
    elif [[ $choice =~ ^[0-9]+$ ]] && [[ $choice -ge 0 ]] && [[ $choice -lt ${#containers[@]} ]]; then
        local selected_container=${containers[$choice]}
        manage_container $selected_container
    else
        echo "无效的选项: $choice"
    fi
}

manage_container() {
    local container_name=$1

    echo "选择要对容器 '$container_name' 进行的操作:"
    echo "1. 启动容器"
    echo "2. 停止容器"
    echo "3. 重启容器"
    echo "4. 查看容器状态"
    echo "0. 返回"

    read -p "请输入选项数字: " choice

    case $choice in
        1)
            start_container $container_name
            ;;
        2)
            stop_container $container_name
            ;;
        3)
            restart_container $container_name
            ;;
        4)
            status_container $container_name
            ;;
        0)
            echo "返回上级菜单"
            sleep 1
            source "repo_url.conf"
            wget -O docker-manager-menu.sh ${repo_url}docker-manager/docker-manager-menu.sh && chmod +x docker-manager-menu.sh && ./docker-manager-menu.sh
            ;;
        *)
            echo "无效的选项: $choice"
            ;;
    esac
}

main() {
    if [[ $# -eq 0 ]]; then
        select_container
    else
        local action=$1
        local container_name=$2

        case $action in
            start)
                start_container $container_name
                ;;
            stop)
                stop_container $container_name
                ;;
            restart)
                restart_container $container_name
                ;;
            status)
                status_container $container_name
                ;;
            *)
                echo "用法：$0 {start|stop|restart|status} [容器名称]"
                exit 1
                ;;
        esac
    fi
}

main "$@"