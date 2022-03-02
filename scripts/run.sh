docker rm redis
docker run -p 127.0.0.1:6379:6379 --name redis -d redis redis-server --save 60 1 --loglevel warning
docker run -it --network host --rm redis redis-cli ping | grep PONG
[ 0 -eq $? ] || {
    echo Redis is not working properly.
    exit 1
}

image="${1:-openapi_server}"
data_path="${2:-/tmp}"
bash generate_code.sh $image &&\
bash extend_code.sh &&\
bash test_code.sh $image $data_path
