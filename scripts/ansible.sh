image=${1:-ansible:itest}
image_name=${image%%:*}
image_tag=${image##*:}
path=`pwd`
path=${path%/*}
docker images | grep -E "^$image_name " | grep " $image_tag "
[ $? -eq 0 ] && {
echo "Image already exists"
} || {
echo "Image does no exists"
echo docker build -t $image ..
docker build -t $image ..
}
