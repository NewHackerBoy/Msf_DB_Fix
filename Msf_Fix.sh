#!/bin/bash
## i have used `tput civis`  for hide cursor and for normal state `tupt cnorm`
## Note: for "tput" function first you should install **ncurses-utils** package.. then you can use the code..

spin () {

local pid=$!
local delay=0.25
local spinner=( '█■■■■' '■█■■■' '■■█■■' '■■■█■' '■■■■█' )

while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do

for i in "${spinner[@]}"
do
	tput civis
	echo -ne "\033[34m\r[*] Downloading...Please...wait.........\e[33m[\033[32m$i\033[33m]\033[0m   ";
	sleep $delay
	printf "\b\b\b\b\b\b\b\b";
done
done
printf "   \b\b\b\b\b"
tput cnorm
printf "\e[1;33m [Done]\e[0m";
echo "";

}

clear;
echo "";
sleep 1
echo -e "\e[1;34m[*] \e[32mInstalling Packages....\e[0m";
echo "";
(apt update && apt upgrade -y) &> /dev/null;
(apt install figlet pv ncurses-utils binutils coreutils wget git tar patch -y) &> /dev/null;
termux-wake-lock;

clear;
echo "";
echo -e "\033[33m$(figlet -f New_Hacker_Boy "msf patch")\e[0m"
echo -e "\e[1;32m
+--------------------------------------*/
New_Hacker_Boy : (\e[33m1.12.2019\e[32m)
1. database error permanent fix
+--------------------------------------*/
\033[0m";
tput setaf 3;
read -p  "Do you want to setup this ? (y/n) " PROC33

tput sgr 0
if [ "$PROC33" = "y" ]; then

if [ -d $PREFIX/opt/metasploit-framework ]; then
echo
pg_ctl -D $PREFIX/var/lib/postgresql restart &> /dev/null
proces=`ps -e | grep postgres | head -n 1 | gawk '{ print $4 }'`

if [ "$proces" = "postgres" ]; then
(patch $(which msfconsole) < .msf.patch) &> /dev/null
echo -e "\e[1;34m[*] \e[32mmsfconsole successfully patched..\e[0m";
echo
echo -e "\e[1;34m[*] \e[32mNow you can use msfconsole..\e[0
m";
else
rm -rf $PREFIX/var/lib/postgresql &> /dev/null
mkdir -p $PREFIX/var/lib/postgresql &> /dev/null
initdb $PREFIX/var/lib/postgresql &> /dev/null
pg_ctl -D $PREFIX/var/lib/postgresql start &> /dev/null
createuser msf &> /dev/null
createdb msf_database &> /dev/null
killall postgres &> /dev/null
pg_ctl --log=$HOME/.log_msf -D $PREFIX/var/lib/postgresql start &> /dev/null

(patch $(which msfconsole) < .msf.patch) &> /dev/null
echo -e "\e[1;34m[*] \e[32mmsfconsole successfully patched..\e[0m";
echo
echo -e "\e[1;34m[*] \e[32mNow you can use msfconsole..\e[0m";
fi
#rm .msf.patch
else
echo -e "\e[1;34m[*] \e[32mI Am Sorry. You Haven't Downloaded Metasploit From Unstable-Repo Or Your Metasploit Not Present On $PREFIX/opt directory..\e[0m";
fi
fi
termux-wake-unlock
exit 0