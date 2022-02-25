original_path=`pwd`
exec_path=`dirname $0`
cd $exec_path
path=`pwd`
docker run -d --rm --name reverse_proxy_$RANDOM --net host -v $path/conf.d:/etc/nginx/conf.d -v $path/nginx.conf:/etc/nginx/nginx.conf nginx
cd $original_path
