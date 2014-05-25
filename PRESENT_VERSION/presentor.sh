#info: presentor
#details: auto presentation
#use_script: screencast.sh
#url: http://stackoverflow.com/questions/7858191/difference-between-bash-pid-and

set -o nounset
reset


if [ $# -eq 0 ];then
    msg="please supply a list of tasks - for presenting the new features of this project"
    echo "$msg"
    exit
fi

confirm(){
    local args=( $@ )
    local cmd="${args[@]}"
    echo
print_color_n 34 "[confirm]"
    pv2 "$cmd"
    eval "$cmd"
    echo
    echo

}
step(){
    local args=( $@ )
    local cmd="${args[@]}"

    pv2 "$cmd"
    sleep 1 
#    eval  "$cmd" 1>/tmp/out 2>/tmp/err
    eval "$cmd"
#    test_single "$cmd"
#    cat /tmp/out
}


steps(){
    while read line;do
        if [ -n "$line" ];then
#            echo "[line] $line"
            eval "$line" 
        else
            echo Empty line
            echo breaking
            break
        fi



    done< $file_list
}

file_list=$1
if [ -f $file_list ];then
    ( xterm -e   "$dir_root/BUILTINS/screencast.sh"  )&
    #kill -s SIGINT $process_id
    steps
else
    echo "not a file: $file"
fi

