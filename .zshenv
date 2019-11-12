### path
typeset -U path
path=(
    $HOME/bin(N-/)
    $HOME/local/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $HOME/.phpenv/bin(N-/)
    $HOME/.plenv/bin(N-/)
    $HOME/.composer/vendor/bin(N-/)
    $HOME/.packer(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    /usr/local/phpenv/bin(N-/)
    #/usr/local/share/python(N-/)
    /usr/local/opt/texinfo/bin(N-/)
    /opt/local/bin(N-/)
    /opt/local/sbin(N-/)
    /opt/local/*/bin(N-/)
    /opt/local/*/sbin(N-/)
    /usr/local/bin(N-/)
    /bin(N-/)
    /usr/local/*/bin(N-/)
    /usr/bin(N-/)
    /usr/local/git/bin(N-/)
    /sbin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /usr/local/X11/bin(N-/)
    /usr/X11/bin(N-/)
)
export GOROOT=/usr/local/opt/go/libexec
typeset -T GOPATH gopath
typeset -U gopath
gopath=(
  $HOME(N-/)
)
export GOPATH

typeset -U manpath
manpath=(
    /opt/*/man(N-/)
    /usr/*/man(N-/)
    /usr/local/*/man(N-/)
)

typeset -U fpath
fpath=(
    $HOME/.zsh.d/*(/N)
    $HOME/.oh-my-zsh/custom/plugins/*(/N)
    $fpath
)
autoload -U $(echo ~/.zsh.d/functions/*(:t))

typeset -U fignore
fignore=(
    CVS
    .svn
    .git
)
#typeset -T PYTHONPATH pythonpath
#typeset -U pythonpath
#pythonpath=(
#    /usr/local/lib/python2.7/site-packages(N-/)
#)
#export PYTHONPATH

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
if which vim &> /dev/null; then
    EDITOR=vim
else
    EDITOR=vi
fi
export EDITOR

### pager
if which lv &> /dev/null; then
    PAGER='lv -c'
elif which jless &> /dev/null; then
    PAGER=jless
elif which less &> /dev/null; then
    PAGER='less -R'
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
#export PERL_BADLANG=0
#if which plenv &> /dev/null; then
#    eval "$(plenv init -)"
#    PERL_VERSION_STRING="perl:"$(plenv version-name)
#fi

### ruby
if which rbenv &> /dev/null; then
    eval "$(rbenv init -)"
    RUBY_VERSION_STRING="ruby:"$(rbenv version-name)
fi

### php
if which phpenv &> /dev/null; then
    eval "$(phpenv init -)"
    PHP_VERSION_STRING="php:"$(phpenv version-name)
fi

### ls
export QUOTING_STYLE=literal

### local configuration
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
