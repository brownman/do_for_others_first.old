
round_up(){
    #depend_cmd: notify-send


#echo "`whoami`:$@" >> $file_log
count=`cat  $file_count`
re='^[0-9]+$'
if ! [[ $count =~ $re ]] ; then
    echo "error: Not a number" >&2; rm $file_count; exit 1
fi
let 'count += 1'
echo "$count" > $file_count
notify-send "round" "X $count"
}

set_env(){
    file_count=$dir_workspace/count
}

init(){
[ ! -f $file_count ] && { echo 1 > $file_count; }
}

steps(){
set_env
init
round_up
}
steps
