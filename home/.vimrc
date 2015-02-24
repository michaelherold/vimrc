" => Configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use vim settings, rather than vi settings (much better!)
" Must be first, because it changes other options as a side effect
set nocompatible

fun! MySys()
  return "linux"
endfun

let s:cache_dir = '~/.vim/cache'
function! s:get_cache_dir(suffix)
  return resolve(expand(s:cache_dir . '/' . a:suffix))
endfunction

" }}}
" => General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vundle to manage plugins, see http://github.com/gmarik/Vundle.vim

" Turn off filetype for Vundle
filetype off

" Set the runtime pathto include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle - required!
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim'
Plugin 'nvie/vim-flake8'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'wting/rust.vim'
Plugin 'tpope/vim-rails'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'tpope/vim-dispatch'
Plugin 'jgdavey/vim-turbux'
Plugin 'othree/html5.vim'

call vundle#end()
filetype plugin indent on

" Set leader to ','
let mapleader = ","
let g:mapleader = ","

" }}}
" => Editing behavior {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showmode                " always show what mode we're in
set nowrap                  " don't wrap lines
set tabstop=2               " a tab is two spaces
set softtabstop=2           " when hitting <BS>, pretend like tab is removed, even if spaces
set expandtab               " expand tabs by default (overloadable per file type)
set shiftwidth=2            " number of spaces to use for auto indenting
set shiftround              " use multiple of shiftwidth when indenting with '>' and '<'
set smarttab                " insert tabs on line start according to shiftwidth
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent              " always set autoindenting on
set copyindent              " copy the previous indentation on autoindenting
set number                  " always show line numbers
set ruler                   " show location on command line
set showmatch               " set show matching parentheses
set ignorecase              " ignore case when searching
set smartcase               " ignore case only if search pattern all lowercase
set scrolloff=4             " keep 4 lines off the edges of the screen when scrolling
set virtualedit=block       " allow cursor to go in to 'invalid' places
set hlsearch                " highlight search terms
set incsearch               " show search matches as you type
set gdefault                " search/replace 'globally' by default

set listchars=tab:▸\ ,trail:·,extends:#,nbsp:· " set chars used for whitespace
set nolist                  " don't show invisible characters by default

set mouse=a                 " enable using the mouse if terminal emulator supports it

set fileformats=unix,dos,mac  " set the ordering for file formats
set formatoptions+=1        " when wrapping paragraphs, don't end lines with 1-letter words

" Sane regular expressions, via Steve Losh
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up srolling of viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" }}}
" => Folding rules {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldenable              " enable folding
set foldmethod=indent       " fold based on the indentation level
set foldnestmax=10          " set a max level of nested folding to 10
set foldlevelstart=10       " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                            " which commands trigger auto-fold

function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 2
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth -2 - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
  return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" }}}
" => Editor layout {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set termencoding=utf-8
set encoding=utf-8
set lazyredraw              " don't update the display when running macros
set laststatus=2            " tell vim to always put a status line in, even
                            "   when there's only one window

" }}}
" => Vim Behavior {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hidden                  " hide buffers instead of closing them
set switchbuf=useopen       " reveal already opened files from quickfix
                            "   instead of opening new buffers
set history=1000            " remember more commands and search history
set undolevels=1000         " use many mucho levels of undo
if v:version >= 730
  set undofile              " keep a persistent backup file
  set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                " do not want backup files!!!!!
set noswapfile              " NO SWAP FILE
set directory=~/.vim/.tmp,~/tmp,/tmp " set swap location, just in case
set viminfo='20,\"80        " read/write a .viminfo file, don't store more
                            "   than 80 lines of registers
set wildmenu                " make tab completion for files/buffer bash-like
set wildmode=list:full      " show a list when pressing tab and complete
                            "   first full match
set wildignore+=*.swp,*.bak,*.pyc,*.class
set wildignore+=tmp/**,*.rbc,*.rbx,*.scssc,*.sassc
set wildignore+=bundle/**,vendor/bundle/**
set wildignore+=coverage/**
set wildignore+=node_modules/**

set title                   " change the terminal's title
set visualbell              " don't beep
set noerrorbells            " don't beep
set showcmd                 " show (partial) command in the last line of the
                            "   screen; this also shows visual selection info
set modeline                " enable modelines
set cursorline              " underline the current line, for quick orientation

" }}}
" => Colors and Fonts {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &t_Co > 2 || has("gui_running")
  syntax on  " switch syntax highlighting on for color term
endif

set background=dark
let base16colorspace=256
colorscheme base16-railscasts

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" }}}
" => Shortcut Mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set ; to be : as well
nnoremap ; :

" Avoid accidentally hitting F1
map! <F1> <Esc>

" Quick closing of current window
nnoremap <leader>q :q<CR>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" Make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to marked line, ` jumps to the marked line and col
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Quick yanking to the end of the line
nmap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Pull word under cursor into LHS of a substitute (for quick search/replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Keep search matches in the middle of the window and pulse the line when
" moving to them
nnoremap n n:call PulseCursorLine()<CR>
nnoremap N N:call PulseCursorLine()<CR>

" Quickly get out of insert mode without moving your fingers
inoremap jk <Esc>

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Scratch
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Strip all trailing whitespace from a file, using ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Run ack fast
nnoremap <leader>a :Ack<Space>

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Gundo.vim
nnoremap <leader>u :GundoToggle<CR>

" Remap move to [beginning/end]-of-line commands
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>

" Make a more accessible <Esc> in insert mode
inoremap jk <Esc>

" }}}
" => Ctrl-P Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_map = '<leader>f'
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" }}}
" => NERDTree settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>n :NERDTreeToggle<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to
" open files
let NERDTreeMouseMouse=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
                    \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]

" }}}
" => Spell checking {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle and untoggle spell-check with <leader>ss
map <leader>ss :setlocal spell!<cr>

" Sane shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" }}}
" => Filetype Specific Handling {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
  augroup css_files " {{{
    autocmd!

    autocmd filetype css,less,scss setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 foldmethod=marker foldmarker={,}
  augroup end " }}}
  augroup html_files " {{{
    autocmd!

    autocmd filetype html,html.ruby,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

    " Auto-closing of HTML/XML tags
    let g:closetag_default_xml=1
    autocmd filetype html,html.ruby let b:closetag_html_style=1
    autocmd filetype html,html.ruby,xhtml,xml source ~/.vim/scripts/closetag.vim
  augroup end " }}}
  augroup javascript_files " {{{
    autocmd!

    autocmd filetype javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
    autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    autocmd filetype javascript call JavaScriptFold()
  augroup end " }}}
  augroup invisible_chars " {{{
    autocmd!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
    autocmd filetype javascript,css setlocal list
    autocmd filetype html setlocal list
  augroup end " }}}
  augroup python_files " {{{
    autocmd!

    " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
    " earlier, as it is important)
    autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd filetype python setlocal textwidth=80
    autocmd filetype python match ErrorMsg '\%>80v.\+'

    " But disable autowrapping as it is super annoying
    autocmd filetype python setlocal formatoptions-=t

    " Folding for Python (uses syntax/python.vim for fold definitions)
    "autocmd filetype python,rst setlocal nofoldenable
    "autocmd filetype python setlocal foldmethod=expr

    " Python runners
    autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
    autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
    autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
    autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

    " Run a quick static syntax check every time we save a Python file
    autocmd BufWritePost *.py call Flake8()
  augroup end " }}}
  augroup rst_files " {{{
    autocmd!

    " Auto-wrap text around 74 characters
    autocmd filetype rst setlocal textwidth=74
    autocmd filetype rst setlocal formatoptions+=nqt
    autocmd filetype rst match ErrorMsg '\%>74v.\+'
  augroup end " }}}
  augroup ruby_files " {{{
    autocmd!

    autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
  augroup end " }}}
  augroup textile_files " {{{
    autocmd!

    autocmd filetype textile set textwidth=78 wrap

    " Render YAML front matter inside Textile documents as comments
    autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
    autocmd filetype textile highlight link frontmatter Comment
  augroup end " }}}
  augroup vim_files " {{{
    autocmd!

    " Bind <F1> to show the keyword under the cursor
    " General help can still be entered manually, with :help
    autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    autocmd filetype vim setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
  augroup end " }}}
  augroup yaml_files " {{{
    autocmd!

    autocmd filetype yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
  augroup end " }}}
endif

" }}}
" => Python mode configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't run pylint on every save - handled by Flake8
let g:pymode_lint = 0
let g:pymode_lint_write = 0

" }}}
" => Extra vi Compatibility {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cpoptions+=$            " when changing a line, don't redisplay, but put
                            " a '$' at the end during the change
set formatoptions-=         " don't start new lines w/ comment leader on pressing 'o'
autocmd filetype vim set formatoptions-=o
                            " must explicitly reset for vim files
" }}}
" => Miscellaneous {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Restore cursor position upon reopening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Common abbreviations/misspellings
source ~/.vim/autocorrect.vim

" Helper function for search
function! PulseCursorLine()
  let current_window = winnr()

  windo set nocursorline
  execute current_window . 'wincmd w'

  setlocal cursorline

  redir => old_hi
  silent execute 'hi CursorLine'
  redir END
  let old_hi = split(old_hi, '\n')[0]
  let old_hi = substitute(old_hi, 'xxx', '', '')

  hi CursorLine guibg=#3a3a3a
  redraw
  sleep 20m

  hi CursorLine guibg=#4a4a4a
  redraw
  sleep 30m

  hi CursorLine guibg=#3a3a3a
  redraw
  sleep 30m

  hi CursorLine guibg=#2a2a2a
  redraw
  sleep 20m

  execute 'hi ' . old_hi

  windo set cursorline
  execute current_window . 'wincmd w'
endfunction

" Fix Windows ^M encoding problem
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" }}}
" vim:foldmethod=marker:foldlevel=0
