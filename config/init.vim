" ===============================================================================
" Neovim Init
" ===============================================================================
set nocompatible

" Load plugin manager
" ===============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin manager
" ===============================================================================
call plug#begin('~/.config/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-cursorword'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }}
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}
Plug 'lervag/vimtex', {'for': 'tex'}
call plug#end()

" Global ENV
" ===============================================================================
let g:python3_host_prog='/opt/miniconda/bin/python3'
let g:node_host_prog='/usr/local/lib/node_modules/neovim/bin/cli.js'

" Key bindings
" ===============================================================================
let mapleader="\<Space>"
map ; :
inoremap uu <Esc>
vnoremap uu <Esc>
nnoremap S :w<CR>
nnoremap Q :q<CR>
nnoremap R :source $MYVIMRC<CR>
nnoremap U <C-r>
nmap Y y$
nmap H 10h
nmap J 10j
nmap K 10k
nmap L 10l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nmap <Leader><Left> :vertical resize -5<CR>
nmap <Leader><Right> :vertical resize +5<CR>
nmap <Leader><Up> :resize -5<CR>
nmap <Leader><Down> :resize +5<CR>
nmap <Leader><CR> :nohlsearch<CR>
nmap <Leader>rc :e ~/.config/nvim/init.vim<CR>
nmap <Leader>vs :vsplit
nmap <Leader>ds :diffsplit

" goto last position when quiting
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd InsertLeave * set nopaste

" Color scheme & settings
" ===============================================================================
colorscheme molokai
autocmd ColorScheme * highlight Visual ctermbg=238
autocmd ColorScheme * highlight CursorLine ctermbg=236

" Basic settings
" ===============================================================================
filetype plugin indent on
syntax on
set number
set relativenumber
set autoindent
set cindent

set linespace=0
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set hlsearch
set incsearch
exec "nohlsearch"
set ignorecase
set smartcase
set showmatch
set cursorline

set whichwrap+=<,>,h,l
set list
set listchars=tab:>-,trail:⌀,eol:§
set backspace=indent,eol,start
set iskeyword+=$,%,#,-

set diffopt+=vertical
set splitbelow
set splitright

set foldmethod=indent
set foldlevel=3
set nofoldenable
set laststatus=2
set wildmenu
set showcmd
set noshowmode
set scrolloff=6

set updatetime=300
set shortmess+=c
set signcolumn=yes

set history=100
set autoread
set autowrite
set nobackup
set nowritebackup
set noswapfile
set encoding=utf-8
set fileencodings=utf-8,gbk,gb18030

" cursor shape for different modes
let &t_SI.="\e[5 q" " SI = INSERT mode
let &t_SR.="\e[3 q" " SR = REPLACE mode
let &t_EI.="\e[1 q" " EI = NORMAL mode (ELSE)

" lightline settings
" ===============================================================================
let g:lightline={
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus', 'currentfunction' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'cocstatus': 'coc#status',
    \   'currentfunction': 'CocCurrentFunction',
    \   'filetype': 'DevIconsFiletype',
    \   'fileformat': 'DevIconsFileformat'
    \ },
    \ }

" need coc.nvim
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" need vim-devicons
function! DevIconsFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype  : 'no ft') : ''
endfunction

" need vim-devicons
function! DevIconsFileformat()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''
endfunction

" NERDTree settings
" ===============================================================================
map <Leader>nn :NERDTreeToggle<CR>
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''
let g:WebDevIconsUnicodeDecorateFolderNodes=v:true
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▽'
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.Trash', '\.cache', '\.DS_Store', '\.CFUserTextEncoding', '\.*_history', '\.*-hsts',
    \ '\.git', '\.pyc$', '\.swp', '__pycache__']

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close NERDTree when it's the last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" need vim-devicons
let g:webdevicons_conceal_nerdtree_brackets=1

" indentLine settings
" ===============================================================================
let g:indentLine_enabled=1
let g:indentLine_color_term=240
let g:indentLine_char='┆'

" Vista settings
" ===============================================================================
map <Leader>vv :Vista!!<CR>
let g:vista_default_executive='ctags'

" close Vista when it's the last window
autocmd BufEnter * if (winnr("$") == 1 && vista#sidebar#IsOpen()) | q | endif
" close NERDTree and Vista when they're the last two windows
autocmd BufEnter * if (winnr("$") == 2 && exists("b:NERDTree") && b:NERDTree.isTabTree() && vista#sidebar#IsOpen()) | q | q | endif

" coc settings
" ===============================================================================
let g:coc_global_extensions = ['coc-syntax', 'coc-python', 'coc-snippets', 'coc-json', 'coc-yank', 'coc-lists', 'coc-gitignore']
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

let g:coc_snippet_next='<Tab>'
let g:coc_snippet_prev='<S-Tab>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <Leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <Leader>a :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <Leader>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <Leader>c :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent> <Leader>o :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <Leader>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent> <Leader>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent> <Leader>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>p :<C-u>CocListResume<CR>

" vim-markdown settings
" ===============================================================================
let g:vim_markdown_folding_level=2
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_math=1
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0

" table-mode settings
" ===============================================================================
map <Leader>tm :TableModeToggle<CR>
let g:table_mode_corner='|'
let g:table_mode_corner_corner='|'
let g:table_mode_header_fillchar='-'

" markdown-preview settings
" ===============================================================================
map <Leader>mp :MarkdownPreview<CR>
let g:mkdp_markdown_css='/Users/del2z/.config/nvim/markdown-preview/markdown.css'
let g:mkdp_highlight_css='/Users/del2z/.config/nvim/markdown-preview/monokai.css'
let g:mkdp_port='10001'
let g:mkdp_page_title='${name}-Preview'

" julia-vim settings
" ===============================================================================
let g:latex_to_unicode_tab=0
let g:latex_to_unicode_suggestions=0
let g:latex_to_unicode_auto=1

" vimtex settings
" ===============================================================================
let g:tex_flavor='latex'
let g:tex_conceal=''
let g:vimtex_fold_manual=1


