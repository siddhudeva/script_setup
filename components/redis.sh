#!/bin/bash
# Author : Siddhu
# Date : 12/12/2021
# Description : This is a redis component of roboshop project

source component/common.sh

curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>"${Log_file}"
Status $? "Creating Redis Repository "

yum install redis -y &>>"${Log_file}"
Status $? "redis installation"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis.conf &>>"${Log_file}" && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/redis/redis.conf &>>"${Log_file}"
Status $? "Configaration"

Start Redis Database &>>"${Log_file}"
Status $? "Starting Database"

systemctl enable redis &>>"${Log_file}" && systemctl start redis
Status $? "enable and starting of redis"
