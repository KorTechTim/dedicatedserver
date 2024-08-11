#!/bin/bash


# Stop on error
set -e

cd

while :; do
    echo
    echo
    echo "롱빈터 서버 구축 스크립트를 동작 합니다 "
    echo -n "시작 하겠습니까? [yes/no]  "

    read -r answer

    case $answer in
        YES|Yes|yes|y)
            break;;
        NO|No|no|n)
            echo Aborting; exit;;
    esac
done

echo


 
# 패키지 업데이트 & 설치
sudo apt update -y 
sudo apt install git git-lfs screen net-tools -y 

sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update -y
sudo apt install lib32gcc-s1 steamcmd -y 

sudo mkdir ~/longvinter-server



## 게임엔진 설치
steamcmd +force_install_dir . +login anonymous +app_update 1639880 validate +quit




# 환경 변수 파일 

cat <<-EOF > ~/Steam/steamapps/common/Longvinter Dedicated Server/Longvinter/Saved/Config/LinuxServer/Game.ini
[/Game/Blueprints/Server/GI_AdvancedSessions.GI_AdvancedSessions_C]
ServerName=[EU-WEST] Arlo's Hangout
ServerMOTD=Welcome to Arlo's Hangout
MaxPlayers=64
Password=
CommunityWebsite=discord.gg/longvinter
CoopPlay=false
CheckVPN=true
CoopSpawn=0
Tag=none
ChestRespawnTime=900
DisableWanderingTraders=false

[/Game/Blueprints/Server/GM_Longvinter.GM_Longvinter_C]
AdminSteamID=00023652dd9b4673be20d4f83ab42c5b 0002365d948ad82f373be20d4ff8ab42c5b
PVP=false
TentDecay=true
MaxTents=3
RestartTime24h=6
SaveBackups=true
EOF




clear
echo "---------------------------------------------------------------------------"
echo "설치가 완료 되었습니다"
echo "아래 명령어를 사용하여 서버 설정을 마무리 하세요" 
echo "---------------------------------------------------------------------------"
echo "nano ~/Steam/steamapps/common/Longvinter Dedicated Server/Longvinter/Saved/Config/LinuxServer/Game.ini"
echo
echo
echo "---------------------------------------------------------------------------"
echo "서버 실행은 아래 명령어를 사용하세요"
echo "---------------------------------------------------------------------------"
echo "sh ~/Steam/steamapps/common/Longvinter Dedicated Server/LongvinterServer.sh"    
echo
echo

