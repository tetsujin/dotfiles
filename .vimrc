" 基本
set nocompatible
set nonumber
set backspace=indent,eol,start
set notitle
set nowrap
set showmatch
"set wildmode=list,full
set wildmode=longest,list

" 色
syntax enable
colorscheme elflord

" エンコーディング
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set ambiwidth=double

" 検索
set hlsearch
set incsearch
set ignorecase
set wrapscan
set smartcase

" タブ,インデント
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" vimdiffを見やすく
"hi DiffAdd cterm=bold ctermbg=green

" ステータス行
set cmdheight=1
set laststatus=2
set ruler
set showcmd
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=lightblue
" Insertモード時にステータス行の色を変える
if v:version > 700
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=lightblue
        autocmd InsertLeave * highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=lightgray
    augroup END
endif

" 全角スペース Tab 末尾のスペースを可視化
" http://blog.miraclelinux.com/ctd/2006/07/vim__32e1.html
scriptencoding utf-8
function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
    syntax match InvisibleTab "\t" display containedin=ALL
    highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
endf
augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
augroup END

filetype plugin indent on

" http://www.kawaz.jp/pukiwiki/?vim#cb691f26
if &encoding !=# 'utf-8'
  set encoding=utf-8
  set fileencoding=utf-8
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
