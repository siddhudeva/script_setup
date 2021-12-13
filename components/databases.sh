#!/bin/bash
# Author : Siddhu
# Date : 12/12/2021
# Description : This is a database components all in one file of roboshop project

source components/common.sh

echo -e "\e[5;36m --------- This is redisDB setup ------------\e[0m"

DOWNLOAD redis -o /etc/yum.repos.d/redis.repo &>>"${Log_file}"
Status $? "Creating Redis Repository "

yum install redis -y &>>"${Log_file}"
Status $? "redis installation"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis/redis.conf
Status $? "Configaration"


systemctl enable redis &>>"${Log_file}" && systemctl start redis

Status $? "enable and starting of redis"

echo -e "\e[5;36m --------- This is Mongodb setup ------------\e[0m"

DOWNLOAD Mongodb &>>${Log_file}

yum install -y mongodb-org &>>${Log_file}
Status $? "MongoDb installation"

systemctl enable mongod && systemctl start mongod &>>${Log_file}
Status $? "Mongodb enabling and starting"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &>>${Log_file}
Status $? "configaration update"

systemctl restart mongod &>>${Log_file}
Status $? "restarting of MongoDB"

DOWNLOAD mongodb &>>${Log_file}
Status $? "Schema downloading"

cd /tmp/ && unzip -o mongodb.zip &>>${Log_file}
Status $? "Unzipping "

cd ./mongodb-main

mongo < catalogue.js &>>${Log_file}  && mongo < users.js &>>${Log_file}
Status $? "Schema Installation"

echo -e "\e[5;36m --------- This is Rabbitmq setup ------------\e[0m"


curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>"${Log_file}"
Status $? "Downloading rabbitmq repositories"

yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y rabbitmq-server -y &>>"${Log_file}"
Status $? "Erlang and RabbitMq installation"

systemctl enable rabbitmq-server &>>"${Log_file}" && systemctl start rabbitmq-server &>>"${Log_file}"
Status $? "Enabling and install"

rabbitmqctl list_users | grep roboshop &>>"${Log_file}"
  if [ "$?" -ne 0 ]; then
rabbitmqctl add_user roboshop roboshop123 &>>"${Log_file}" && rabbitmqctl set_user_tags roboshop administrator &>>"${Log_file}"
fi
Status $? "rabbitmq user adding"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>"${Log_file}"
Status $? "rabbitmq permissions adding"
