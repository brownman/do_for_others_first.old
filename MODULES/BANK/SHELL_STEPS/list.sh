#info: load exported function upon shell restart
shopt -s expand_aliases
set -o nounset
where_am_i(){ 
    local file=${1:-"${BASH_SOURCE[1]}"};
    local rpath=$(readlink -m $file);
    local rcommand=${rpath##*/};
    local str_res=${rpath%/*};
    local dir_self="$( cd $str_res  && pwd )";
    echo "$dir_self"
}

running(){
    #depend_var: dir_self
    local    file=$1
    local  filename=`basename $file | cut -d'.' -f1`

    local cmd=''
    cmd="alias  ${filename}E='vi $file'"
    eval "$cmd"
    cmd="alias  ${filename}S='bash -c $file'"
    eval "$cmd"
    cmd="bash -c $file"
    trace "[cmd] $cmd"

    eval "$cmd"

}
loop(){

    local file_list=$dir_self/list.txt
    while  read line;do
        if [ -n "$line" ];then

            local weight=$( echo "$line" | cut -d'|' -f1 )
            local task_name=$( echo "$line" | cut -d'|' -f2 )
            notify-send "$task_name"

            local file="$dir_self/BANK/$task_name.sh"
            if [  -f  "$file" ];then
                #ls $file
                cmd="running $file"
                #todo: validate_int $weight
                every $weight "$cmd"
            else
                echo "[ERROR] no such file: $file"
            fi
        else
            trace breaking
            break
        fi
    done<$file_list
}


steps(){
    export dir_self=`where_am_i $0`
    export dir_parent=$dir_self
    loop
}
steps
set +o nounset
