. ansible.sh ${1:-ansible:ping_test}
docker run --net host -it --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible-playbook repeated_ping.yml
