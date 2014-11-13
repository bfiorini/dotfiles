" Pathogen plugins loaded from .vim/bundle
execute pathogen#infect()

" Enablie features which are not Vi compatible but really really nice
set nocp
syn on
set syntax=on
filetype indent plugin on

" Enable line numbes
set nu

" Show matching braces
set showmatch

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab "supprime les tabulations et met des espaces
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
autocmd BufRead,BufNewFile *.sql  set tabstop=2|set shiftwidth =2|set softtabstop =2
autocmd BufRead,BufNewFile *.rb   set tabstop=2|set shiftwidth =2|set softtabstop =2
autocmd BufRead,BufNewFile *.html set tabstop=2|set shiftwidth =2|set softtabstop =2

set textwidth=79
set colorcolumn=+1
au VimEnter * hi! ColorColumn ctermbg=0 guibg=Black

" Make lambda look like λ
if v:version > 702
    au VimEnter * syntax keyword Statement lambda conceal cchar=λ
    au VimEnter * hi! link Conceal Statement
    au VimEnter * set conceallevel=2
endif

" highlight search results
set hlsearch

" Completion menu in status line
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.swp,*.bak,*.pyc,*.class

" Highlight the cursor line
set cursorline
" Enable mouse and select correctly
set mouse=a

" Set to auto read when a file is changed from the outside
set autoread

" Ignore case when searching
set ignorecase
set smartcase

set encoding=utf8

set t_Co=256
if &term=="xterm"
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

colorscheme desert256

" GUI stuff
"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=b  "remove bottom-hand scroll bar
set guifont=Monospace\ 11

" Folding (collapse)
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf
set foldlevel=99

" Tab stuff
" set showtabline=2

" Always display status line
set laststatus=2
set statusline=%t%m\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%r%y%=%c,%l/%L\ %P

" NERDTree stuff
map <F3> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$']

" The working directory is always the one where the active buffer is located
" set autochdir

" Remove trailing spaces:
autocmd FileType c,cpp,java,php,ruby,python,puppet  autocmd BufWritePre <buffer> :%s/\s\+$//e

" My awesome mappings
let mapleader="\\"
map <Leader>w' ciw''<Esc>P
map <Leader>W' ciW''<Esc>P
map <Leader>w" ciw""<Esc>P
map <Leader>W" ciW""<Esc>P
map <Leader>w{ ciw{}<Esc>P
map <Leader>W{ ciW{}<Esc>P
map <Leader>w( ciw()<Esc>P
map <Leader>W( ciW()<Esc>P
map <Leader>w[ ciw[]<Esc>P
map <Leader>W[ ciW[]<Esc>P
