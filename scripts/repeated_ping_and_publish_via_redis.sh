. ansible.sh ${1:-ansible:ping_test}
docker run --net host --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible master -m shell -a 'sudo docker run -it --network host --rm redis redis-cli ping 2>/dev/null' | grep PONG
[ 0 -eq $? ] || {
    echo Redis is not working properly.
    exit 1
}
while true
do
    docker run --net host --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible-playbook repeated_ping_and_publish_via_redis.yml -v
done
