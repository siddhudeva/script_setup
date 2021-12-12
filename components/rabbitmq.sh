#!/bin/bash
# AUTHOR : SIDDHU
# DATE : 12/12/2021
#DESCRIPTION : THIS IS A SETUP FILE OF RABBITMQ SERVICE FOR ROBOSHOP PROJECT

source components/common.sh

yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>"${Log_file}"
Status $? "Erlang installation"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>"${Log_file}"
Status $? "Downloading rabbitmq repositories"

yum install rabbitmq-server -y &>>"${Log_file}"
Status $? "RabbitMq install"

systemctl enable rabbitmq-server &>>"${Log_file}" && systemctl start rabbitmq-server &>>"${Log_file}"
Status $? "Enabling and install"

rabbitmqctl add_user roboshop roboshop123 &>>"${Log_file}" && rabbitmqctl set_user_tags roboshop administrator &>>"${Log_file}"
Status $? "rabbitmq user addig"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>"${Log_file}"
Status $? "rabbitmq permissions adding"
