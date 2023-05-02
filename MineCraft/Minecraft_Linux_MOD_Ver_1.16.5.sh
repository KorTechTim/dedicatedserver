#!/bin/bash


#===============================================================================
Welcome()
#===============================================================================
{
echo "#################################################################################"
echo "TechTim 채널의 자료가 도움 되신다면 구독과 좋아요 부탁 드립니다"
echo "https://www.youtube.com/@kortechtim"                                           
echo "#################################################################################"
sleep 1
echo 
echo "마인크래프트 (MOD)서버 구축 스크립트를 동작 합니다 "
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
echo "https://files.minecraftforge.net/net/minecraftforge/forge"
echo "위 사이트를 참조하여 설치를 원하시는 마인 크래프트의 MOD 버전을 입력해주세요"
echo "버전 정보는 공백이 없어야 합니다. "
echo "올바른 예시 : 1.19.3-44.1.0"
echo "잘못된 예시 : 1.19.3 - 44.1.0 "
read -r MODVersion

echo 
echo 
echo "마인크래프트 모드 서버의 최대 메모리 사이즈를 넣어주세요(MB)"
echo "예시 : 100MB는 100, 1GB는 1024, 2GB는 2048"
read -r MaxMemory
}




#===============================================================================
MODAvailableCheck()
#===============================================================================
{
  cd ~
  mkdir minecraft && cd minecraft
  wget https://maven.minecraftforge.net/net/minecraftforge/forge/${MODVersion}/forge-${MODVersion}-installer.jar
  
  if [ ${?} != "0" ]
  then
    echo "입력하신 버전으로 MOD를 다운로드 할 수 없습니다. 버전정보를 공란 없이 다시 확인하여 주세요"
    exit 1
  fi
}



#===============================================================================
InstallApps()
#===============================================================================
{
  sudo apt update -y 
  sudo apt-get install default-jre -y
}
 


#===============================================================================
RunInstaller()
#===============================================================================
{
  java -jar forge-${MODVersion}-installer.jar --installServer
}



#===============================================================================
FirstRun()
#===============================================================================
{
 java -Xms${MaxMemory} -Xmx${MaxMemory} -jar forge-${MODVersion}-installer.jar nogui
}


#===============================================================================
EULA()
#===============================================================================
{
cat <<-EOF > ~/minecraft/eula.txt
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
# Step2 : Verify URL available
#===============================================================================
MODAvailableCheck


#===============================================================================
# Step3 : nstall Essential Utility
#===============================================================================
InstallApps


#===============================================================================
# Step4 : run the forge installer file with the --installServer flag.
#===============================================================================
RunInstaller



#===============================================================================
# Step5 : FirstRun 
#===============================================================================
FirstRun



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
echo 
echo
echo
echo
echo "========================================================================"
echo "서버 설치가 완료 되었습니다."
echo "서버 실행전 screen 유틸리티를 사용하여 Screen 터미널로 접근 하고"
echo "그 이후 아래 명령어를 실행해서 마인크래프트 서버를 구동 하세요"
echo "========================================================================"
echo "cd ~/minecraft"
echo "java -Xms${MaxMemory}M -Xmx${MaxMemory}M -jar minecraft_server.{MODVersion}.jar nogui"
echo
echo
  
exit 0
