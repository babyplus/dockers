
function get_online_machine()
{
    source_dir=$1
    destination_dir=$2
    work_dir=$3
    online_ip_list=`iping $source_dir $destination_dir $work_dir | grep online | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"`
    echo "\"$(date "+%Y%m%d_%H%M%S")\"":
    for online_ip in ${online_ip_list[@]}
    do
        echo "    - \"$online_ip\""
    done
}

main()
{
    . ansible.sh ${1:-ansible:online_check} &>/dev/null
    . tools.sh
    get_online_machine "$path/etc/ansible" "/etc/ansible" "/etc/ansible/yml"
}

main
