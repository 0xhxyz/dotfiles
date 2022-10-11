unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'lifepillar/vim-gruvbox8'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
"Plug 'jreybert/vimagit'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
call plug#end()

let g:Hexokinase_highlighters = ['backgroundfull']


let g:gruvbox_termcolors=16
set bg=dark
let g:gruvbox_italic=1
colo gruvbox8
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE


set hlsearch
set incsearch

set clipboard=unnamedplus
set tabstop=4
set softtabstop=4
set shiftwidth=4
set termguicolors
set expandtab
set autoindent
set smartindent
set fileformat=unix
set mouse=a

nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number

set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
vnoremap . :normal .<CR>

map <leader>n :NERDTreeToggle<CR>

map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>

set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <C-s> :%s//g<Left><Left>
nnoremap <silent> <C-t> :tabnew<CR>

autocmd BufWritePre * %s/\s\+$//e


" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

