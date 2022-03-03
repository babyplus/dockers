version="`date +%Y%m%d`"
original_path=`pwd`
exec_path=`dirname $0`

data_path=${1:-/tmp}

# redis
docker rm redis
docker run -p 127.0.0.1:6379:6379 --name redis -d redis redis-server --save 60 1 --loglevel warning
docker run -it --network host --rm redis redis-cli ping | grep PONG
[ 0 -eq $? ] || {
    echo Redis is not working properly.
    exit 1
}

# ansible_ping_test
cd $original_path/$exec_path
cd ../ansible_ping_test/scripts
path="`pwd`"
path=${path%/*}
bash check.sh ansible_ping_test:$version
rc=$?
[ 1 -eq $rc ] && {
    echo "ansible_ping_test: SSH configuration ($path/etc/ansible/hosts) error"
    exit 1
}
[ 2 -eq $rc ] && {
    echo "ansible_ping_test: The script is already running"
}
[ 0 -eq $rc ] && {
    nohup bash repeated_ping.sh ansible_ping_test:$version &>/dev/null &
}

# echarts-node-export-client
cd $original_path/$exec_path
cd ../echarts-node-export-client/scripts
bash build.sh export-client:$version
# Nothing to do 

# echarts-node-export-server
cd $original_path/$exec_path
cd ../echarts-node-export-server/scripts
bash build.sh exportapp:$version
bash run.sh exportapp:$version

# flask-gentelella
cd $original_path/$exec_path
cd ../flask-gentelella
path=`pwd`
docker run -d --rm  -v $path/app:/app -p 5000:5000 --name gentelella  afourmy/flask-gentelella

# nginx_reverse_proxy
cd $original_path/$exec_path
cd ../nginx_reverse_proxy
bash run.sh

# openapi_ping_test
cd $original_path/$exec_path
cd ../openapi_ping_test/scripts
bash run.sh openapi_server:$version $data_path

# python_http_server
cd $original_path/$exec_path
cd ../python_http_server
bash run.sh $data_path

cd $original_path
