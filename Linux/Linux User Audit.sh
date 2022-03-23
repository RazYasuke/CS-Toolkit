#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

#Super User Privilege Is Necessary
TDate=$(date +"%d_%m_%y_%H_%M")
BName="BloodHoundLog_"$TDate".txt"
printf  "${RED}Initializing Linux System User and Access Audit...\n${NC}"
printf "Enter Exact Admin User Name\n"
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
    printf "${RED} The Desktop and Download files do not exist\n${NC}"
    printf "${RED} The Desktop and Download files do not exist\n User Home Directory below.${NC}" >> $BName
    ls /home/$UName/ >> $BName
fi

if [[ -d /bin/cat && /bin/ps ]]
then 
    printf "The cat and ps binary files exist\n"
    printf "The cat and ps binary files exist\n" >> $BName
    ls /bin/cat >> $BName
    ls /bin/ps >> $BName
else
    printf "${RED} The cat and ps files do not exist\n${NC}"
    printf "${RED} The cat and ps files do not exist\n Bin Directory below.${NC}" >> $BName
    ls /bin >> $BName
fi
printf "---Temp Directory---"
ls /tmp >> $BName