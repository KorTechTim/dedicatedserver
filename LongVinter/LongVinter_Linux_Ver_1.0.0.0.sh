#!/bin/bash


#===============================================================================
Welcome()
#===============================================================================
{
echo "#################################################################################"
echo "TechTim 채널의 자료가 도움 되신다면 구독과 좋아요 부탁 드립니다"
echo "https://www.youtube.com/@koryechtim"                                           
echo "#################################################################################"
sleep 1
echo 
echo "롱빈터 서버 구축 스크립트를 동작 합니다 "
echo -n "시작 하겠습니까? [yes/no]  "
read -r answer
case $answer in
      (YES|Yes|yes|y)
      break;;
      (NO|No|no|n)
      echo Aborting; exit;;
esac
echo 
echo 
}




#===============================================================================
InstallApps()
#===============================================================================
{
  sudo apt update -y && sudo apt upgrade -y && sleep 1  
  sudo apt install git git-lfs -y && sleep 1 
  sudo add-apt-repository multiverse -y && sleep 1
  sudo dpkg --add-architecture i386 -y 
  sleep 1 
  sudo apt update -y 
  sudo apt install lib32gcc-s1 steamcmd -y 
}
 


#===============================================================================
InstallingSteamSDK()
#===============================================================================
{
  cd ~/
  mkdir steamcmd-source
  cd steamcmd-source
  wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
  tar -xvzf steamcmd_linux.tar.gz
  ./steamcmd.sh +force_install_dir . +login anonymous +app_update 1007 +quit
}



#=================================
CopyingSteamSDK()
#=================================
{
cd ~/.steam
mkdir sdk64
cp ~/steamcmd-source/linux64/steamclient.so ~/.steam/sdk64/
}


#===============================================================================
FireWall()
#===============================================================================
{
  sudo iptables -I INPUT -p udp --dport 7777 -j ACCEPT
  sudo iptables -I INPUT -p udp --dport 27016 -j ACCEPT
  sudo iptables -I INPUT -p tcp --dport 27016 -j ACCEPT
  sudo netfilter-persistent save
}



#===============================================================================
InstallingTheServer()
#===============================================================================
{
cd ~/
git clone https://github.com/Uuvana-Studios/longvinter-linux-server.git
sudo chmod -R ugo+rwx longvinter-linux-server/
}


#===============================================================================
CustomizingTheServer()
#===============================================================================
{
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
}




# Main Shell Script Start : 

#===============================================================================
# Step1 : Starting and Welcome Message
#===============================================================================
Welcome


#===============================================================================
# Step2 : InstallApps
#===============================================================================
InstallApps


#===============================================================================
# Step3 : InstallingSteamSDK
#===============================================================================
InstallingSteamSDK


#===============================================================================
# Step4 : CopyingSteamSDK
#===============================================================================
CopyingSteamSDK



#===============================================================================
# Step5 : FireWall
#===============================================================================
FireWall



#===============================================================================
# Step6 : InstallingTheServer
#===============================================================================
InstallingTheServer


#===============================================================================
# Step7 : CustomizingTheServer
#===============================================================================
CustomizingTheServer



#===============================================================================
# Step8 : Ending Message
#===============================================================================
echo 
echo
echo
echo
echo "========================================================================"
echo "서버 설치가 완료 되었습니다."
echo "서버 설정을 원하시 경우 아래 명령어를 사용하여 수정하세요 "
echo "nano ~/longvinter-linux-server/Longvinter/Saved/Config/LinuxServer/Game.ini "
echo 
echo "이후 screen 명령어와 아래 커맨드를 실행해서 롱빈터 서버를 구동 하세요"
echo "========================================================================"
echo "sh ~/steam/longvinter-linux-server/LongvinterServer.sh"
echo
echo
  
exit 0
