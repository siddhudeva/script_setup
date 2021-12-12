#!/bin/bash
# AUTHOR : SIDDHU
# DATE : 12/12/2021
#DESCRIPTION : THIS IS A SETUP FILE OF RABBITMQ SERVICE FOR ROBOSHOP PROJECT

source components/common.sh

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>"${Log_file}"
Status $? "Downloading rabbitmq repositories"

yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y rabbitmq-server -y &>>"${Log_file}"
Status $? "Erlang and RabbitMq installation"

systemctl enable rabbitmq-server &>>"${Log_file}" && systemctl start rabbitmq-server &>>"${Log_file}"
Status $? "Enabling and install"

rabbitmqctl list_users | grep roboshop &>>"${Log_file}"
  if [ $? - ne 0 ]; then
rabbitmqctl add_user roboshop roboshop123 &>>"${Log_file}" && rabbitmqctl set_user_tags roboshop administrator &>>"${Log_file}"
Status $? "rabbitmq user adding"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>"${Log_file}"
Status $? "rabbitmq permissions adding"
