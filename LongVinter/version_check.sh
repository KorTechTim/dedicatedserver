#!/bin/bash

while true
do

#===================================
# 변수 선언구 
#===================================
discord_webhook_url="https://discord.com/api/webhooks"
LogDate=`date "+%Y-%m-%d %H:%M:%S"`
msg="[업데이트_알림] "$LogDate" / 새로운 업데이트가 발견 되었습니다 ! 서버 패치가 필요합니다 ! "


#===================================
# 함수 선언구 
#===================================
SendNotification () {
    curl -H 'Content-Type: application/json' -d '{"content": "'"${msg}"'"}' "${discord_webhook_url}"
}

cd ~/longvinter-linux-server

git fetch

if git merge-base --is-ancestor origin/main main ; 
then
    echo "Nothing to update.."
else
    SendNotification
fi

sleep 300
done

