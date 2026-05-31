#!/bin/bash
LOGS_FOLDER="/var/log/roboshop"
sudo mkdir -p $LOGS_FOLDER
sudo chown -a ec2-user:ec2-user $LOGS_FOLDER
sudo chown -a 755 $LOGS_FOLDER
LOGS_FILE="$LOGS_FLODER/$0.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$[ date "+%Y-%m-%d %H:%M:%S"]

if [ $USERID -ne 0 ]; then
    echo -e "$TIMESTAMP [ERROR] $R please sun this script with root access" | tee -a $LOGS_FILE
    exit 1
fi
VALIDATE(){
    if [ $1 -ne 0 ]; then 
        echo -e "$TIMESTAMP [ERROR] $2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else 
        echo -e "$TIMESTAMP [ERROR] $2 ... $G SUCESS $N" | tee -a $LOGS_FILE
}

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"
