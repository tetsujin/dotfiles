### path
typeset -U path
path=(
    $HOME/local/bin(N-/)
    /opt/local/bin(N-/)
    /opt/local/sbin(N-/)
    /opt/local/*/bin(N-/)
    /opt/local/*/sbin(N-/)
    /bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /usr/local/git/bin(N-/)
    /sbin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /usr/local/X11/bin(N-/)
    /usr/X11/bin(N-/)
)

### language
export LANG=en_US.UTF-8
case "$LANG" in
  *.UTF-8)
        LC_CTYPE=ja_JP.UTF-8
        LESSCHARSET=utf-8
        JLESSCHARSET=utf-8
        LV=-Ou8
        ;;
  ja_JP.eucJP)
        LC_CTYPE=ja_JP.eucJP
        LESSCHARSET=latin1
        JLESSCHARSET=japanese-euc
        LV=-Oej
        ;;
  *)
        LC_CTYPE=$LANG
        LESSCHARSET=latin1
        JLESSCHARSET=latin1
        LV=-Al1
        ;;
esac
export LC_CTYPE
export JLESSCHARSET
export LESSCHARSET
export LV

### file maks
umask 022

### core control
#limit coredumpsize 0

### block size
export BLOCKSIZE=k

### editor
if [ -x "`which vim`" ]; then
    EDITOR=vim
else
    EDITOR=vi
fi
export EDITOR

### pager
if [ -x "`which lv`" ]; then
    PAGER=lv
elif [ -x "`which jless`" ]; then
    PAGER=jless
elif [ -x "`which less`" ]; then
    PAGER=less
else
    PAGER=more
fi
export PAGER
#export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'
export LESS='--shift 1'

### rsync
export RSYNC_RSH=ssh

### cvs
export CVS_RSH=ssh
export CVS_EDITOR=$EDITOR

### svn
export SVN_RSH=ssh
#export SVN_EDITOR=$EDITOR
export SVN_EDITOR=`which vi`

### git
export GIT_EDITOR=`which vi`

### perl
export PERL_BADLANG=0

### local configuration
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
