#!/bin/bash
# This is a Frontend Setup file

source components/common.sh

yum install nginx -y
Status $? "Nginx installation"

systemctl enable nginx && systemctl start nginx
Status $? "Nginx services"

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
Status $? "Download of project"

rm -rf /usr/share/nginx/html/*
Status  $? "Removed Nginx Files is"

cd /usr/share/nginx/html/ && unzip /tmp/frontend.zip
Status $? "Unzipping"

mv frontend-main/* . && mv static/* .
Status $? "all content moved to Frontend File"

rm -rf frontend-master static README.md
Status $? "Removed Unwanted files is"

mv localhost.conf /etc/nginx/default.d/roboshop.conf
Status $? "Moving the conf file to proper Location"

systemctl restart nginx
Status $? "Restarting of Nginx is"