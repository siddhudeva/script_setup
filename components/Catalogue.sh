#!/bin/bash
# Author : siddhu
#Date : 12/12/2021
# Description : This is a setup file for catalogue services for Roboshop project

source components/common.sh

yum install nodejs make gcc-c++ -y &>>"${Log_file}"
Status $? "Nodejs Installation process"

grep roboshop /etc/passwd &>>"${Log_file}"
if [ $? -ne 0 ]; then
  useradd roboshop
fi
Status $? "roboshop user status"

sudo su - roboshop &>>"${Log_file}"
Status $? "Switching to user"

sudo curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>"${Log_file}"
Status $? "Catalogue file Download"

sudo unzip -o /tmp/catalogue.zip &>>"${Log_file}" && mv catalogue-main catalogue
Status $? "Unzipping content"

exit
Status $? "exiting from user"

cd /home/roboshop/catalogue && npm install "&>>${Log_file}"
Status $? "npm install"

exit &>>"${Log_file}"
Status $? "existed from user account"

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Status $? "catalogue services placing "

systemctl daemon-reload &>>"${Log_file}"
systemctl enable catalogue &>>"${Log_file}" && systemctl start catalogue
Status $? "catalogue service"
