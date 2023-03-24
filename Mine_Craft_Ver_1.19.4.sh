#!/bin/bash


# Stop on error
set -e

cd

while :; do
    echo
    echo
    echo "--------------------------------------------------------"
    echo "Tech Tim 채널 구독과 좋아요 부탁 드립니다."
    echo "https://www.youtube.com/channel/UCTKC1JQaVY-QvLKyGt84I5w" 
    echo "Script Ver 1.19.4"
    echo "--------------------------------------------------------"
    echo
    sleep 2
    echo "마인크래프트 서버 구축 스크립트를 동작 합니다 "
    echo -n "시작 하겠습니까? [yes/no]  "
    read -r answer
    case $answer in
        YES|Yes|yes|y)
            break;;
        NO|No|no|n)
            echo Aborting; exit;;
    esac
done


# Install Basic App Package
sudo apt update -y 
sudo apt install screen openjdk-18-jdk -y 


# 마인크래프트 서버 설치 
cd ~
mkdir minecraft_server
cd ~/minecraft_server
wget https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar

# 마인크래프트 초기 실행 
java -Xmx1024M -Xms1024M -jar server.jar nogui


# 방화벽 개방
sudo iptables -I INPUT -p udp --dport 25565 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 25565 -j ACCEPT


## 라이센스 파일 등록
cat <<-EOF > ~/minecraft_server/eula.txt
eula=true
EOF

## 완료 ##
echo "---------------------------------------------------------------------------"
echo "설치가 완료 되었습니다 아래 명령어를 사용하여 서버를 실행하세요" 
echo "java -Xmx1G -Xms1G -jar server.jar nogui"
echo ""
echo "옵션 설명 ==> Xmx : 최대 메모리, Xms : 최소 메모리"
echo "실행 전 screen 기능을 먼서 활성화 하고 사용하세요"
echo "---------------------------------------------------------------------------"
