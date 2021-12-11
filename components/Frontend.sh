#!/bin/bash
# This is a Frontend Setup file

yum install nginx -y
Status $? 'Nginx installation'

systemctl enable nginx && systemctl start nginx
Status $? 'Nginx services'
