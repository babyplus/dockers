original_path=`pwd`
exec_path=`dirname $0`
cd $exec_path
data_path=${1:-/tmp}
docker run -d -p 127.0.0.1:8000:8000 -v $data_path:/tmp --rm python:3-alpine python -m http.server -d /tmp
cd $original_path
