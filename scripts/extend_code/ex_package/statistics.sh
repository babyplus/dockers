# [root@archlinux ex_package]# bash statistics.sh "20211214_100000|20211215_20000" /tmp/test_20211214.txt /tmp/test_20211215.txt
# "192.168.99.1": 194
# "192.168.99.2": 211
# "192.168.99.3": 216
# "192.168.99.4": 201
# "192.168.99.5": 197
# "192.168.99.6": 200
# "192.168.99.7": 212
# "192.168.99.8": 226
# "192.168.99.10": 213
# "192.168.99.9": 176

[ ! $# -lt 2 ] || {
echo 
echo '    Usage:' $0 PERIOD FILE1 [FILE2...]
echo 
echo '      Example1: sh' $0 '"20211214_100000|20211214_20000"' /tmp/test_20211214.txt
echo '      Example2: sh' $0 '"20211214_100000|20211215_20000"' /tmp/test_20211214.txt /tmp/test_20211215.txt
echo 
echo '    Notice: The script ignores the results of the last round in the given period'
echo 
exit 1
}

period=$1
shift
file=/tmp/$(($RANDOM*$RANDOM)).txt
cat $@ > $file
grep -E $period -n $file |awk -v FILE=$file -F ":" '{ RESULT[NR]=$1 } END {print "sed -n "RESULT[1]+1","RESULT[2]-1"p "FILE}' | sh | grep "rc: 1" | awk '{a[$4]++}END{for (n in a) {print "\""n " " a[n]}}' | sed 's/,/":/g'
rm $file
