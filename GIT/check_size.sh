func(){
author=$1
repo=$2
cmd="curl -s -k      https://api.github.com/repos/$author/$repo"
echo "[cmd] $cmd"
eval "$cmd"
echo "res: $?"
}

echo args: 1.repo 2.author
repo=${1:-GMAIL_GROUP}
author=${2:-brownman}
func $author $repo

