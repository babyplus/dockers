. ansible.sh ${1:-ansible:ping_test}
    docker run --net host --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible-playbook repeated_ping_and_publish_via_redis.yml -v
