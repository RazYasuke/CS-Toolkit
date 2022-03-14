#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

#Super User Privilege Is Necessary
TDate=$(date +"%d_%m_%y_%H_%M")
BName="BloodHoundLog_"$TDate".txt"
printf  "${RED}Initializing Linux System User and Access Audit...\n${NC}"
printf "${RED}Enter Exact Admin User Name\n${NC}"
read UName
cd /home/$UName/
if [[ -d /home/$UName/research ]] 
then
    cd /research
else
    mkdir research
    cd /research
fi
printf "Time Stamp: $TDate\n\n" > $BName
echo "-----Beginning of Report-----" 
echo "-----Beginning of Report----- \n" >> $BName

if [[ -f /var/log/auth.log ]]
then
  printf "The auth.log file exists\n"
  printf "The auth.log file exists\n" >> $BName
    ls /var/log/auth.log 
    ls /var/log/auth.log >> $BName 
else
    printf "${RED} The auth.log file does not exist\n${NC}"
    printf "${RED} The auth.log file does not exist\n${NC}" >> $BName
fi

if [[ -d /home/$UName/Desktop && /home/$UName/Downloads ]]
then
    printf "The Desktop and Download folders exists\n"
    printf "The Desktop and Download folders exists\n" >> $BName
    ls /home/$UName/ >> $BName
    ls /home/$UName/Desktop >> $BName
    ls /home/$UName/Downloads >> $BName
else

fi
