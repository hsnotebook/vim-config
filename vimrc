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

colorscheme wombat

set showmatch
set mat=2

set showcmd

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

set splitright

inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

set tabstop=4
set shiftwidth=4
set noexpandtab
augroup xml_html_indent
	au!
	autocmd FileType xml,html setlocal tabstop=2 | setlocal shiftwidth=2
augroup END

set incsearch
set hlsearch
set ignorecase
set nowrapscan
hi Search cterm=NONE ctermfg=black ctermbg=gray
nnoremap <esc> :noh<cr><esc>

set autowrite

set laststatus=2
set statusline=%F%m%r%w\ %{fugitive#statusline()}\ [%l,%v]\ [%{&ff}]\ [%{&ft}]

inoremap <c-u> <esc>viwUea

function! DeleteTrailingWS()
	execute 'normal! mz'
	execute '%s/\s\+$//e'
	execute "normal! `z"
endfunction

augroup clear_trail_white_space
	au!
	au BufWritePre * :call DeleteTrailingWS()
augroup END

function! IndentAfterPaste()
	execute 'normal! mz'
	execute 'normal! p`[v`]='
	execute "normal! `z"
endfunction

nnoremap p :call IndentAfterPaste()<cr>

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

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 1

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <leader>fe :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn|target|bin)$',
	\ 'file': '\v\.(png|so|dll)$',
	\ }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:0'

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>

Plug 'hotoo/pangu.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp'] }

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

Plug 'junegunn/vim-easy-align'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

Plug 'gcmt/taboo.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'aklt/plantuml-syntax'
let g:plantuml_executable_script="java -jar /home/hs/bin/plantuml.jar -charset UTF-8"

Plug 'vimwiki/vimwiki'
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {
			\ 'python': 'python',
			\ 'vimL': 'vim',
			\ 'bash': 'bash',
			\ 'java': 'java',
			\ 'xml': 'xml',
			\ 'perl': 'perl'}
let g:vimwiki_list = [wiki]
let g:vimwiki_html_header_numbering = 1
au Filetype vimwiki setlocal textwidth=80


set sessionoptions+=globals
Plug 'tpope/vim-obsession'

"Plug 'Valloric/YouCompleteMe'
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" eclim
augroup java
	au!
	au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
	au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
	au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END

call plug#end()
