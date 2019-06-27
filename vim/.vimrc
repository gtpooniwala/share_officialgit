set number
set mouse=a                                                     " enable mouse for all modes
set nomousehide                                                 " dont hide mouse while typing
set mousemodel=popup                                            " right click pops up context menu
set ruler                                                       " show cursor position in status bar
set scrolloff=10                                                " to show 10 lines around the scroll
set showmatch
set title
set tags=tags
set fdm=syntax
" set autoindent
set wildmenu                                                    " completion
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
imap <S-left> <esc>:tabp<CR>i
imap <S-right> <esc>:tabn<CR>i
map <S-left> :tabp<CR>
map <S-right> :tabn<CR>
" set wrap

set magic
set splitright
set incsearch hlsearch smartcase                                " search
" set ignorecase
set backspace=indent,eol,start                                  " sane backspace
set nocul
" set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
" set cc=81
let &colorcolumn="81,".join(range(120,999),",")
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+\%#\@<!$/
filetype plugin indent on
" color default
" set textwidth=80                                                " vertical line at 79th character
set noequalalways
set cursorline                                                  " highlight current line
set guioptions-=T
set guioptions-=r
set guioptions-=L
set modeline
set laststatus=2

" map middle click to paste
map! <S-Insert> <MiddleMouse>

" appearance
syntax on
set background=dark
set t_Co=256                                                    " 256 color in terminal
set guifont=Ubuntu\ Mono\ 11
let g:molokar_original=1
colorscheme molokai

" override some highlight settings
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight DiffText      gui=none
highlight Macro         gui=none
highlight SpecialKey    gui=none

" highlight OverLength ctermbg=235 guibg=#2c2d27

" match OverLength /\%81v.\+/

set sessionoptions-=options

" Quickly open/reload vim
nnoremap <leader>sov :source $MYVIMRC<CR>
" Automatically rewmove extra white spaces on save
autocmd BufWritePre * %s/\s\+$//e
