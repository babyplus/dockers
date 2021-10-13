# define path

path=`pwd`
path=${path%/*}

# check docker image

image=${1:-ansible:itest}
image_name=${image%%:*}
image_tag=${image##*:}
docker images | grep -E "^$image_name " | grep " $image_tag "
[ $? -eq 0 ] && {
echo "Image already exists"
} || {
echo "Image does no exists"
echo docker build -t $image ..
docker build -t $image ..
}

# check ssh keys

keys_path=$path/etc/ansible/keys
for key in `ls $keys_path`
do
chmod 600 $keys_path/$key
done
