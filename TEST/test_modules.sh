#depand_package: tee
#set -e
#http://stackoverflow.com/questions/8363519/how-do-i-terminate-all-the-subshell-processes
#pstree: sudo apt-get install psmisc
reset
set -o nounset


set_env(){
    #    time1=`date | tr -s ' ' | cut -d' ' -f4| sed 's/:/_/g'`
    dir_self=`where_am_i $0`
    file_menu=$dir_self/TXT/list.txt
    read day month year <<< $(date +'%d %m %y')
    time1="${day}_${month}_${year}"
    ########################################### some info
    echo "[time] $time1"
}
prepare_menu(){
    [ -f $file_menu ] && { rm $file_menu; }
    ls -d -- $dir_modules/*/ > $file_menu
    cat -n  $file_menu
}
ensure_symlink(){
    dir=$1
    ln -sf /tmp/err $dir/err
}
test_dir(){
    local cmd=''
    local dir=$1
    local file="$dir/.test.sh"
    local dirname=`basename $dir`
    local dir_today=$dir_self/TXT/${time1}
[ ! -d $dir_today ] && {    mkdir -p $dir_today; }
    local file_res_out="$dir_today/${dirname}.txt"
    local file_res_err="$dir_today/${dirname}.err.txt"
print_color 33 "[file_res_out]  $file_res_out"
    if [ ! -f "$file" ] || [ ! -s "$file" ] ;then
        print_color 31  "[file] not exist: "
        echo "$file"
        echo
        ls "$dir"
        cp $dir_self/proto_for_testing.sh $file
        sleep 5
        update_clipboard "gvim $file" 
        print_color 32  "[file] exist ! - but you should update it"
        exit 1
    else
        print_color 32  "[file] testing"
        [ -f /tmp/err ] && { /bin/rm /tmp/err; }
        #exec 2>/tmp/err
        cmd="bash -e $file"
        update_clipboard "$cmd"

        ( echo "$cmd";  eval "$cmd"  2>/tmp/err 1>/tmp/out )
    fi
    local        res=$?
    if [ $res -eq 0 ];then
cp /tmp/out $file_res_out
        print_color 32 "V"
    else
        [ -f /tmp/err ] && { cat /tmp/err; } || { echo /tmp/err not exist ;}
        cp /tmp/err $file_res_err
        print_color 31 "X"
        exit 1
    fi
}

steps(){
    set_env
    prepare_menu
    local dir=''
    local res=$num_choose
    if [ -f $file_menu ];then
        if [ $res -eq 0 ];then
            menu $file_menu
            res=$?
        fi
        str_res=$( pick_line $file_menu $res )
        dir=$str_res
        if [ -d "$dir" ];then
            print_color 32 $dir
            echo "[dir] $dir"
            update_clipboard "cd $dir"
            ensure_symlink $dir    
            test_dir "$dir"
        else
            print_color 31 "[Error] not a dir: $dir"
        fi
    else
        print_color 31 "[Error] file not found: $file_menu"
    fi
}
num_choose=${1:-0}
steps
