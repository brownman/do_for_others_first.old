#http://stackoverflow.com/questions/2144406/git-shallow-submodules
#http://bugsquash.blogspot.co.il/2010/11/shallow-submodules-in-git.html
#[--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
#http://chrisjean.com/2009/04/20/git-submodules-adding-using-removing-and-updating/

set -o nounset
dir_self=`dirname $0` 

clear
cat $dir_self/list
echo press a key to continue
read
echo ----- 

if [ $# -eq 0  ]
then
      echo "Usage: gitrepo-info <repo> , <owner> "
#        exit 65
    fi
repo=${1:-GMAIL_GROUP}
owner=${2:-brownman}






cmd="$dir_self/check_size.sh $repo $owner"
echo "[cmd] $cmd"
eval "$cmd" >/tmp/scrap 
#echo "$str" | grep size --color=auto
 grep "Not Found" /tmp/scrap 1>/dev/null && { echo "[ Error] exiting" ; exit ; }

grep 'size\|default' /tmp/scrap


echo press y to  continue
read answer
if [ "$answer" = y ]; then

        #dont allow editing of a sub-module
        git_url="git@github.com:brownman/$repo.git"

#    git_url="https://github.com/$owner/$repo.git"

cmd="git submodule add --depth 1 $git_url READ_ONLY/$repo"
#    cmd="git submodule add $git_url READ_ONLY/$repo"
  
 
    echo "[cmd] $cmd"
    echo press enter to continue
    read
    eval "$cmd"
#init-no  clon-yes #git submodule update --init
#git add $repo
    git commit -am "[ submodule as repo ] Added"
else
    echo skipping
fi
#popd >/dev/null
