unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'andweeb/presence.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" Plug 'vim-syntastic/syntastic'
" Plug 'tpope/vim-surround'
" Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-json',
  \ ]

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'
let g:NERDTreeNodeDelimiter = "\u00a0"
" au VimEnter *  NERDTree

set termguicolors
syntax off
let g:Hexokinase_highlighters = ['background']
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE

"Enable italic styling for strings
highlight String cterm=italic gui=italic

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

set hlsearch
set incsearch
set clipboard=unnamedplus
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set fileformat=unix
set mouse=a
nnoremap c "_c
set nocompatible
filetype plugin on
set encoding=utf-8
set number

set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

vnoremap n :norm<Space>
vnoremap a :norm<Space>0i//<CR>
vnoremap . :norm .<CR>

" Remap the Tab key for indentation in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <C-a> :%y<CR>
nnoremap <C-x> :!g++ -std=c++17 -Wshadow -Wall % -O2 -Wno-unused-result && setsid st -e<CR>
nnoremap <C-e> :!g++ -std=c++17 -Wshadow -Wall % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && setsid st -e<CR>
nnoremap <C-q> :read /home/air/files/programs/problems/mytemplate.cpp<CR>i<BS><Esc>/overhere<CR>dwi<Tab>
nnoremap <C-s> :w<CR>
nnoremap <C-f> :%s//g<Left><Left>
nnoremap <silent> <C-t> :tabnew<CR>
"inoremap {<CR> {<CR><CR>}<Up>

autocmd BufWritePre * %s/\s\+$//e

cabbrev brs !setsid -f st -e browser-sync -b surf -w .
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
cabbrev grf !groff -ms -Tpdf -tle % > %:r.pdf

autocmd BufWritePost config.h,config.def.h !sudo make install

autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

"map ,, :keepp /<++><CR>ca<
"imap ,, <esc>:keepp /<++><CR>ca<


" vim-closetag options

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.js'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx, *.js'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,js'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'


