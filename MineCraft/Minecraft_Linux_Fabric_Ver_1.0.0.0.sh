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
echo "마인크래프트 (Fabric)서버 구축 스크립트를 동작 합니다 "
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
echo "https://fabricmc.net/use/server"
echo "위 사이트를 참조하여 설치를 원하시는 마크 서버 3가지 정보를 확인하세요 "
echo ""
echo 
echo "설치 할 마인크래프트 버전을 입력해주세요 :"
echo "------------------------------"
read -r MinecraftVersion
echo
echo 
echo "설치 할 페브릭 로더 버전을 입력해주세요 :"
echo "------------------------------"
read -r FabricVersion
echo
echo
echo "설치 할 인스톨러 버전을 입력해주세요 :"
echo "------------------------------"
read -r InstallerVersion
}




#===============================================================================
MODAvailableCheck()
#===============================================================================
{
  mkdir ~/minecraft
  cd ~/minecraft/
  curl -OJ https://meta.fabricmc.net/v2/versions/loader/${MinecraftVersion}/${FabricVersion}/${InstallerVersion}/server/jar
  ls -l | grep fabric 
  
  if [ ${?} != "0" ]
  then
    echo "입력하신 버전으로 Fabric을 다운로드 할 수 없습니다. 버전 정보를 정확하게 다시 입력해주세요"
    rm -rf ~/minecraft
    exit 1
  fi
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
  cd ~/minecraft
  java -jar ~/minecraft/fabric-server-mc.${MinecraftVersion}-loader.${FabricVersion}-launcher.${InstallerVersion}.jar nogui
}




#===============================================================================
EULA()
#===============================================================================
{
cd ~/minecraft
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
# Step5 : EULA
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
echo "1. Fabric 서버 설치가 완료 되었습니다."
echo "2. 메모리 크기는 환경에 맞춰서 수정하여 사용합니다. "
echo "3. Fabric API는 https://www.curseforge.com/minecraft/mc-mods/fabric-api 에서 직접 다운로드 받아 mods 디렉토리에 업로드 합니다. "
echo "4. 서버 커맨드 실행전 screen 명령어를 사용하여 백그라운드로 돌리세요"
echo "========================================================================"
echo "cd ~/minecraft"
echo "java -Xms2G -Xmx2G -jar ./fabric-server-mc.${MinecraftVersion}-loader.${FabricVersion}-launcher.${InstallerVersion} nogui"
echo
echo
  
exit 0
