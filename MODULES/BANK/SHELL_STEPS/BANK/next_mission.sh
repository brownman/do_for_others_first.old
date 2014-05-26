
next_mission(){
str_next=$(cat $dir_workspace/ideas.yaml  | head  -1)
cowsay "$str_next"
}

next_mission
