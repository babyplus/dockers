mount_path="/tmp"
data_file="$mount_path/test_`date +%Y%m%d`.txt"
latest_data_file="$mount_path/test_latest.txt"
path="`pwd`"
path=${path%/*}
docker_image=openapi_server
project="project"

[ -f $data_file ]&&{
    echo "$data_file is existed."
}||{
    echo "$data_file is not existed, create mock data..."
    time="100000"
    date=`date +%Y%m%d`
    for n in {0..150};
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
    tail -12 $data_file > $latest_data_file
}

mkdir -p $mount_path/yaml
cp -r $path/scripts/yaml/* $mount_path/yaml

# run
cd $path/$project
echo "running..."
docker run -v $mount_path:/tmp -v $path/$project/openapi_server:/usr/src/app/openapi_server -p 8080:8080 $docker_image
