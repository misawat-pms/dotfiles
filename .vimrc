" dein settings -----------------------------------------------------------
" plugin install directory
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" download dein.vim if it not installed
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" load TOML file listed plugins
let g:rc_dir = expand('~/.vim/rc')
let s:toml = g:rc_dir . '/dein.toml'

"" start dein settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml])
    call dein#load_toml(s:toml)
    call dein#end()
    call dein#save_state()
endif

"" auto install plugins not installed
" if dein#check_install(['vimproc'])
"     call dein#install(['vimproc'])
" endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

filetype plugin indent on

" incsearch settigns
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ?
        \ '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
        endtry
        return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" use flake8 for python lint checker
let g:syntastic_python_checkers = ['flake8']

" syntastic highlight

" 256 color on screen
if $TERM == 'screen'
    set t_Co=256
endif

" set colorscheme
set background=dark
colorscheme hybrid
syntax enable

" filetype settings
au BufRead,BufNewFile {*.md,*.txt} set filetype=markdown
au BufRead,BufNewFile {*.coffee} set filetype=coffee
" autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" open with last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""


"---org---
" General parameter
" encode
set encoding=utf-8
scriptencoding utf-8

" initialize
augroup vimrc
  autocmd!
augroup END

" basic
set number
set cursorline
hi clear CursorLine
set virtualedit+=block
set laststatus=2
set statusline=%f%m%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set cmdheight=2
set showmatch
set matchpairs+=<:>
set helpheight=999
set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$

" window
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=5
set sidescrolloff=5
set sidescroll=1
set wrap
set linebreak
set colorcolumn=80
set laststatus=5
set showcmd
set wildmode=longest:full,full
set synmaxcol=200

" file save 
set confirm
set hidden
set autoread

" search & replace
set hlsearch
set incsearch
set wrapscan
set gdefault
set ignorecase
set smartcase

" Tab & Indent
"set smartindent
"set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set smarttab
"set cindent
set textwidth=0


" Clipboard
set clipboard=unnamed,unnamedplus,autoselect

" mouse
set mouse=

" for windows path
set shellslash
