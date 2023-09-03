#!/bin/bash

while true
do

#===================================
# 변수 선언구 
#===================================
discord_webhook_url="https://discord.com/api/webhooks/"
LogDate=`date "+%Y-%m-%d %H:%M:%S"`
msg="[프로세스종료감지!] "$LogDate" / 롱빈터 서버 프로세스가 종료되었습니다. 서버 상태를 확인하세요 "


#===================================
# 함수 선언구 
#===================================
SendNotification () {
    curl -H 'Content-Type: application/json' -d '{"content": "'"${msg}"'"}' "${discord_webhook_url}"
}


check=`ps -ef | grep 'longvinter' | wc -l`
​
if [ $check == 2 ]
then
 echo "Service is Running"
else
 SendNotification
fi
​





sleep 60
done
