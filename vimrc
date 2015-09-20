" vim: foldmethod=marker
" Filename: .vimrc
" Made by hs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set nocompatible

"""""encoding"""""
if has("win32")
	set encoding=gbk
else
	set encoding=utf-8
endif

set number
set relativenumber

set background=dark
colorscheme solarized
match ErrorMsg /[ \t]\+$/

set showcmd
set autowrite
set autoread

set showmatch
set mat=2

filetype on
syntax on
filetype plugin on
filetype indent on

" GUI Options {{{1
set guioptions-=T
set guioptions-=m
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set gcr=n:blinkon0

" Leader config {{{1
let mapleader="\\"
let maplocalleader="\\"

" Statusline {{{1
set laststatus=2
set statusline=%F%m%r%w\ [POS+%04l,%04v]\ [%p%%]\ [LEN=%L]

" Config for tabstop {{{1
set tabstop=4
set shiftwidth=4
set noexpandtab
autocmd FileType xml,html setlocal tabstop=2 | setlocal shiftwidth=2


" About how to search {{{1
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

" :Qargs {{{1
" The custom :Qargs command sets the arglist to contain each of the files
" referenced by the quickfix list.
" Copyed from vimcasts.org,
" url: http://vimcasts.org/episodes/project-wide-find-and-replace/
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Config for dictionary {{{1
au FileType css setlocal dict+=~/.vim/dict/css.dict
au FileType java setlocal dict+=~/.vim/dict/java.dict
au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/javascript.dict
au FileType html setlocal dict+=~/.vim/dict/css.dict
" }}}

" Config for plugins {{{1

filetype off
if has("win32")
	set rtp+=~/vimfiles/bundle/Vundle.vim
	let path='~/vimfiles/bundle'
	call vundle#begin(path)
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'

" Taglist.vim {{{2
Plugin 'taglist.vim'
let Tlist_Show_One_File=1
nnoremap <leader>tl :TlistToggle<cr>
let Tlist_WinWidth=30
let Tlist_Use_Right_Window = 1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"}}}

Plugin 'scrooloose/nerdtree'
nnoremap <leader>fe :NERDTreeToggle<cr>

" ctrlp {{{2
Plugin 'kien/ctrlp.vim'
let g:ctrlp_regexp = 1
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)|target)$',
	\ 'file': '\v\.(png|so|dll)$',
	\ }
" 2}}}

Plugin 'dkprice/vim-easygrep'

Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

Plugin 'tpope/vim-fugitive'

Plugin 'mattn/emmet-vim'

Plugin 'jiangmiao/auto-pairs'

" Plugin 'vimwiki/vimwiki'
" nmap <leader>tt <Plug>VimwikiToggleListItem
" let g:vimwiki_list = [
" 	\ {'path': '~/vimwiki/mybatis',
" 	\	'syntax': 'markdown', 'ext': '.md'},
" 	\ {'path': '~/vimwiki/new-oa',
" 	\	'syntax': 'markdown', 'ext': '.md'}
" 	\ ]

Plugin 'godlygeek/tabular'

Plugin 'nelstrom/vim-markdown-folding'
let g:markdown_fold_style='nested'

Plugin 'plasticboy/vim-markdown'
" Use vim-markdown-folding to fold
let g:vim_markdown_folding_disabled=1

Plugin 'hotoo/pangu.vim'
" autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()

Plugin 'mattn/calendar-vim'

Plugin 'vim-voom/VOom'

Plugin 'fencview.vim'

Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-surround'

Plugin 'tpope/vim-repeat'

Plugin 'DrawIt'

Plugin 'altercation/vim-colors-solarized'

Plugin 'vim-scripts/XML-Folding'

call vundle#end()

filetype plugin indent on
