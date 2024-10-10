"=============
"== Plugins ==
"=============

call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'junegunn/vim-easy-align'
Plug 'Townk/vim-autoclose'
Plug 'vim-scripts/IndentAnything'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'majutsushi/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-sensible'
Plug 'alvan/vim-closetag'
Plug 'bling/vim-bufferline'
Plug 'adelarsq/vim-matchit'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colors
Plug 'gruvbox-community/gruvbox'
call plug#end()

"====================
"== Basic Settings ==
"====================
colorscheme gruvbox
set nocompatible
set bg=dark
set hls
set visualbell
set number
set background=dark
set showbreak=↪
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set mouse=a
set timeoutlen=1000
set ttimeoutlen=0
set cursorline
set ignorecase
set smartcase
set showcmd
set termguicolors
set cindent
set smartindent
set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8
set lazyredraw
set splitbelow
set splitright
set inccommand=nosplit
set relativenumber
set noshowmode
set signcolumn=number

syntax on
map <SPACE> <leader>
au BufEnter * set fo-=c fo-=r fo-=o

" Force python path to fix venv issues
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

" perl
let perl_extended_vars=1

" templates
augroup templates
	au!
	" read in templates files and go to end of file
	autocmd BufNewFile *.* silent! execute '0r $HOME/.config/nvim/templates/skeleton.'.expand("<afile>:e") | :$
augroup END

" tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

"==================
"== Key Bindings ==
"==================
" general
set clipboard=unnamedplus
nnoremap Q <nop>
nmap <leader>d <C-]>
nmap Y y$
nnoremap <silent> <Leader>/ :nohlsearch<CR>
inoremap <C-H> <C-W></C-W></C-W>
nnoremap <leader>q :bp<cr>:bd #<cr>
command F Files
nmap ; :

" tagbar
nmap <F3> :TagbarToggle<CR>

" commenting (NERD)
nmap <C-c> <leader>c<space>
vmap <C-c> <leader>c<space>
let g:NERDDefaultAlign='left'

" autoclose
let g:AutoClosePairs="() {} \" ' []"

" map tab to tab selection in visual
" and normal modes and shift tab to
" untab
vmap <tab> >gv
vmap <S-tab> <gv
nmap <tab> >>
nmap <S-tab> <<

" Telescope
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <C-b> <cmd>Telescope buffers<cr>


" navigate between buffers
" using Ctrl+Arrow
nnoremap <C-Right> :bn<CR>
vnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>
vnoremap <C-Left> :bp<CR>

" navigate between buffers
" using leader
nnoremap <leader><Right> :bn<CR>
nnoremap <leader><Left> :bp<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bu :bu<CR>

" toggle spell check
nmap <leader>ss :setlocal spell!<CR>

" navigate between windows
" using Shift+Arrow
nmap <silent> <S-Up> :wincmd k<CR>
nmap <silent> <S-Down> :wincmd j<CR>
nmap <silent> <S-Left> :wincmd h<CR>
nmap <silent> <S-Right> :wincmd l<CR>

" ctrl+backspace
imap <C-BS> <C-W>
imap <C-Del> <C-O>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>dB
inoremap <C-Del> <C-\><C-o>dw

" easyalign
vmap <leader>a <Plug>(EasyAlign)

" split/join
nmap <leader>gs gS
nmap <leader>gj gJ

" toggle whitespace
set listchars=eol:$,tab:▸\ ,trail:·,space:·
noremap <F2> :set list!<CR>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>tt :NERDTreeToggle<CR>

" Mac keys
" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
map <C-a> <Home>
map <C-e> <End>
imap <C-a> <Home>
imap <C-e> <End>

" close if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"====================
"== Plugin Configs ==
"====================
if !exists('g:vscode')
	" lightline
	let g:lightline = {
	\	'colorscheme': 'one',
	\	'active': {
	\		'left': [
	\			[ 'mode', 'paste' ],
	\			[ 'readonly', 'modified', 'currenttag', 'bufferline' ],
	\		],
	\		'right': [
	\			[ 'lineinfo' ],
	\			[ 'percent' ],
	\			[ 'fileformat', 'fileencoding', 'filetype' ],
	\		],
	\	},
	\	'component': {
	\		'currenttag': '%{tagbar#currenttag("[%s]", "[]")}',
	\       'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}'
	\	},
	\ }

	" bufferline
	let g:bufferline_echo=0

	" deoplete
	let g:deoplete#enable_at_startup=1
	let g:deolete#enable_smart_case=1
	"let g:deoplete#auto_complete_start_length=3

	" closetag
	let g:closetag_filenames='*.html,*.html.ep,*.phtml,*.xml'

	"autoclose
	let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}
endif

