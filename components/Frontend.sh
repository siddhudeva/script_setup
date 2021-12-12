#!/bin/bash
# This is a Frontend Setup file

source components/common.sh

yum install nginx -y &>>Log_file
Status $? "Nginx installation"

systemctl enable nginx && systemctl start nginx &>>Log_file
Status $? "Nginx services"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>Log_file
Status $? "Download of project"

rm -rf /usr/share/nginx/html/*  &>>Log_file
Status  $? "Removed Nginx Files is"

cd /usr/share/nginx/html/ && unzip /tmp/frontend.zip &>>Log_file
Status $? "Unzipping"

mv ./frontend-main/* . && mv ./static/* . &>>Log_file
Status $? "all content moved to Frontend File"

rm -rf frontend-master static README.md &>>Log_file
Status $? "Removed Unwanted files is"

mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>Log_file
Status $? "Moving the conf file to proper Location"

systemctl restart nginx &>>/tmp/Logs &>>Log_file
Status $? "Restarting of Nginx is"