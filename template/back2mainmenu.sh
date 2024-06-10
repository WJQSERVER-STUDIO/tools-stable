#等待1s
sleep 1

#返回菜单/退出脚本
read -p "是否返回菜单?: [Y/n]" choice

if [[ "$choice" == "" || "$choice" == "Y" || "$choice" == "y" ]]; then
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && clear && ./main.sh
else
    echo "脚本结束"
fi