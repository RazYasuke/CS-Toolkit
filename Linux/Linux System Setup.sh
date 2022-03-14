#! /bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

printf  "${RED}Initializing Linux System Setup with Reports and Hardening...\n${NC}"

cd /etc/
printf "${RED}Step 1: Ensure/Double Check Permissions on Sensitive Files\n${NC}"
 
printf "${RED}Previous shadow file permissions\n${NC}"
ls -l shadow

printf "${RED}Setting new permissions 600 on shadow (rw for root only)...\n${NC}"
sudo chmod u+rw,u-x,go-rwx shadow
printf "${RED}New shadow file permissions\n${NC}"
ls -l shadow

printf "${RED}Previous gshadow file permissions\n${NC}"
ls -l gshadow

printf "${RED}Setting new permissions 600 on gshadow (rw for root only)...\n${NC}"
sudo chmod u+rw,u-x,go-rwx gshadow
printf "${RED}New gshadow file permissions\n${NC}"
ls -l gshadow

printf "${RED}Previous group file permissions\n${NC}" 
ls -l group

printf "${RED}Setting new permissions 644 on group (rw for root and r for anyone)...\n${NC}"
sudo chmod go+r,u+rw,u-x,go-wx group
printf "${RED}New group file permissions\n${NC}"
ls -l group

printf "${RED}Previous passwd file permissions\n${NC}" 
ls -l passwd

printf "${RED}Setting new permissions 644 on grpasswdoup (rw for root and r for anyone)\n${NC}"
sudo chmod go+r,u+rw,u-x,go-wx passwd
printf "${RED}New passwd file permissions\n${NC}"
ls -l passwd


printf "${RED}Step 2: Create User Accounts\n${NC}"

printf "${RED}Enter User Name: \n${NC}"
read UAName
sudo useradd $UAName
printf "${RED}Do you have another user to add? [Y/N]\n${NC}"
read UReq
while [[ "$UReq" == "Y" || "$UReq" == "y" ]]; do
    printf "${RED}Enter User Name: \n${NC}"
    read UAName
    sudo useradd $UAName
    printf "${RED}Do you have another user to add? [Y/N]\n${NC}"
    read UReq
done
printf "${RED}User creation completed!\n${NC}"

printf "${RED}Creating Administrator-admin...\n${NC}"
    sudo useradd admin

    sudo usermod -aG sudo admin

    groups admin -> admin : admin sudo


printf "${RED}Step 3: Create User Group and Collaborative Folder\n${NC}"

printf "${RED}Enter Group Name: \n${NC}"
read GName
sudo groupadd $GName
sudo mkdir /home/$GName
sudo chown :$GName /home/$GName
printf "${RED}Do you have another group to add? [Y/N]\n${NC}"
read GReq
while [[ "$GReq" == "Y" || "$GReq" == "y" ]]; do
    printf "${RED}Enter User Name: \n${NC}"
    read GName
    sudo groupadd $GName
    sudo mkdir /home/$GName
    sudo chown :$GName /home/$GName
    printf "${RED}Do you have another group to add? [Y/N]\n${NC}"
    read GReq
done
printf "${RED}Group creation completed!\n${NC}"

printf "${RED}This is where Users are bound to their Groups.\n${NC}"
printf "${RED}Enter Group Name: \n${NC}"
read GBName
printf "${RED}Enter User Name: \n${NC}"
read GBUser
sudo usermod -G $GBName $GBUser
printf "${RED}Do you have another user and group to bind? [Y/N]\n${NC}"
read GReq
while [[ "$GReq" == "Y" || "$GReq" == "y" ]]; do
    printf "${RED}Enter Group Name: \n${NC}"
    read GBName
    printf "${RED}Enter User Name: \n${NC}"
    read GBName
    sudo usermod -a -G $GBName $GBUser
    printf "${RED}Do you have another user and group to bind? [Y/N]\n${NC}"
    read GReq
done
printf "${RED}Group and User binding completed!\n${NC}"


printf "${RED}Step 4: Lynis Auditing and CHRootkit Reporting\n${NC}"

printf "${RED}Installing Lynis...\n${NC}"
sudo apt-get install lynis
 
printf "${RED}Lynis documentation\n${NC}"
sudo lynis 

printf "${RED}-----Lynis system audit-----\n${NC}"
sudo lynis audit system

printf "${RED}Installing CHRootkit\n${NC}"
sudo apt-get install chkrootkit

printf "${RED}Expert Mode\n${NC}"
sudo chkrootkit -x > CHRootkitExpertMode-report.txt
printf "${RED}CHRootkitExpertMode-report.txt file created${NC}"

printf "${RED}-----CHRootkit Report-----\n${NC}"
sudo chkrootkit -x | grep infected

printf "${RED}CHRootkit documentation\n${NC}"
man chkrootkit