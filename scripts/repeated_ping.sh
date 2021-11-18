. ansible.sh ${1:-ansible:ping_test}
while true
do
    docker run --net host --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible-playbook repeated_ping.yml
done
