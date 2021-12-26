
preprocess(){
    begin=${1%%|*}
    begin_date=${begin%%_*}
    begin_time=${begin##*_}
    end=${1##*|}
    end_date=${end%%_*}
    end_time=${end##*_}
}

get_files(){
    [ 8 -ne `echo $1 | wc -c` ] || exit 2 
    [ 8 -ne `echo $2 | wc -c` ] || exit 2 
    seq=`seq $1 $2`
    echo `for s in ${seq[@]} ; do echo "/tmp/test_"$s".txt"; done`
}

get_real_begin(){
    real_times=( `grep -E "^- \"time\"" $1 | awk -F "_" '{gsub(/"/, "", $2);print $2}' | sort` )
    ret=${real_times[0]}
    for n in ${real_times[@]}
    do
    [ $3 -le $n ] && {
        ret=$n
        break
    }
    done
    echo $2_$ret
}

get_real_end(){
    real_times=( `grep -E "^- \"time\"" $1 | awk -F "_" '{gsub(/"/, "", $2);print $2}' | sort` )
    ret=${real_times[-1]}
    for n in ${real_times[@]}
    do
    [ $3 -lt $n ] && {
        ret=$n
        break
    }
    done
    echo $2_$ret
}

get_period(){
    real_begin=`get_real_begin $1 $2 $3`
    real_end=`get_real_end $4 $5 $6`
    echo "$real_begin|$real_end"
}

process(){
    period=$1
    shift
    file=/tmp/$(($RANDOM*$RANDOM)).txt
    cat $@ > $file
    grep -E $period -n $file |awk -v FILE=$file -F ":" '{ RESULT[NR]=$1 } END {print "sed -n "RESULT[1]+1","RESULT[2]-1"p "FILE}' | bash | grep "ping_time" | awk '{a[$4]++;b[$4]=(""==b[$4]?0:b[$4]);if("1,"==$6){b[$4]++}}END{for (n in a) {print "\""n "\": {\"total\": \""a[n]"\", \"failed\": \""b[n]"\"}"}}'  | sed 's/,":/":/g'
    rm $file
}

main(){
    [ ! $# -lt 1 ] || {
    echo 
    echo '    Usage:' $0 PERIOD 
    echo 
    echo '      Example: bash' $0 '"20211214_100000|20211214_20000"' 
    echo 
    echo '    Notice: The script ignores the results of the latest round if the given period contains the latest time'
    echo 
    exit 1
    }
    begin=
    begin_date=
    begin_time=
    end=
    end_date=
    end_time=
    files=
    primary_file=
    latest_file=
    period=
    preprocess $@
    files=`get_files $begin_date $end_date `
    primary_file=`echo $files | awk '{print $1}' `
    latest_file=`echo $files | awk '{print $NF}' `
    period=`get_period $primary_file $begin_date $begin_time $latest_file $end_date $end_time `
    process $period $files
    # echo $begin
    # echo $begin_date
    # echo $begin_time
    # echo $end
    # echo $end_date
    # echo $end_time
    # echo $files
    # echo $primary_file
    # echo $latest_file
    # echo $period
}

main $@
