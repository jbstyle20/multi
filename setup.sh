#!/bin/bash
 

MYIP=$(curl -sS ipv4.icanhazip.com)

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi

mkdir -p /etc/alexxa
mkdir -p /etc/alexxa/theme
mkdir -p /var/lib/alexxa-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/alexxa-pro/ipvps.conf

mkdir -p /etc/xray
mkdir -p /etc/v2ray
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/scdomain
touch /etc/v2ray/scdomain


echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 0.5
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 0.5
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 0.5
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  sleep 0.5
  echo -e "[ ${yell}WARNING${NC} ] Try to install ...."
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  apt-get --yes install $REQUIRED_PKG
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${tyblue}NOTES${NC} ] If error you need.. to do this"
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${tyblue}NOTES${NC} ] apt update && upgrade"
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${tyblue}NOTES${NC} ] After this"
  sleep 0.5
  echo -e "[ ${tyblue}NOTES${NC} ] Then run this script again"
  echo -e "[ ${tyblue}NOTES${NC} ] enter now"
  read
else
  echo -e "[ ${green}INFO${NC} ] Oke installed"
fi

ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
  rm /root/setup.sh >/dev/null 2>&1 
  exit
else
  clear
fi


secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Aight good ... installation file is ready"
sleep 0.5
echo -ne "[ ${green}INFO${NC} ] Check permission : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!"
rm setup.sh > /dev/null 2>&1
sleep 0.5
exit 0
fi
sleep 0.5

mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf

echo ""
wget -q https://raw.githubusercontent.com/jbstyle20/multi/aio/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

yellow "Add Domain for vmess/vless/trojan dll"
echo " "
read -rp "Input ur domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/xray/scdomain
echo "IP=$pp" > /var/lib/alexxa-pro/ipvps.conf
   
#install ssh ovpn
echo -e "\e[33m?????????????????????????????????????????????????????????????????????????????????????????????????????????\033[0m"
echo -e "$green      Install SSH Websocket               $NC"
echo -e "\e[33m?????????????????????????????????????????????????????????????????????????????????????????????????????????\033[0m"
sleep 0.5
clear
wget -O ssh-vpn.sh https://raw.githubusercontent.com/jbstyle20/multi/aio/ssh/ssh-vpn.sh && chmod +x ssh-vpn.shh && ./ssh-vpn.sh
wget https://raw.githubusercontent.com/jbstyle20/multi/aio/openvpn/ohp.sh && chmod +x ohp.sh && ./ohp.sh
#Instal Xray
echo -e "\e[33m?????????????????????????????????????????????????????????????????????????????????????????????????????????\033[0m"
echo -e "$green          Install XRAY              $NC"
echo -e "\e[33m?????????????????????????????????????????????????????????????????????????????????????????????????????????\033[0m"
sleep 0.5
clear
wget -O ins-xray.sh https://github.com/jbstyle20/multi/blob/aio/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
wget https://raw.githubusercontent.com/jbstyle20/multi/aio/xtls/xtls.sh && chmod +x xtls.shh && ./xtls.sh

clear
#Install SSH Websocket
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|      PROCESS INSTALLED WEBSOCKET SSH     |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget -O  insshws.sh https://raw.githubusercontent.com/jbstyle20/multi/aio/websocket/insshws.sh && chmod +x insshws.sh && ./insshws.sh
#Download Extra Menu
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|           DOWNLOAD EXTRA MENU            |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
wget https://raw.githubusercontent.com/jbstyle20/multi/aio/menu/update.sh && chmod +x update.sh && ./update.sh
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/jbstyle20/multi/aio/version )
echo $serverV > /opt/.ver
b=11
if [ $aureb -gt $b ]
curl -sS ifconfig.me > /etc/myipvps

echo " "
echo "Installation has been completed!!"
echo " "
echo "=========================[SCRIPT ANGGUN]========================"
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI SSH ]" | tee -a log-install.txt
echo "    -------------------------" | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - Stunnel4                : 447, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80 [ON]"  | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI  Bdvp, Ngnx]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI Shadowsocks-R & Shadowsocks]"  | tee -a log-install.txt
echo "    ---------------------------------------" | tee -a log-install.txt
echo "   - Websocket Shadowsocks   : 443"  | tee -a log-install.txt
echo "   - Shadowsocks GRPC        : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI XRAY]"  | tee -a log-install.txt
echo "    ----------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws None Tls  : 80"  | tee -a log-install.txt
echo "   - Xray Vless Ws None Tls  : 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI TROJAN]"  | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - Websocket Trojan        : 443"  | tee -a log-install.txt
echo "   - Trojan GRPC             : 443"  | tee -a log-install.txt
echo "   --------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On           : $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Backup & Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "=========================[SCRIPT ANGGUN]========================"
echo ""
sleep 3
echo -e "    ${tyblue}.------------------------------------------.${NC}"
echo -e "    ${tyblue}|     SUCCESFULLY INSTALLED THE SCRIPT     |${NC}"
echo -e "    ${tyblue}'------------------------------------------'${NC}"
echo ""
echo -e "   ${tyblue}Your VPS Will Be Automatical Reboot In 10 seconds${NC}"
rm /root/setup.sh >/dev/null 2>&1
rm /root/ssh-vpn.sh
rm /root/ins-xray.sh
rm /root/insshws.sh 
rm /root/xtls.sh
rm /root/ohp.sh
rm /root/update.sh
sleep 10
reboot
