#!/bin/bash

#----printf color----
red="\e[1;31m"
green="\e[1;32m"
yellow="\e[1;33m"
blue="\e[1;34m"
normal="\e[0m"

#----echo color----
nocolor='\033[0m'
red='\033[0;31m'
green='\033[0;32m'
orange='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[1;37m'

# More color in: https://gist.github.com/jonsuh/3c89c004888dfc7352be

#-------------------

printf "
$red<--------------------------------------------->$normal $blue
  ______   _______ _______ ____    ____ ____
  |     \  |     | |     | |  |    |  | |  |
  |      \ |  ___| |  ___| |  |    |  | |  |
  |       \|  |_   |  |_   |  |    |  | |  |
  |       /|   |   |   _|  |   \__/   | |  |
  |      / |  |__  |  |     \        /  |  |__
  |_____/  |_____| |__|      \______/   |_____| $normal

$red<---------------------------------------------->$normal $blue
           ________________________
           |                      |
           |  Criado por: Defallt |
           |  Versão: 1.0         |
           |  Data: 30/05/2024    |
           |  Revisão: 03/06/2024 |
           |______________________| $normal

$red<---------------------------------------------->$normal
"
echo -e ""
read -p "Digite o IP: " ip
read -p "Digite a wordlist: " wl

printf "
$red<----------------------------------------------->$normal
"
echo -e "${orange}\nPáginas encontradas:\n${nocolor}"

for eachItem in $(cat $wl); do
        status=$(curl -s -I "http://$ip/$eachItem" -o /dev/null -w "%{http_code}")

        if [ $status != 404 ];
        then
        echo -e "${green}URL: http://$ip/$eachItem      (Status:$status) ${nocolor}"
        fi
done

echo -e "${orange}\nResultado do grep:${nocolor}"

for eachWord in $(cat $wl); do
        status=$(curl -s -I "http://$ip/$eachWord" -o /dev/null -w "%{http_code}")

        if [ $status == 200 ];
        then
                echo -e "${green}Página: $eachWord ${nocolor}"
                echo -e "${cyan}Comentário:"
                curl -s "http://$ip/$eachWord" | grep "<\!--"
                echo -e "${nocolor}"
        fi
done

printf "
$red<----------------------FIM----------------------->$normal
"
