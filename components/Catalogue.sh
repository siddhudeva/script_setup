#!/bin/bash
# Author : siddhu
#Date : 12/12/2021
# Description : This is a setup file for catalogue services for Roboshop project

source components/common.sh

yum install nodejs make gcc-c++ -y &>>${LOG_file}
Status $? "Nodejs Installation process"

cat /etc/passwd | grep roboshop &>>${LOG_file}
if [ "$?" -ne 0 ]; then
  useradd roboshop
fi
Status $? "roboshop user status"

su - roboshop &>>${LOG_file}
Status $? "Switching to user"

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>${LOG_file}
Status $? "Catalogue file Download"

unzip -o /tmp/catalogue.zip &>>${LOG_file} && mv catalogue-main catalogue
Status $? "Unzipping content"

cd /home/roboshop/catalogue && npm install &>>${LOG_file}
Status $? "npm install"

exit &>>${LOG_file}
Status $? "existed from user account"

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Status $? "catalogue services placing "

systemctl daemon-reload &>>${LOG_file}
systemctl enable catalogue &>>${LOG_file} && systemctl start catalogue
Status $? "catalogue service"
