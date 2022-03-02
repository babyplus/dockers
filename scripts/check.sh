. ansible.sh ${1:-ansible:ping_test}
docker run --net host --rm -w /etc/ansible/yml -v $path/etc/ansible:/etc/ansible $image ansible master -m ping | grep -iE 'UNREACHABLE|FAILED'
[ ! 0 -eq $? ] || {
    exit 1
}
ps -ef | grep -v grep | grep repeated_ping.sh
[ ! 0 -eq $? ] || {
    exit 2
}
