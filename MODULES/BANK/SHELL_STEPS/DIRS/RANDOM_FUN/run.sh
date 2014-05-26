#xcowfortune
set -o nounset
set -e

shopt -s expand_aliases
export MODE_SOUND=true
file_quote=/tmp/quote
str=${1:-`fortune`}
echo $str >> $file_quote
xcowsay "$str" --time=20
echo `pwd`
alias remind="cat /tmp/quote"
dir_self=`dirname $0`
#ls -l "$dir_self/translate.sh"

file_translate=$file_translate_sh
file_languages=$file_languages_txt

while read line;do
cmd="$file_translate $line \"$str\""
echo "[cmd] $cmd"
eval "$cmd"
done < $file_languages
#file_mission="$dir_self/mission.sh"
#eval "$file_mission"

