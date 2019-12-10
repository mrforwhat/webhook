#!/bin/bash

WORK_PATH='/home/app/blog-api'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "编译打包"
npm run build
echo "开始构建"
docker build -t blog-front:1.0 .
echo "停止旧容器并删除旧容器"
docker stop blog-front-container
docker rm blog-front-container
echo "启动新容器"
docker container run -p 80:7 --name blog-front-container -d blog-front:1.0
