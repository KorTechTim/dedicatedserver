
#변수 정의
$dirname = "Minecraft_Plugin_Server"
$MinecraftServerPath = $env:USERPROFILE + "\Downloads\" + $dirname
$euel = "eula=true"
$PlayitName = "playit-0.9.3-signed.exe"
$PlayitURL = "https://github.com/playit-cloud/playit-agent/releases/download/v0.9.3/playit-0.9.3-signed.exe"




##########################################################
# 스탭 1 : Welcome Message
##########################################################
echo ===========================================================
echo 'Starting Install Minecraft Plugin Server'
echo 'TechTim Script Ver 1.0.0'
echo ===========================================================
echo ''



##########################################################
# 스탭 2 : 기존 Plugin Server 디렉토리 존재 확인
##########################################################
sleep 1
echo ''
echo ''
echo ===========================================================
echo 'checking the previous Plugin Server directory exist'
echo ===========================================================
echo ''

if (Test-Path -Path $MinecraftServerPath -PathType Container) 
{
    "Previous MineCraft Plugin Server Directory already exists. Please remove the previous Plug in server directory first "
    Break
    pause
}
else
{
    Write-Host "Plugin server directory is empty move to next step"
}


##########################################################
# 스탭 3 : 모드 버전 정보 받기
##########################################################
sleep 1
echo ''
echo ===============================================================================
echo 'https://getbukkit.org/download/spigot'
echo 'Pease refer the minecraft spigot site then find the version of plugin server'
echo ===============================================================================
echo ''
$PluginVersion = Read-Host -Prompt "Type the version "
$clientURL = "https://download.getbukkit.org/spigot/spigot-"+${PluginVersion}+".jar"
$filePath = $env:USERPROFILE + "\Downloads\" + $dirname
$clientExe = "spigot-"+${PluginVersion}+".jar"
$downloadlocation = $filePath + "\" + $clientExe



##########################################################
# 스탭 4 : 모드 버전 URL 확인
##########################################################
sleep 1
echo ''
echo ===============================================================
echo 'Checking the URL validation'
echo ===============================================================
echo ''
cd $env:USERPROFILE\"Downloads"
md $dirname
cd $env:USERPROFILE\"Downloads"\$dirname
(New-Object System.Net.WebClient).DownloadFile($clientURL,$downloadlocation) 
if($? -eq "0"){
    Write-Host "Plugin server file download has been competed."
    sleep 2
}else{
    Write-Host "Given plugin server file information was not correct. Please verify plugin server version and try it again."
    pause
}



##########################################################
# 스탭 5 : 초벌 실행
##########################################################
iex 'java -Xms1G -Xmx1G -jar spigot-${PluginVersion}.jar' 



##########################################################
# 스탭 6 : EULA
##########################################################
out-file -filepath .\eula.txt -encoding ascii -inputobject $euel



##########################################################
# 스탭 7 : run.bat 파일 생성
##########################################################
$RunBat=
"
java -Xms1G -Xmx1G -jar spigot-${PluginVersion}.jar
pause
"
 
out-file -filepath $MinecraftServerPath\run.bat -encoding ascii -inputobject $RunBat



##########################################################
# 스탭 8 : 방화벽 개방
##########################################################
sleep 1
echo ''
echo ''
echo ''
echo ==========================================
echo 'Adding firewall fule for MineCraft'
echo '25565(TCP) / 25565(UDP)'
echo ==========================================
sleep 2

New-NetFirewallRule -DisplayName "MineCraftTCP25565" -Direction inbound -Profile Any -Action Allow -LocalPort 25565 -Protocol TCP
New-NetFirewallRule -DisplayName "MineCraftUDP25565" -Direction inbound -Profile Any -Action Allow -LocalPort 25565 -Protocol UDP
Start-Sleep -Seconds 1


##########################################################
# 스탭 9 : Playit 다운로드
##########################################################
sleep 1
echo ''
echo ''
echo ''
echo ===========================================================
echo 'Playit donwload in progress'
echo ===========================================================
sleep 1
$downloadlocation2 = $filePath + "\" + $PlayitName
(New-Object System.Net.WebClient).DownloadFile($PlayitURL,$downloadlocation2)



##########################################################
# 스탭 10 : 설치 완료
##########################################################
echo ''
echo ''
sleep 1
echo ===========================================================
echo 'All installation task has been completed'
echo 'move to Downloads folder then excute the "run.bat" file to start plugin server '
echo 'Dont forget subscribe and like my channel :)'
echo 'https://www.youtube.com/@koryechtim'
echo ===========================================================
echo ''
echo ''
echo 'Please type the enter to exit'
echo ''
pause
