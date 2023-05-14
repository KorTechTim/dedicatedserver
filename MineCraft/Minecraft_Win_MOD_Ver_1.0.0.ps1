

#변수 정의
$dirname = "Minecraft_MOD_Server"
$MinecraftServerPath = $env:USERPROFILE + "\Downloads\" + $dirname
$euel = "eula=true"
$PlayitName = "playit-0.9.3-signed.exe"
$PlayitURL = "https://github.com/playit-cloud/playit-agent/releases/download/v0.9.3/playit-0.9.3-signed.exe"




##########################################################
# 스탭 1 : Welcome Message
##########################################################
echo ===========================================================
echo 'TechTim 채널의 자료가 도움 되신다면 구독과 좋아요 부탁 드립니다'
echo 'https://www.youtube.com/@kortechtim'
echo ===========================================================
echo ''



##########################################################
# 스탭 2 : 기존 MOD 디렉토리 존재 확인
##########################################################
sleep 1
echo ''
echo ''
echo ===========================================================
echo 'checking the previous MOD directory exist'
echo ===========================================================
echo ''

if (Test-Path -Path $MinecraftServerPath -PathType Container) 
{
    "MineCraft MOD exists. Please remove the previous MOD directory first "
    Break
    pause
}
else
{
    Write-Host "MOD Directory is Empty moving to next step"
}


##########################################################
# 스탭 3 : 모드 버전 정보 받기
##########################################################
sleep 1
echo ''
echo ===============================================================
echo 'https://files.minecraftforge.net/net/minecraftforge/forge'
echo 'Pease refer the minecraft forge site then type the version of MOD server'
echo ===============================================================
echo ''
$ModVersion = Read-Host -Prompt "Type the version "
$clientURL = "https://maven.minecraftforge.net/net/minecraftforge/forge/"+${MODVersion}+"/forge-"+${MODVersion}+"-installer.jar"
$filePath = $env:USERPROFILE + "\Downloads\" + $dirname
$clientExe = "forge-"+${MODVersion}+"-installer.jar"
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
if($? -eq $True){
    Write-Host "Mod file download has been competed."
    sleep 2
}else{
    Write-Host "Given MOD file information was not correct. Please verify MOD server version again."
    Break
    pause
}





##########################################################
# 스탭 3 : 최대 메모리 사이즈 확인
##########################################################

echo ''
echo ''
echo ===========================================================
echo 'Please type the max momory size of MOD server (MB)'
echo 'ie : 4GB=4096, 8GB=8192, 5100MB=5100'
echo ===========================================================
echo ''
$MaxMemory = Read-Host -Prompt "Type the max memory size(MB) "




##########################################################
# 스탭 5 : 초벌 실행
##########################################################
iex 'java -jar forge-${ModVersion}-installer.jar --installServer'
if($? -ne "True"){
    echo ==========================================
    echo 'There was connection issue with MOJANG studio URl'
    echo 'Unable to complete installation task' 
    echo 'Please try installation task again'
    echo ==========================================
    cd $env:USERPROFILE\"Downloads"\
    Remove-Item $env:USERPROFILE\"Downloads"\$dirname -Recurse
    Break
    pause
}

##########################################################
# 스탭 6 : user_jvm_args 메모리 사이즈 반영
##########################################################
$UserJVMArgs=
"
# Xmx and Xms set the maximum and minimum RAM usage, respectively.
# They can take any number, followed by an M or a G.
# M means Megabyte, G means Gigabyte.
# For example, to set the maximum to 3GB: -Xmx3G
# To set the minimum to 2.5GB: -Xms2500M

# A good default for a modded server is 4GB.
# Uncomment the next line to set it.
-Xmx${MaxMemory}M
"

out-file -filepath $MinecraftServerPath\user_jvm_args.txt -encoding ascii -inputobject $UserJVMArgs

##########################################################
# 스탭 7 : 서버 이니셜 실행 & EULA
##########################################################

iex './run.bat'

out-file -filepath .\eula.txt -encoding ascii -inputobject $euel


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
echo 'move to Downloads folder then excute the "run.bat" file to start MOD server '
echo 'Dont forget subscribe and like my channel :)'
echo 'https://www.youtube.com/@koryechtim'
echo ===========================================================
echo ''
echo ''
echo 'teminate termial Please type the enter to exit'
echo ''
pause
