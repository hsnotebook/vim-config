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

" Plug 'junegunn/vim-easy-align'
" xnoremap ga <Plug>(EasyAlign)
" nnoremap ga <Plug>(EasyAlign)

Plug 'gcmt/taboo.vim'

Plug 'jiangmiao/auto-pairs'

function! SetConnectUrlVar()
	let bottom = getline(line('$'))
	if bottom =~ 'connectUrl'
		let connectUrl = split(bottom)[2]
		if !exists('w:db')
			echom ''
			let w:db = connectUrl
		endif
	endif
endfunction

Plug 'tpope/vim-dadbod'
augroup db
	au!
	au filetype sql vnoremap <cr> :DB<cr>
	au BufEnter *.sql :call SetConnectUrlVar()
augroup END

Plug 'vimwiki/vimwiki'
" let g:vimwiki_folding='expr'
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.auto_toc=1
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

nnoremap <leader>td :VimwikiToggleListItem<cr>

" file:xxx::lineNum to unnamed register
function! VimwikiStoreLink()
	let @" = 'file:'.expand("%:p").'::'.line('.')
endfunction
command! StoreLink :call VimwikiStoreLink()

function! VimwikiLinkHandler(link)

		let firstColonIndex = match(a:link, ':')
		let fileType = strpart(a:link, 0, firstColonIndex)

		let numSeperatorIndex = match(a:link, '::')
		if numSeperatorIndex == -1
			let fileNameLength = strlen(a:link) - firstColonIndex
		else
			let fileNameLength = numSeperatorIndex-firstColonIndex-1
		endif

		let fileName = strpart(a:link, firstColonIndex+1, fileNameLength)

		let pageNum = matchstr(a:link, '::\zs\d\+')
		if pageNum ==? ""
			let pageNum = 1
		endif

		if fileType == 'pdf'
			let opener = '/usr/bin/zathura'
			call system(opener . ' -P ' . pageNum . ' ' . fileName . ' &')
			return 1
		elseif fileType == 'file'
			" echom "execute 'edit +' . pageNum . ' ' . fileName"
			execute 'edit +' . pageNum . ' ' . fileName
			return 1
		elseif fileType == 'uml'
			let opener = '/home/hs/software/Umlet/umlet.sh'
			call system(opener . ' ' . fileName . ' &')
			return 1
		else
			return 0
		endif
endfunction

set sessionoptions+=globals
Plug 'tpope/vim-obsession'

" eclim
let g:EclimLoggingDisabled=1
augroup java
       au!
       au FileType java nnoremap <buffer> <leader>o :call eclim#java#import#OrganizeImports()<cr>
       au FileType java nnoremap <buffer> <leader>i :call eclim#java#correct#Correct()<cr>
       au FileType java nnoremap <buffer> gd :JavaSearch -x declarations<cr>
       au FileType java nnoremap <buffer> gi :JavaSearch -x implementors<cr>
       au FileType java inoremap <buffer> <c-d> <c-x><c-u>
augroup END


call plug#end()
