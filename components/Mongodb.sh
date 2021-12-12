#!/bin/bash
#This is mongodb File by Roboshop


source components/common.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo

yum install -y mongodb-org
Status $? "MongoDb installation"

systemctl enable mongod && systemctl start mongod
Status $? "Mongodb enabling and starting"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf
Status $? "configaration update"

systemctl restart mongod
Status $? "restarting of MongoDb"

curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
Status $? "Schema downloading"

cd /tmp/ && unzip mongodb.zip
Status $? "Schema downloading"
cd mongodb-main

mongo < catalogue.js && mongo < users.js
Status $? "Schema downloading"
