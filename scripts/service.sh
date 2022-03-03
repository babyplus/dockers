export TZ="Asia/Shanghai"
mount_path="${2:-/tmp}"
date=`date +%Y%m%d`
today_data_file="$mount_path/test_$date.txt"
latest_data_file="$mount_path/test_latest.txt"
history_data_file=""
path="`pwd`"
path=${path%/*}
docker_image=${1:-openapi_server}
project="project"

create_mock_data(){
    data_file=$1
    date=$2
    echo "$data_file is not existed, create mock data..."
    time="100000"
    for n in {1..150};
    do
        echo '- "time": "'${date}_${time}'"' >> $data_file
        echo '  "results":' >> $data_file
        for i in {1..10};
        do
            random0=$((RANDOM%1))
            random1=$((RANDOM%100+1))
            ping_time=`echo $random0.$random1 ms`
            echo '    - { host: 192.168.99.'$i',  rc: 0, ping_time: "'$ping_time'"  }' >> $data_file
        done
        time=$(($time+10))
    done
    grep -o -e "ping_time.*ms" $data_file | sort | tail -20 | awk -v file=$data_file -F "\"" '{print "sed -i \"s/"$2"/None/g\" "file}' | bash
    sed -i 's/rc: 0, ping_time: "None"/rc: 1, ping_time: "None"/g' $data_file
}

[ -f $today_data_file ]&&{
    echo "$today_data_file is existed."
}||{
    create_mock_data $today_data_file $date
    tail -12 $today_data_file > $latest_data_file
}

for i in {1..60}
do
    offset=`date +%Y%m%d -d "-${i}day"`
    history_data_file="$mount_path/test_$offset.txt"
    [ -f $history_data_file ] || {
        create_mock_data $history_data_file $offset
    }
done

mkdir -p $mount_path/yaml
cp -r $path/scripts/yaml/* $mount_path/yaml

# run
cd $path/$project
echo "running..."
docker run -d --rm -v $mount_path:/tmp -v $path/$project/openapi_server:/usr/src/app/openapi_server  -v /var/run/docker.sock:/var/run/docker.sock -p 8080:8080 $docker_image
