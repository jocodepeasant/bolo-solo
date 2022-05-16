#! /bin/bash
set -x
set +e
name=bolo
if [ ! -d "/tmp" ]; then
    mkdir /tmp
fi

echo "开始拉取最新代码"
cd /tmp \
&& git clone https://github.com/jocodepeasant/bolo-solo.git \

#判断容器是否存在，存在则删除
docker ps -a | grep $name &> /dev/null
if [ $? -eq 0 ]; then
    echo "暂停并删除旧容器及镜像"
    docker stop $name
    docker rm $name
    rm /dev/null
fi

echo "开始构建 docker 容器"
cd bolo-solo \
&& docker build -t bolo:latest .

echo "开始运行容器"
docker run -it --name $name -d -p8080:8080 --env RUNTIME_DB="MYSQL" \
--env JDBC_USERNAME="root" \
--env JDBC_PASSWORD="fzb8004568933" \
--env JDBC_DRIVER="com.mysql.cj.jdbc.Driver" \
--env JDBC_URL="jdbc:mysql://116.205.172.86:3306/solo?useUnicode=yes&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC" \
bolo --listen_port=8080 --server_scheme=https --server_host=www.smartling.top