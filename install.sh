#author: ofer shaham
#info: installer
#date: 20-5-2014
#time: 7:47
#version: 1
pushd `dirname $0`>/dev/null
clear
#source struct.cfg
#[  -d $dir_workspace ] && { echo "[dir_workspace] already exist" ; } || { mkdir -p $dir_workspace ; }
create_anchor(){
cat > ~/link << FILE
export dir_root=`pwd`
alias cdroot="cd \$dir_root"


cmd1="source \$dir_root/.travis.sh"
cmd2="source \$dir_root/source.cfg"
cmd3="\$dir_root/run.sh"

echo "\$cmd2"
eval "\$cmd2"
FILE
}

#echo "$( \"$cmd1\" && \"$cmd2\" && \"$cmd3\" )"
create_bashrc_link(){



line="source ~/link"

msg=" Appending 1 line  to .bashrc: $line"
#echo "[line] $line"
str=$( cat ~/.bashrc | grep "$line" )
res=$?
[ $res -eq 1  ] && { echo "$msg" ; echo "$line" >> ~/.bashrc; } || { echo "[bashrc Link] already Exist " ;}
}
steps(){
create_anchor
create_bashrc_link
}
steps
popd >/dev/null
