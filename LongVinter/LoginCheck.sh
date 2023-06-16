#!/bin/bash

while true
do

    #===================================
    # 변선 선언구 
    #===================================
    discord_webhook_url="https://discord.com/api/webhooks/1116471357052571729/rY5UatEZGMzfLIjBtqCu_E0FDgxq0CwfXDRt0iW6wZobZSuB5rkOFT-BRNANAyxKDXJw"
    User_New=$(cat /home/opc/longvinter-linux-server/Longvinter/Saved/Logs/Longvinter.log |grep "Join succeeded"|tail -n 1|dos2unix|cut -d 'd' -f3|cut -d ' ' -f2)
    EOSID=$(cat /home/opc/longvinter-linux-server/Longvinter/Saved/Logs/Longvinter.log |grep $User_New|grep Redpoint|tail -n 1|dos2unix|cut -d ':' -f6|cut -d ' ' -f1)
    LogDate=`date`
    msg=$LogDate"    /    접속자: "$User_New"    /    EOSID : "$EOSID

    if [ "$User_New" != "$User_Old" ]; 
    then
        #==============================================
        # 새로운 사용자가 접속 했을 경우 (서버 로그 전송)
        #==============================================
        curl -H 'Content-Type: application/json' -d '{"content": "'"${msg}"'"}' "${discord_webhook_url}"
        User_Old=$User_New

    else
        #==============================================
        # 새로운 사용자가 접속하지 않았을 때
        #==============================================
        User_Old=$User_New

    fi     

sleep 10
done
