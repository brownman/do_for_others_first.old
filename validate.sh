

toilet1(){
toilet --gay "$@"
}
source setup.cfg 2>/tmp/err && toilet1 OK  || gxmessage -file /tmp/err -entrytext "gvim setup.cfg" -title trap_err 
