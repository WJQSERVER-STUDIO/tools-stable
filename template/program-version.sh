# 
1() {
    tag=#1
    echo "#1"
}

#
2() {
    tag=#2
    echo "#2"
}

{
    # 显示菜单
    echo "#？："
    echo "1. #1"
    echo "2. #2"

    # 读取用户输入
    echo -n "请输入选项对应的编号: "
    read choice

    # 根据用户输入执行相应的操作
    case $choice in
        1)
            1
            ;;
        2)
            2
            ;;
        0)
            exit
            ;;
        *)
            echo "使用默认TAG安装"
            tag=#1
            ;;
    esac
}