#!/bin/bash

WORK_PATH='/home/app/blog-api'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "开始构建"
docker build -t blog-api:1.0 .
echo "停止旧容器并删除旧容器"
docker stop blog-api-container
docker rm blog-api-container
echo "启动新容器"
docker container run -p 3000:3000 --name blog-api-container -d blog-api:1.0
