### environment

#export IGNOREEOF=                     # setopt ignore_eofで設定
#export WORDCHARS="${WORDCHARS:s#/#}"  # select-word-styleで設定

### terminal
#export term=xterm-256color
#export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

### ls colors
# BSD ls
export LSCOLORS=gxfxcxdxbxegedabagacdx
# GNU ls
if [ -f "$HOME/.dir_colors" ]; then
    which dircolors &> /dev/null  && eval `dircolors -b "$HOME/.dir_colors"`
    which gdircolors &> /dev/null && eval `gdircolors -b "$HOME/.dir_colors"`
fi

### for emacs M-x shell
[[ $EMACS = t ]] && unsetopt zle

### history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

### aliase
case "$OSTYPE" in
    linux*)
        alias ls='ls -aF --color=auto --show-control-chars'
        ;;
    darwin*|freebsd*)
        alias ls='ls -aFG' 
        which gnuls &> /dev/null && alias ls='gnuls -aF --color=auto --show-control-chars'
        which gls &> /dev/null   && alias ls='gls -aF --color=auto --show-control-chars'
        ;;
esac
alias wget='noglob wget --no-check-certificate'
alias ll='ls -l'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vimb='vim -b "+set noeol"'
alias grep='grep --color=auto'
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias grepc='grep --color=always'
alias less='less -R'
alias coffee='$HOME/local/apps/node_modules/coffee-script/bin/coffee'
#[ -x "`which tscreen`" ] && alias screen='tscreen'

### global aliase
alias -g V='| vim -R -'
alias -g L="| less"
alias -g M="| more"
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g W='| wc'
alias -g A='| awk'
alias -g S='| sed'
alias -g P='| percol'
alias -g PM='| percol --match-method migemo'

### options
setopt append_history
setopt extended_history
#setopt hist_allow_clobber
#setopt hist_beep
#setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
#setopt hist_verify
setopt inc_append_history
setopt share_history
setopt auto_cd
setopt auto_pushd
setopt cdable_vars
#setopt pushd_ignore_dups
#setopt pushd_minus
setopt pushd_silent
#setopt pushd_to_home
setopt always_last_prompt
setopt complete_in_word
setopt auto_list
#setopt bash_auto_list
setopt auto_menu
#setopt menu_complete
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_aliases
setopt glob_complete
setopt hash_list_all
setopt list_ambiguous
setopt auto_resume
setopt no_beep
setopt brace_ccl
#setopt bsd_echo
#setopt chase_links
setopt correct
#setopt correct_all
setopt equals
setopt extended_glob
setopt no_flow_control
setopt no_hup
setopt ignore_eof
setopt no_checkjobs
setopt multios
#setopt sun_keyboard_hack
setopt interactive_comments
setopt list_types
setopt long_list_jobs
setopt magic_equal_subst
#setopt mail_warning
setopt mark_dirs
#setopt path_dirs
setopt print_eightbit
#setopt print_exit_value
#setopt rm_star_silent
setopt rm_star_wait
setopt short_loops
#setopt single_line_zle
#setopt xtrace
setopt prompt_subst
unsetopt promptcr
setopt transient_rprompt
setopt sh_word_split
setopt numeric_glob_sort
setopt notify
setopt clobber
#setopt no_clobber
#setopt no_unset

### autoload & bindkey
#stty erase '^H'
stty erase "^?"
stty stop undef

# emacsベース
bindkey -e

# コマンドオプションの補完
autoload -U compinit
compinit -u

# 単語区切り指定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /:p+|"
zstyle ':zle:*' word-style unspecified

# 履歴補完
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

# autoload -U up-line-or-beginning-search down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey '^p' up-line-or-beginning-search
# bindkey '^n' down-line-or-beginning-search

autoload -Uz is-at-least
if is-at-least 4.3.10; then
    bindkey '^R' history-incremental-pattern-search-backward
    bindkey '^S' history-incremental-pattern-search-forward
fi

# zed
autoload zed
zed -b
bindkey -M zed '^p' up-line-or-history
bindkey -M zed '^n' down-line-or-history

# メニュー補完
zmodload -i zsh/complist
bindkey -M menuselect '^p' up-line-or-history
bindkey -M menuselect '^n' down-line-or-history
bindkey -M menuselect '^b' backward-char
bindkey -M menuselect '^f' forward-char
bindkey -M menuselect '^o' accept-and-infer-next-history

# 履歴からの予測入力
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^xp'  predict-on    # C-xpでon
bindkey '^x^p' predict-off   # C-xC-pでoff

# URLを自動的にエスケープ
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# 色の定義読み込み
autoload -U colors; colors

# help表示
autoload run-help

# zargs -- **/*(.) -- ls -l みたいなの
autoload zargs

# zmv
# http://www.dna.bio.keio.ac.jp/~yuji/zsh/zshrc.txt
# autoload -U zmv
#
# # % zmv '(*).jpeg' '$1.jpg'
# # % zmv '(**/)foo(*).jpeg' '$1bar$2.jpg'
# # % zmv -n '(**/)foo(*).jpeg' '$1bar$2.jpg' # 実行せずパターン表示のみ
# # % zmv '(*)' '${(L)1}; # 大文字→小文字
# # % zmv -W '*.c.org' 'org/*.c' #「(*)」「$1」を「*」で済ませられる
# alias mmv='noglob zmv -W'  # 引数のクォートも面倒なので
# # % mmv *.c.org org/*.c
# #zmv -C # 移動ではなくコピー(zcp として使う方法もあるみたいだけど)
# #zmv -L # 移動ではなくリンク(zln として使う方法もあるみたいだけど)

# コマンドラインを$EDITORで編集
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# dabbrev
HARDCOPYFILE=$HOME/.screen-hardcopy
touch $HARDCOPYFILE
dabbrev-complete () {
    local reply lines=80
    screen -X eval "hardcopy -h $HARDCOPYFILE"
    reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
    compadd - "${reply[@]%[*/=@|]}"
}
zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

### zstyle
# compctl形式を使用しない
zstyle ':completion:*' use-compctl false

# 補完キャッシュ
zstyle ':completion:*' use-cache true

# 補完メニューをカーソル等で選択できるようにする
zstyle ':completion:*' menu select=2

# 補完の大文字・小文字を区別しない。が、大文字を入力したときは区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# sudo時も$PATH内のコマンドを補完する
zstyle ':completion:*:sudo:*' command-path ${(s.:.)PATH}

# 補完時も色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:default' list-colors ''

# kill補完も色づけ
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# メニュー補完のグループ分け表示
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format $'%B%{\e[33m%}Completing %d%b'

# dateのフォーマット
zstyle ':completion:*:date:*' menu yes select=2
zstyle ':completion:*:date:*' fake \
    '+%Y%m%d%H%M%S:YYYYMMDDhhmmss' \
    '+%Y-%m-%d %H\:%M\:%S:YYYY-MM-DD hh:mm:ss' \
    '+%Y/%m/%d %H\:%M\:%S:YYYY/MM/DD hh:mm:ss' \
    '+%Y%m%d:YYYYMMDD' \
    '+%Y-%m-%d:YYYY-MM-DD' \
    '+%Y/%m/%d:YYYY/MM/DD'

### vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)%b'
zstyle ':vcs_info:*' actionformats '(%s)%b|%a'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

### prompt
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
    # ssh接続時
    PROMPT=$'%{${fg[green]}%}%B[%m:%~%1(v|%F{yellow}:%1v%f|)%{${fg[green]}%}]\n%#%b%{${reset_color}%} '
else
    # local起動時
    PROMPT=$'%{${fg[cyan]}%}[%m:%~%1(v|%F{yellow}:%1v%f|)%{${fg[cyan]}%}]\n%#%{${reset_color}%} '
fi

### title
#echo "\033P\033]0;${USER}@${HOST}\007\033\\"

### screen用設定
if [ -n "$WINDOW" -o -n "$TMUX" ]; then
    preexec() {
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            ssh) # ssh先のホスト名を表示する
                local -a host;
                host=${cmd[@]%%.*}
                host=${host##* }
                echo -n "\033k->$host:t\033\\"
                ;;
            *)
                echo -n "\033k$cmd[1]:t\033\\"
                ;;
        esac
    }
fi

### tmux用設定
if [[ "$TMUX" != "" ]] then
    alias pbcopy="ssh 127.0.0.1 pbcopy"
    alias pbpaste="ssh 127.0.0.1 pbpaste"
fi

# function ssh_screen() {
#     eval server=\${$#}
#     screen -t $server ssh "$@"
# }

## http://kitaj.no-ip.com/tdiary/20060927.html
# function cdup() {
#   echo
#   cd ..
#   zle reset-prompt
# }
#
# bindkey '\^' cdup
# zle -N cdup

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac=gtac || tac=tac
        BUFFER=$($tac $HISTFILE | sed 's/^: [0-9]*:[0-9]*;//' | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

### mysql
# mysql client user
typeset -A mysql_prompt_style_client_user
mysql_prompt_style_client_user=(
    # 'root'     $fg_bold[red]
    # '*'        $fg_bold[green]
)
# mysql client host
typeset -A mysql_prompt_style_client_host
mysql_prompt_style_client_host=(
    '*.local.*'     "$fg_bold[green]"
    '*.dev.*'       "$fg_bold[yellow]"
    '*'             "$fg_bold[red]"
)
# mysql server user
typeset -A mysql_prompt_style_server_user
mysql_prompt_style_server_user=(
    'root'          "$bg_bold[red]$fg_bold[yellow]"
    '*'             "$fg_bold[blue]"
)
# mysql server host
typeset -A mysql_prompt_style_server_host
mysql_prompt_style_server_host=(
    '*master*'      "$bg_bold[red]$fg_bold[yellow]"  # Master Server
    '*slave*'       "$bg[yellow]$fg[black]" # Slvae Server
    '*'             "$fg_bold[blue]"
)
# mysql prompt style (Should use single quoted string.)
mysql_prompt='${style_client_host}${USER}@${HOST}${fg_bold[white]} -> '
mysql_prompt=$mysql_prompt'${style_server_user}\u${reset_color}${fg_bold[white]}@${style_server_host}\h${reset_color}${fg_bold[white]}:${fg[magenta]}\d ${fg_bold[white]}\v\n'
mysql_prompt=$mysql_prompt'${fg_bold[white]}${bg_level}mysql${reset_color}> '

### php symfony
# http://blog.bz2.jp/archives/2008/05/symfony.html
symfony(){(
  if [ -f symfony ]; then
    ./symfony $*
  elif [ $PWD = / ]; then
    command symfony $*
  else
    cd ..; symfony $*
  fi
)}

## local configuration
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
