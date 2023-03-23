# define variable
$javaInstaller = "https://download.oracle.com/java/20/latest/jdk-20_windows-x64_bin.msi"
$clientExe = "server.jar"
$PlayitName = "playit-0.9.3-signed.exe"
$clientURL = "https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar"
$PlayitURL = "https://github.com/playit-cloud/playit-agent/releases/download/v0.9.3/playit-0.9.3-signed.exe"
$dirname = "minecraft_server"
$MinecraftServerPath = $env:USERPROFILE + "\Downloads\" + $dirname
$filePath = $env:USERPROFILE + "\Downloads\" + $dirname
$euel = "eula=true"
$downloadlocatoin = $filePath + "\" + $clientExe
$downloadlocatoin2 = $filePath + "\" + $PlayitName
$server_start = "java -Xmx1G -Xms1G -jar server.jar nogui"



echo 'Starting Install Minecraft 1.19.4'
echo 'Script Ver 1.19.4'
Start-Sleep -Seconds 3

# download Minecraft server
cd $env:USERPROFILE\"Downloads"
md $dirname
cd $env:USERPROFILE\"Downloads"\$dirname
echo ===========================================================
echo 'Minecraft server inital file downloading'
echo ===========================================================
(New-Object System.Net.WebClient).DownloadFile($clientURL,$downloadlocatoin)


# launch Minecraft server for first time
iex 'java -Xmx1024M -Xms1024M -jar server.jar nogui'

# Modify License to Agree
out-file -filepath .\eula.txt -encoding ascii -inputobject $euel
out-file -filepath .\server_start.bat -encoding ascii -inputobject $server_start

echo ''
echo ''
echo ''
echo ===========================================================
echo 'Playit Downloading'
echo ===========================================================
(New-Object System.Net.WebClient).DownloadFile($PlayitURL,$downloadlocatoin2)
#wget Uri $portminerURL -OutFile $downloadlocatoin2
#Expand-Archive $MinecraftServerPath\$PortMinerName -DestinationPath $MinecraftServerPath

# Firewall Rules
echo ''
echo ''
echo ''
echo ==========================================
echo 'Adding firewall fule for MineCraft'
echo '25565(TCP) / 25565(UDP)'
echo ==========================================
# define variable for firewall
New-NetFirewallRule -DisplayName "MineCraftTCP25565" -Direction inbound -Profile Any -Action Allow -LocalPort 25565 -Protocol TCP
New-NetFirewallRule -DisplayName "MineCraftUDP25565" -Direction inbound -Profile Any -Action Allow -LocalPort 25565 -Protocol UDP
Start-Sleep -Seconds 3



echo ''
echo ''
echo ''
echo ==========================================
echo 'Please Subscribe My channel : Tech Tim'
echo 'https://www.youtube.com/@koryechtim'
echo ==========================================
echo 'All installation task has been completed'
echo 'Please type the Enter to exit'
pause

