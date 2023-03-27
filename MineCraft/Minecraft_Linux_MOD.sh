#!/bin/bash


#################################################################################
# TechTim 채널의 자료가 도움 되신다면 구독과 좋아요 부탁 드립니다                            
# https://www.youtube.com/@koryechtim                                           
#################################################################################


#------ 환경 변수 선언구 -------#
export DATE_TIME=`date +%Y%m%d%H%M%S`
export LOG_FILE=~/"TechTimScript_${DATE_TIME}.log"


#===============================================================================

MODAvailableCheck()
{
  wget https://maven.minecraftforge.net/net/minecraftforge/forge/${MODVersion}/forge-${MODVersion}-installer.jar
  
  if [ ${?} != "0" ]
  then
    echo "입력하신 버전으로 MOD를 다운로드 할 수 없습니다. 버전정보를 공란 없이 다시 확인하여 주세요"
    exit 1
  fi
}



#===============================================================================
InstallApps()
{
  sudo apt update -y 
  sudo apt install screen openjdk-18-jdk -y 
}
 


#===============================================================================
RunInstaller()
{
  java -jar forge-${MODVersion}-installer.jar --installServer
}



#===============================================================================
User_Jvm_Args()
{
cat <<-EOF > ~/user_jvm_args.txt
# Xmx and Xms set the maximum and minimum RAM usage, respectively.
# They can take any number, followed by an M or a G.
# M means Megabyte, G means Gigabyte.
# For example, to set the maximum to 3GB: -Xmx3G
# To set the minimum to 2.5GB: -Xms2500M
# A good default for a modded server is 4GB.
# Uncomment the next line to set it.
-Xmx${MaxMemory}M
EOF
}


#===============================================================================
FirstRun()
{
 ~/run.sh 
}


#===============================================================================
EULA()
{
cat <<-EOF > ~/eula.txt
eula=true
EOF
}



#===============================================================================
# Main Shell Script
#===============================================================================

#===============================================================================
# Step1 : Starting and Welcome Message
#===============================================================================
echo "마인크래프트 서버 구축 스크립트를 동작 합니다 "
echo -n "시작 하겠습니까? [yes/no]  "
read -r answer
case $answer in
      YES|Yes|yes|y)
      break;;
      NO|No|no|n)
      echo Aborting; exit;;
esac
sleep 1 

echo 
echo 
echo "https://files.minecraftforge.net/net/minecraftforge/forge"
echo "위 주소를 참고하여 설치를 원하시는 마인 크래프트의 MOD 버전을 입력해주세요 (공백없이)"
echo "예시 : 1.19.3-44.1.0"
read -r MODVersion

echo 
echo 
echo "마인크래프트 모드 서버의 최대 메모리 사이즈를 넣어주세요(MB)"
echo "예시 : 100MB는 100, 1GB는 1024, 2GB는 2048"
read -r MaxMemory


#===============================================================================
# Step2 : Install Essential Utility
#===============================================================================
InstallApps


#===============================================================================
# Step3 : Verify URL available
#===============================================================================
MODAvailableCheck


#===============================================================================
# Step4 : run the forge installer file with the --installServer flag.
#===============================================================================
RunInstaller



#===============================================================================
# Step5 : FirstRun 
#===============================================================================
FirstRun


#===============================================================================
# Step6 : EULA
#===============================================================================
EULA


#===============================================================================
# Step7 : Ending Message
#===============================================================================
clear
echo 
echo
echo
echo
echo "========================================================================"
echo "서버 설치가 완료 되었습니다."
echo "서버 실행전 screen 유틸리티를 사용하여 아래 명령어를 실행해서 마인크래프트 서버를 구동 하세요"
echo "========================================================================"
echo "sh ~/run.sh"

exit 0
  
