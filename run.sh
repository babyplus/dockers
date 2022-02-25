path=`pwd`
docker run --net host -v $path/conf.d:/etc/nginx/conf.d -v $path/nginx.conf:/etc/nginx/nginx.conf nginx
