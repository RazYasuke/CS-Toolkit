#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
FName="ELK_Deployment_Summary.txt"
print "----ELK Summary----\n"
print "SSH key generator\n"
print "----ELK Summary----\n" > $FName
print "Ssh key generator\n" >> $FName
ssh-keygen
print "SSH Key Below"
print "SSH Key Below" >> $FName
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> $FName