#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-dev

clear

# 显示免责声明
echo "免责声明：请阅读并同意以下条款才能继续使用本脚本。"
echo "本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo "使用本脚本所造成的任何损失或损害，作者不承担任何责任。"

# 导入配置文件
source "repo_url.conf"

#彩色
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}

#nginx proxy manager
function nginxproxymanager(){
    wget -O nginxproxymanager.sh ${repo_url}program/nginxproxymanager.sh && chmod +x nginxproxymanager.sh && ./nginxproxymanager.sh
}

#Docker管理WEBUI
function docker_manager_webui(){
    wget -O docker_manager_webui_menu.sh ${repo_url}program/docker_manager_webui/docker_manager_webui_menu.sh && chmod +x docker_manager_webui_menu.sh && ./docker_manager_webui_menu.sh
}

#speedtest-x
function speedtest-x(){
    wget -O speedtest-x.sh ${repo_url}program/speedtest-x.sh && chmod +x speedtest-x.sh && ./speedtest-x.sh
}

#青龙面板
function qinglong(){
    wget -O qinglong.sh ${repo_url}program/qinglong.sh && chmod +x qinglong.sh && ./qinglong.sh
}

#uptime-kuma
function uptime-kuma(){
    wget -O uptime-kuma.sh ${repo_url}program/uptime-kuma.sh && chmod +x uptime-kuma.sh && ./uptime-kuma.sh
}

#ADGuard-Home去广告DNS
function adguardhome(){
    wget -O adguard-home.sh ${repo_url}program/adguard-home.sh && chmod +x adguard-home.sh && ./adguard-home.sh
}

#探针
function serverstatus(){
    wget -O serverstatus.sh ${repo_url}program/serverstatus.sh && chmod +x serverstatus.sh && ./serverstatus.sh
}

#sun-panel面板
function sun-panel(){
    wget -O sun-panel.sh ${repo_url}program/sun-panel.sh && chmod +x sun-panel.sh && ./sun-panel.sh
}

#Docker Clash
function cat(){
    wget -O cat.sh ${repo_url}program/cat.sh && chmod +x cat.sh && ./cat.sh    
}

#one-nav
function one-nav(){
    wget -O one-nav.sh ${repo_url}program/one-nav.sh && chmod +x one-nav.sh && ./one-nav.sh
}

#QB离线下载BT/PT
function qbittorrent(){
    wget -O qbittorrent.sh ${repo_url}program/qbittorrent.sh && chmod +x qbittorrent.sh && ./qbittorrent.sh
}

#Alist
function alist(){
    wget -O alist.sh ${repo_url}program/alist.sh && chmod +x alist.sh && ./alist.sh    
}

#ALLTube视频下载
function alltube(){
    wget -O alltube.sh ${repo_url}program/alltube.sh && chmod +x alltube.sh && ./alltube.sh    
}

#HastPaste在线剪贴板
function hastypaste(){
    wget -O hastypaste.sh ${repo_url}program/hastypaste.sh && chmod +x hastypaste.sh && ./hastypaste.sh
}

#IT-Tools在线IT工具箱
function it-tools(){
    wget -O it-tools.sh ${repo_url}program/it-tools.sh && chmod +x it-tools.sh && ./it-tools.sh    
}

#SearXNG搜索引擎
function searxng(){
    wget -O searxng.sh ${repo_url}program/searxng.sh && chmod +x searxng.sh && ./searxng.sh
}

#Koishi恋恋机器人框架
function koishi(){
    wget -O koishi.sh ${repo_url}program/koishi.sh && chmod +x koishi.sh && ./koishi.sh
}

#V2rayA
function v2raya(){
    wget -O v2raya.sh ${repo_url}program/v2raya.sh && chmod +x v2raya.sh && ./v2raya.sh
}

#WebSSH
function webssh(){
    wget -O webssh.sh ${repo_url}program/webssh.sh && chmod +x webssh.sh && ./webssh.sh
}

#中微子代理
function neutrino_proxy(){
    wget -O neutrino-proxy-menu.sh ${repo_url}program/neutrino-proxy/neutrino-proxy-menu.sh && chmod +x neutrino-proxy-menu.sh && ./neutrino-proxy-menu.sh
}

#青龙代挂面板
function qinglong_panel(){
    wget -O qinglong-panel.sh ${repo_url}program/qinglong-panel/qinglong-panel.sh && chmod +x qinglong-panel.sh && ./qinglong-panel.sh
}

#Caddy
function caddy(){
    wget -O caddy-menu.sh ${repo_url}program/caddy/caddy-menu.sh && chmod +x caddy-menu.sh && ./caddy-menu.sh
}

#聊天机器人
function chatbot(){
    wget -O chatbot_menu.sh ${repo_url}program/chatbot/chatbot_menu.sh && chmod +x chatbot_menu.sh && ./chatbot_menu.sh
}

#返回主脚本
function back(){
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && ./main.sh
}

#主菜单
function start_menu(){
    clear
    yellow " WJQserver Studio的快捷工具箱 BETA版 "
    green " WJQserver Studio tools BETA" 
    yellow " FROM: https://github.com/WJQSERVER/tools-dev "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    yellow " =================================================="
    green " 1. Nginx系列&WAF"        
    green " 2. Docker管理面板"                  
    green " 3. Speedtest-X 测速面板" 
    green " 4. 青龙面板" 
    green " 5. Uptime-Kuma"
    green " 6. ADGuard Home 去广告,DNS面板"
    green " 7. ServerStatus探针"
    green " 8. Sun Panel NAS面板"
    green " 9. One-NAV导航"
    green " 10.QBittorrent BT/PT下载"
    green " 11.Alist"
    green " 12.ALLTube视频下载"
    green " 13.HastPaste在线剪贴板"
    green " 14.IT-Tools在线IT工具箱"
    green " 15.SearXNG搜索引擎"
    green " 16.WebSSH网页SSH"
    green " 17.中微子代理"
    green " 18.青龙代挂面板" 
    green " 19.Caddy"
    green " 20.聊天机器人"
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           nginxproxymanager
	    ;;
        2 )
	       docker_manager_webui
        ;;
	    3 )
           speedtest-x
	    ;;
        4 )
	       qinglong
        ;;
	    5 )
           uptime-kuma
	    ;;
        6 )
	       adguardhome
        ;;
	    7 )
           serverstatus
	    ;;
        8 )
           sun-panel
        ;;
        9 )
           one-nav 
        ;;
        10)
           qbittorrent
        ;;
        11)
           alist
        ;;
        12)
           alltube
        ;;
        13)
           hastypaste
        ;;
        14)
           it-tools
        ;;
        15)
           searxng
        ;;
        16)
           webssh
        ;;
        17)
           neutrino_proxy
        ;;
        18)
           qinglong_panel
        ;;
        19)
           caddy
        ;;
        20)
           chatbot
        ;;            
        90)
           v2raya
        ;;   
        99)
           cat
        ;;   

        0 )
            back
        ;;
	
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
