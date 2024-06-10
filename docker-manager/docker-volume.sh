#!/bin/bash

create_volume() {
    local volume_name=$1
    docker volume create $volume_name
    echo "已创建卷：$volume_name"
}

delete_volume() {
    local volume_name=$1
    docker volume rm $volume_name
    echo "已删除卷：$volume_name"
}

list_volumes() {
    docker volume ls
}

usage() {
    echo "用法: $0 [选项]"
    echo "选项:"
    echo "  -c, --create <卷名称>   创建一个新的卷"
    echo "  -d, --delete <卷名称>   删除指定的卷"
    echo "  -l, --list             列出所有卷"
    exit 1
}

main() {
    if [[ $# -eq 0 ]]; then
        usage
    fi

    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            -c|--create)
                create_volume "$2"
                shift
                shift
                ;;
            -d|--delete)
                delete_volume "$2"
                shift
                shift
                ;;
            -l|--list)
                list_volumes
                shift
                ;;
            *)
                usage
                ;;
        esac
    done
}

main "$@"