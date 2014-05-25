dir_self=`dirname $0`
files=`ls $dir_self/*`
echo $files
echo "bash -e $dir_self/  update me   .sh"
file_self=`where_am_i $0`
cmd="vi $file_self/BANK/menuer.sh"
update_clipboard "$cmd"
