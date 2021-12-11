#!/bin/bash

# Author : siddhu
#Date : 11/12/2021
#Description : Roboshop project main service setup contains Validation script

# validation of user either root or normal user: only root or sudo users only allow to install the softwares

User=$(id -u)
if [ "$User" -ne 0 ]; then
  echo -e "\e[1;31m YOu are not a root or sudo user to perform this task\e[0m"
  exit
fi
# Validation for component name is entered or not
Cmpnt=$1
if [ -z "$Cmpnt" ]; then
  echo -e "\e[1;31m Please Enter a Component name\e[0m"
  exit
fi
#validating the component name is correct or not
if [ ! -e ./components/"${Cmpnt}".sh ]; then
  echo -e "\e[1;31m You entered file $1 does not exist\e[0m"
  exit
fi

Status() {
  if [ "$1" -ne 0 ]; then
  echo -e "\e[m ${2} is Failure\e[1m"
else
  echo -e "\e[1;32 ${2} is Success\e[1m"
  exit 1
fi
}




