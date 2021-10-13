
function iping()
{
    source_dir=$1
    destination_dir=$2
    work_dir=$3
    docker run --net host -it --rm -w $work_dir -v $source_dir:$destination_dir $image ansible-playbook ping.yml -v
}
