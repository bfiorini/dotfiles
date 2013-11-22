" Pathogen plugins loaded from .vim/bundle
execute pathogen#infect()

let mapleader = ","
set  nocp
syn  on
set syntax =on
filetype  indent plugin on

set nu

set showmatch

set tabstop =4
set shiftwidth =4
set softtabstop =4
set expandtab "supprime les tabulations et met des espaces
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
autocmd BufRead,BufNewFile *.sql  set tabstop=2|set shiftwidth =2|set softtabstop =2
autocmd BufRead,BufNewFile *.rb   set tabstop=2|set shiftwidth =2|set softtabstop =2
autocmd BufRead,BufNewFile *.html set tabstop=2|set shiftwidth =2|set softtabstop =2

" highlight search results 
set hlsearch

set wildmenu
set wildmode =list:longest,list:full
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.swp,*.bak,*.pyc,*.class

set cursorline
" Enable mouse and select correctly
set mouse=a

" Set to auto read when a file is changed from the outside
set autoread

set ignorecase "Ignore case when searching
set smartcase

set encoding=utf8

colorscheme desert

" GUI stuff
"set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=b  "remove bottom-hand scroll bar
set guifont=Monospace\ 11

" OMNICOMPLETE
set completeopt=menuone,longest,preview
filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType c set omnifunc=ccomplete#Complete

inoremap <C-space> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Folding (collapse)
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf
set foldlevel=99

" Tab stuff
" set showtabline=2

" Status line: airline
set laststatus=2

" NERDTree stuff
map <F3> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" the working directory is always the one where the active buffer is located
set autochdir

" My awesome mappings
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
