data_file="/tmp/test.txt"
path="`pwd`"
path=${path%/*}
docker_image=openapi_server
project="project"

[ -f $data_file ]&&{
    echo "$data_file is existed."
}||{
    echo "$data_file is not existed, create mock data..."
    echo '- "time": "20211022_025518"' >> $data_file
    echo '  "results":' >> $data_file
    echo '    - { host: 127.0.0.1,  rc: 0, ping_time: "0.685 ms"  }' >> $data_file
    echo '    - { host: 192.168.56.1,  rc: 0, ping_time: "1.62 ms"  }' >> $data_file
    echo '    - { host: 1.1.2.3,  rc: 1, ping_time: "None"  }' >> $data_file
    echo '    - { host: 1.1.1.2,  rc: 0, ping_time: "272 ms"  }' >> $data_file
    echo '- "time": "20211022_025539"' >> $data_file
    echo '  "results":' >> $data_file
    echo '    - { host: 127.0.0.1,  rc: 0, ping_time: "0.128 ms"  }' >> $data_file
    echo '    - { host: 192.168.56.1,  rc: 0, ping_time: "0.919 ms"  }' >> $data_file
    echo '    - { host: 1.1.2.3,  rc: 1, ping_time: "None"  }' >> $data_file
    echo '    - { host: 1.1.1.2,  rc: 0, ping_time: "248 ms"  }' >> $data_file
}

# run
cd $path/$project
docker run -v $data_file:$data_file -v $path/$project/openapi_server:/usr/src/app/openapi_server -p 8080:8080 $docker_image
