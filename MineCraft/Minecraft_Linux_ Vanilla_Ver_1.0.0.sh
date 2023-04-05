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
echo "마인크래프트 (바닐라)서버 구축 스크립트를 동작 합니다 "
echo -n "시작 하겠습니까? [yes/no]  "
read -r answer
case $answer in
      (YES|Yes|yes|y)
      break;;
      (NO|No|no|n)
      echo Aborting; exit;;
esac

}





#===============================================================================
InstallApps()
#===============================================================================
{
  sudo apt update -y 
  sudo apt install screen openjdk-18-jdk -y 
}
 


#===============================================================================
RunInstaller()
#===============================================================================
{
  java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
}



#===============================================================================
FirstRun()
#===============================================================================
{
 java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
}


#===============================================================================
EULA()
#===============================================================================
{
cat <<-EOF > ~/eula.txt
eula=true
EOF
}


#===============================================================================
FireWall()
#===============================================================================
{
  sudo iptables -I INPUT -p udp --dport 25565 -j ACCEPT
  sudo iptables -I INPUT -p tcp --dport 25565 -j ACCEPT
  sudo netfilter-persistent save
}



# Main Shell Script Start : 

#===============================================================================
# Step1 : Starting and Welcome Message
#===============================================================================
Welcome


#===============================================================================
# Step2 : nstall Essential Utility
#===============================================================================
InstallApps


#===============================================================================
# Step3 : FirstRun 
#===============================================================================
FirstRun



#===============================================================================
# Step6 : EULA
#===============================================================================
User_Jvm_Args


#===============================================================================
# Step7 : EULA
#===============================================================================
EULA



#===============================================================================
# Step8 : FireWall
#===============================================================================
FireWall


#===============================================================================
# Step9 : Ending Message
#===============================================================================
clear
echo 
echo
echo
echo
echo "========================================================================"
echo "서버 설치가 완료 되었습니다."
echo "서버 실행전 screen 유틸리티를 사용해주시고, 게임실행은 아래 명령어르 이용하세요"
echo "-Xmx : 최대 메모리      -Xms : 최소 메모리"
echo "========================================================================"
echo "java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui"
echo
echo
  
exit 0
