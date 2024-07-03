#! /bin/bash
#删除腾讯云控,保护隐私安全

echo -e "[${yellow}RUN${white}] $mikublue 開始刪除騰訊雲控" $white

sleep 1

echo -e "${green}>${white} $mikublue 停止進程" $white
systemctl stop tat_agent
systemctl disable tat_agent

echo -e "${green}>${white} $mikublue 運行卸載程序" $white
/usr/local/qcloud/stargate/admin/uninstall.sh
/usr/local/qcloud/YunJing/uninst.sh
/usr/local/qcloud/monitor/barad/admin/uninstall.sh

echo -e "${green}>${white} $mikublue 刪除殘留" $white
rm -f /etc/systemd/system/tat_agent.service
rm -rf /usr/local/qcloud
rm -rf /usr/local/sa
rm -rf /usr/local/agenttools
rm -rf /usr/local/qcloud

process=(sap100 secu-tcs-agent sgagent64 barad_agent agent agentPlugInD pvdriver )
for i in ${process[@]}
do
  for A in $(ps aux | grep $i | grep -v grep | awk '{print $2}')
  do
    kill -9 $A
  done
done

echo -e "[${green}OK${white}] $mikublue 騰訊雲控卸載完成" $white
