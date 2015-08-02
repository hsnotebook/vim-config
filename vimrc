" Filename: .vimrc
" Made by hs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'

"""""""""""""""""""
"" To get help, type :help <keyword>
""""""""""""

"""""remove gui toolbar, menubar and scroll bar
set guioptions-=T
set guioptions-=m
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"""""Turn off cursor blinking in normal mode
set gcr=n:blinkon0


"""""""""""""""""""""""
" Make vim behave in a more useful way. 
set nocompatible

""""""""""""""""""
" Set global leader
let mapleader="\\"
" Set local leader
let maplocalleader="\\"

"""""encoding"""""
if has("win32")
	set encoding=gbk
else
	set encoding=utf-8
endif
set fenc=utf-8
set fileencodings=utf-8,ucs-bom,cp936

""""""""""""""""""
" plugin configuration
"source ./plugin_config.vim

"""""""""""""""""""""""""
" All colorscheme are in /usr/share/vim/vimxx/colors
colorscheme desert

"""""""""""""""""""""""
" Syntax highlighting
syntax on

"""""""""""""""""""""""
" Mark color characters after a certain column
" \%> match after column with the number right after this
" 80 the column number
" v tell that it should work on virtual columns only
" .\+ match one or more of any character
" match ErrorMsg /\%>80v.\+/

""""""""""""""""""""""""
" There are four main ways to use tabs in VIM.
" Use :h tabstop to see more information.
set tabstop=4
set shiftwidth=4
set noexpandtab
"set list
set listchars=tab:\|\ ,nbsp:%,trail:-
"match StatusLineNC /^\t/

""""""""""""""""""""""
" Lines longer than the textwith whill wrap and
" displying continues on the next line.
set wrap
set formatoptions+=w
set tw=75

""""""""""""""""""""
" Show the number
set number
set relativenumber

""""""""""""""""""
" About how to search
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrapscan
nmap <leader><cr> :nohlsearch<cr>

""search hilight text in visual mode
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>


"""""""""""""""""
" Show command in the last line of the screen
set showcmd

""""""""""""""""
" Automatically save before commands like :next and :make
set autowrite
" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread

""""""""""""""""""""
" Enable file type detection
" More help :h filetype
filetype on
" Enable loading the plugin files for specific file types.
filetype plugin on
" Enable loading the indent file for specific file types.
filetype indent on


""""""""""""""""""""
" Save and quit
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>
nmap <leader>wq :wq<cr>

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%F%m%r%w\ [POS+%04l,%04v]\ [%p%%]\ [LEN=%L]

""""""""""""""
" Key mapping for browsering through opened buffers.
"nnoremap <C-k> :bp<CR>
"nnoremap <C-j> :bn<CR>
" Key mapping for browsering through tabs
"nnoremap <C-h> :tabp<CR>
"nnoremap <C-l> :tabn<CR>


""""""""""""""""""""
" show matching brackets when text indicator is over them
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""'
"This is the configuration of the plugins

filetype off
if has("win32")
	set rtp+=~/vimfiles/bundle/Vundle.vim
	let path='~/vimfiles/bundle'
	call vundle#begin(path)
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'gmarik/vundle'

"""TAGLIST"""""
Plugin 'taglist.vim'
let Tlist_Show_One_File=1
nnoremap <leader>tl :TlistToggle<cr>
let Tlist_WinWidth=30
let Tlist_Use_Right_Window = 1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

""""""NERDTree"""""""""""
Plugin 'scrooloose/nerdtree'
nnoremap <leader>fe :NERDTreeToggle<cr>

"""""""ctrlp"""""
Plugin 'kien/ctrlp.vim'
let g:ctrlp_regexp = 1

""""""EasyGrep"""
Plugin 'dkprice/vim-easygrep'

"""""markdown""""
au BufRead,BufNewFile *.md set filetype=markdown

"""""ultisnips"""
Plugin 'SirVer/ultisnips'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""git"""
Plugin 'tpope/vim-fugitive'

"""""html"""
Plugin 'mattn/emmet-vim'

"""""auto-pairs"""""
Plugin 'jiangmiao/auto-pairs'

call vundle#end()

filetype plugin indent on
