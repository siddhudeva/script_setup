#!/bin/bash
# This is a Frontend Setup file

source components/common.sh

yum install nginx -y &>>/tmp/Logs
Status $? "Nginx installation"

systemctl enable nginx && systemctl start nginx &>>/tmp/Logs
Status $? "Nginx services"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/Logs
Status $? "Download of project"

rm -rf /usr/share/nginx/html/* &>>/tmp/Logs
Status  $? "Removed Nginx Files is"

cd /usr/share/nginx/html/ && unzip /tmp/frontend.zip &>>/tmp/Logs
Status $? "Unzipping"

mv frontend-main/* . && mv static/* . &>>/tmp/Logs
Status $? "all content moved to Frontend File"

rm -rf frontend-master static README.md &>>/tmp/Logs
Status $? "Removed Unwanted files is"

mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/Logs
Status $? "Moving the conf file to proper Location"

systemctl restart nginx &>>/tmp/Logs
Status $? "Restarting of Nginx is"