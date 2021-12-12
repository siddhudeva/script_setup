#!/bin/bash
#This is mongodb File by Roboshop


source components/common.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${Log_file}

yum install -y mongodb-org &>>${Log_file}
Status $? "MongoDb installation"

systemctl enable mongod && systemctl start mongod &>>${Log_file}
Status $? "Mongodb enabling and starting"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &>>${Log_file}
Status $? "configaration update"

systemctl restart mongod &>>${Log_file}
Status $? "restarting of MongoDB"

curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>${Log_file}
Status $? "Schema downloading"

cd /tmp/ && unzip mongodb.zip &>>${Log_file}
Status $? "Unzipping "

mongo < catalogue.js && mongo < users.js &>>${Log_file}
Status $? "Schema Installation"
