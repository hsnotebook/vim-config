call plug#begin('~/.vim/plugged')

let mapleader=" "

syntax on

if (has("win32"))
	set encoding=utf-8
	set fileencodings=utf-8
endif

if (has("gui"))
	set go-=m
	set go-=T
	set go-=r
	set go-=R
	set go-=l
	set go-=L
	set guifont=Consolas:h15
	set autoread
endif

set directory=/tmp

filetype plugin indent on

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap tn :tabn<cr>
nnoremap tp :tabp<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>m :on<cr>
nnoremap <leader>e :e!<cr>

colorscheme wombat

nnoremap gV `[v`]

set showmatch
set mat=2

set showcmd

set hidden

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

set splitright

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

inoremap <C-l> <esc>b~ea

set tabstop=4
set shiftwidth=4
set noexpandtab
augroup two_tab_indent
	au!
	autocmd FileType xml,html,json setlocal tabstop=2 | setlocal shiftwidth=2
augroup END

set incsearch
set hlsearch
set ignorecase
set nowrapscan
hi Search cterm=NONE ctermfg=black ctermbg=gray

set autowrite

set laststatus=2
set statusline=%F%m%r%w\ %{fugitive#statusline()}\ [%l,%v]\ [%{&ff}]\ [%{&ft}]

function! DeleteTrailingWS()
	execute 'normal! mz'
	execute '%s/\s\+$//e'
	execute "normal! `z"
endfunction

augroup clear_trail_white_space
	au!
	au BufWritePre * :call DeleteTrailingWS()
augroup END

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

packadd! matchit

" grep setting
set grepprg=ag\ --nogroup\ --nocolor
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
augroup autoquickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l*    lwindow
augroup END

Plug 'romainl/vim-cool'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <leader>fe :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>

Plug 'kien/ctrlp.vim'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*,*/node_modules/*
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_root_markers = ['.root']

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>

Plug 'hotoo/pangu.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-abolish'

Plug 'posva/vim-vue'
augroup two_spaces_indent
    au!
    autocmd FileType scss,vue,javascript,yaml,css setlocal expandtab | setlocal tabstop=2 | setlocal shiftwidth=2
augroup END

Plug 'othree/html5.vim'

Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp', 'js', 'vue'] }

Plug 'leafgarland/typescript-vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

Plug 'easymotion/vim-easymotion'
map <Plug>(easymotion-prefix)w <Plug>(easymotion-bd-w)
map <Plug>(easymotion-prefix)e <Plug>(easymotion-bd-e)
map <Plug>(easymotion-prefix)l <Plug>(easymotion-lineforward)
map <Plug>(easymotion-prefix)h <Plug>(easymotion-linebackward)

Plug 'vim-scripts/fcitx.vim'
set ttimeoutlen=100

Plug 'gcmt/taboo.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
nnoremap <leader>tt :VimwikiToggleListItem<cr>

" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" let g:vim_markdown_toc_autofit = 1
" let g:vim_markdown_conceal = 2
" let g:vim_markdown_fenced_languages = ['bash=sh', 'viml=vim', 'sql=sql']
" let g:vim_markdown_folding_disabled = 1

" function! ChangeHeaderFromWikiToMarkdown()
" 	let header = getline('.')
" 	let header = substitute(header, ' =*$', '', 'g')
" 	let header = substitute(header, '=', '#', 'g')
" 	call setline('.', header)
" endfunction

" nnoremap <leader>ww :e ~/wiki/index.md<cr>

set sessionoptions+=globals
Plug 'tpope/vim-obsession'

Plug 'vim-scripts/DrawIt'

Plug 'ycm-core/YouCompleteMe'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" java
" let g:EclimLoggingDisabled=1
" augroup java
"        au!
"        au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
"        au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
"        au FileType java nnoremap <buffer> gd :JavaSearch -x declarations<cr>
"        au FileType java nnoremap <buffer> gi :JavaSearch -x implementors<cr>
"        au FileType java inoremap <buffer> <c-d> <c-x><c-u>
" augroup END
augroup java
       au!
       au FileType java nnoremap <buffer> <leader>o :YcmCompleter OrganizeImports<cr>
       au FileType java nnoremap <buffer> <leader>i :YcmCompleter FixIt<cr>
       au FileType java nnoremap <buffer> gd :YcmCompleter GoToDeclaration<cr>
       au FileType java nnoremap <buffer> gi :YcmCompleter GoToDefinition<cr>
       au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END

call plug#end()
