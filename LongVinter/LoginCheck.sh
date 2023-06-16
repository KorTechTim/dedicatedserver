#!/bin/bash

while true
do

    #===================================
    # 사용자 선언구 
    #===================================
    DiscordWebhookUrl=""
    LogFileLocation=""

    #===================================
    # 프로그램 실행 구문
    #===================================
    User_New=$(cat ${LogFileLocation}/Longvinter.log |grep "Join succeeded"|tail -n 1|dos2unix|cut -d 'd' -f3|cut -d ' ' -f2)
    EOSID=$(cat ${LogFileLocation}/Longvinter.log |grep $User_New|grep Redpoint|tail -n 1|dos2unix|cut -d ':' -f6|cut -d ' ' -f1)
    LogDate=`date "+%Y-%m-%d %H:%M:%S"`
    msg=$LogDate"    /    접속자: "$User_New"    /    EOSID : "$EOSID

    if [ "$User_New" != "$User_Old" ]; 
    then
        #==============================================
        # 새로운 사용자가 접속 했을 경우 (서버 로그 전송)
        #==============================================
        curl -H 'Content-Type: application/json' -d '{"content": "'"${msg}"'"}' "${DiscordWebhookUrl}"
        User_Old=$User_New

    else
        #==============================================
        # 새로운 사용자가 접속하지 않았을 때 (아무일 없음)
        #==============================================
        User_Old=$User_New

    fi     

sleep 10
done
