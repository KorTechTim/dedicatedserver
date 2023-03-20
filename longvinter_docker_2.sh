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


# 스팀 SDK 설치

cd ~/
mkdir steamcmd-source
cd steamcmd-source
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
./steamcmd.sh +force_install_dir . +login anonymous +app_update 1007 +quit



# Copying Steam SDK to the right place
cd ~/.steam
mkdir sdk64
cp ~/steamcmd-source/linux64/steamclient.so ~/.steam/sdk64/



#서버 설치
cd ~/
git clone https://github.com/Uuvana-Studios/longvinter-linux-server.git
sudo chmod -R ugo+rwx longvinter-linux-server/


# 환경 변수 파일 

cat <<-EOF > ~/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini
[/Game/Blueprints/Server/GI_AdvancedSessions.GI_AdvancedSessions_C]
ServerName=Unnamed Island
ServerTag=Default
MaxPlayers=32
ServerMOTD=Welcome to Longvinter Island!
Password=
CommunityWebsite=www.longvinter.com
[/Game/Blueprints/Server/GM_Longvinter.GM_Longvinter_C]
AdminSteamID=76561198965966997
PVP=true
TentDecay=true
MaxTents=2
ChestRespawnTime=600
EOF



## systemd 등록 ##
#sudo cp ~/steam/longvinter-linux-server/longvinter.service /etc/systemd/system/longvinter.service
#sudo cp ~/steam/longvinter-linux-server/longvinter.socket /etc/systemd/system/longvinter.socket
#sudo systemctl daemon-reload




clear
echo
echo
echo
echo "---------------------------------------------------------------------------"
echo "서버 실행은 아래 명령어를 사용하세요"
echo "---------------------------------------------------------------------------"
echo "sh ~/longvinter-linux-server/LongvinterServer.sh"    
echo
echo

