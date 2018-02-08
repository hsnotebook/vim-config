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

Plug 'romainl/vim-cool'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <leader>fe :NERDTreeToggle<cr>
nnoremap <leader>ff :NERDTreeFind<cr>

Plug 'kien/ctrlp.vim'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*
let g:ctrlp_clear_cache_on_exit = 0

Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>

Plug 'hotoo/pangu.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

Plug 'posva/vim-vue'
augroup vue_indent
    au!
    autocmd FileType vue setlocal expandtab | setlocal tabstop=2 | setlocal shiftwidth=2
augroup END

Plug 'othree/html5.vim'

Plug 'mattn/emmet-vim' , { 'for': ['xml', 'html', 'jsp', 'js', 'vue'] }

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

augroup plantuml_refresh
	au!
	au filetype plantuml nnoremap <f5> :w<cr>:silent make<cr>
	au filetype plantuml inoremap <f5> <esc>:w<cr>:silent make<cr>
augroup END

Plug 'vimwiki/vimwiki'
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {
			\ 'python': 'python',
			\ 'vimL': 'vim',
			\ 'bash': 'bash',
			\ 'java': 'java',
			\ 'json': 'json',
			\ 'xml': 'xml',
			\ 'plantuml': 'plantuml',
			\ 'perl': 'perl'}
let g:vimwiki_list = [wiki]
let g:vimwiki_html_header_numbering = 1
au Filetype vimwiki setlocal textwidth=80

" file:xxx::lineNum to unnamed register
function! VimwikiStoreLink()
	let @" = 'file:'.expand("%:p").'::'.line('.')
endfunction
command! StoreLink :call VimwikiStoreLink()

function! VimwikiLinkHandler(link)
	try
		let pageNum = matchstr(a:link, '::\zs\d\+')
		let file = matchstr(a:link, '^.*:\zs.*\ze::')
		let fileCmdOutput = system('file '.file)
		if pageNum ==? ""
			pageNum = 1
		endif
		if matchstr(fileCmdOutput, '\zsPDF\ze') ==? 'PDF'
			let opener = '/usr/bin/zathura'
			call system(opener.' -P '.pageNum.' '.file.' &')
			return 1
		elseif matchstr(fileCmdOutput, '\zstext\ze') ==? 'text'
			execute 'edit +'.pageNum.' '.file
			return 1
		else
			return 0
		endif
	catch
		echom "This can happen for a variety of reasons ..."
	endtry
	return 0
endfunction

set sessionoptions+=globals
Plug 'tpope/vim-obsession'

" eclim
augroup java
	au!
	au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
	au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
	au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END

Plug 'brookhong/cscope.vim'
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
" nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
" nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

call plug#end()
