. ansible.sh ${1:-ansible:iping}
docker run --net host -it --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible-playbook ping.yml -v
