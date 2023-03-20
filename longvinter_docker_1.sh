# 계정 생성 및 권한 설정
echo "--------------------------------------------------------"
echo "Tech Tim 채널 구독과 좋아요 부탁 드립니다."
echo "https://www.youtube.com/channel/UCTKC1JQaVY-QvLKyGt84I5w" 
echo 
echo "steamcmd 계정으 생성합니다. 새 패스워드를 넣어 주세요"
echo "--------------------------------------------------------"
echo 
sleep 2


# 호스트명 정렬 # 
cat <<-EOF > /etc/hosts
# Any manual change will be lost if the host name is changed or system upgrades.
127.0.0.1       ${HOSTNAME}                                                      
::1             ${HOSTNAME}  
EOF



useradd -m -d /home/steam steamcmd
passwd steamcmd
usermod -aG sudo steamcmd
chsh -s /bin/bash steamcmd 
su - steamcmd
