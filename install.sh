#author: ofer shaham
#info: installer
#date: 20-5-2014
#time: 7:47
#version: 1
clear

check(){
echo "[bashrc] check last lines of .bashrc:"
cat -n ~/.bashrc | tail -10
}


line="source ~/link"
echo Appending 1 line  to .bashrc:
echo "[line] $line"

cat > ~/link << FILE
export dir_root0=`pwd`
alias cdroot="cd \$dir_root0"
source \$dir_root0/setup.cfg
source \$dir_root0/env.cfg
FILE

cat ~/.bashrc | grep "$line" 

str=$( cat ~/.bashrc | grep "$line" )
res=$?
[ $res -eq 1  ] && { echo "$line" >> ~/.bashrc; } || { echo Link already Exist :\) ;}


