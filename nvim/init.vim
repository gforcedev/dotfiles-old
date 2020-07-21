" --- Required ---
set nocompatible

" --- Plugins ---
" Start vim plug
call plug#begin('~/.local/share/nvim/site/plugged/')

" Actually load the plugins

" Themes
Plug 'rakr/vim-one'

" Programming related
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
Plug 'mboughaba/i3config.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go'

" Interface
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/colorizer'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

" Text editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-lion'
Plug 'tmsvg/pear-tree'

" Must go last
Plug 'ryanoasis/vim-devicons'

" End plugins
call plug#end()

" --- General ---
" Change the terminal title
set title

" Enable syntax highlighting
syntax on

" Don't show the mode because airline has it already
set noshowmode

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=" "

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" Use goimports rather than gofmt
let g:go_fmt_command = "goimports"

" some formatting options
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4           " 4 spaces to a tab

" Config for text editing plugins
let g:lion_squeeze_spaces = 1

let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'}
            \ }
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

let g:goyo_linenr = 1

" Use relative numbers in normal and absolute in insert
set number relativenumber

" Wrap on words, not characters
set wrap linebreak nolist

:augroup linehighlight
:  autocmd InsertEnter * set cursorline
:  autocmd InsertLeave * set nocursorline
:augroup END

" Line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Allow switching buffers without :w
set hidden

" Configure commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Highlight i3.conf
autocmd BufNewFile,BufRead ~/.config/i3/config, set syntax=i3config

" Configure go tools
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Colors and transparency

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme one
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" --- Airline ---
let g:airline_theme = 'one'        " Color scheme for the status bar
let g:airline_inactive_collapse = 1 " Collapse status bar for inactive windows
let g:airline_powerline_fonts = 1   " Use Powerline font for special symbols
set noshowmode                      " Disable default status bar
set laststatus=2                    " Always show status bar
" Extensions used:
"   Branch    - Show the current git branch
"   Tabline   - Enable top bar to show tabs and buffers
"   Syntastic - Show errors and warnings from Syntastic on the status bar
"   Tagbar    - Show the current function on the status bar
let g:airline_extensions = ['branch', 'tabline', 'ycm',]
" Label the tabs/buffers which allows for the tab navigation commands
let g:airline#extensions#tabline#buffer_idx_mode = 1

" --- NERDTree ---
let NERDTreeMapActivateNode = '<SPACE>' " Space opens dir/files
let NERDTreeMinimalUI   = 1             " Disable help message
let NERDTreeMouseMode   = 3             " Single click to open any dir/file
" Automatically open NERDtree if Vim is opened on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" --- Keybinds ---
" Helps moving around windows
map <silent> <C-j> <C-W>j
map <silent> <C-k> <C-W>k
map <silent> <C-h> <C-W>h
map <silent> <C-l> <C-W>l

" Helps moving around tabs
map <silent> <leader>tn :tabNext<cr>
map <silent> <leader>tp :tabprevious<cr>
map <silent> <leader>tc :tabclose<cr>
map <silent> <leader>to :tabnew<cr>
map <silent> <leader>tl :tabs<cr>

" Helps moving around buffers
map <silent> <leader>bn :bnext<cr>
map <silent> <leader>bp :bprevious<cr>
map <silent> <leader>bc :bd<cr>
map <silent> <leader>bo :new<cr>
map <silent> <leader>bl :ls<cr>

" Enter goyo. Leader+Z because 'zen mode'
map <silent> <leader>z :Goyo<cr>

" Hightlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set nohlsearch

" Toggle tree
map <silent> <leader>nn :NERDTreeToggle<cr>

" yank to xclip
set clipboard+=unnamedplus

" make x yank somewhere else irrelevant
nnoremap x "_x
vnoremap x "_x

" markdown preview config
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0
let g:mkdp_browser = 'google-chrome'

" Use LaTeX rather than plaintex
let g:polyglot_disabled = ['latex']
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'

" don't open a split to show warnings
let g:vimtex_quickfix_open_on_warning = 0

" Latex bindings for inkscape-figures
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" default fzf command (currently all files in the git root)
nnoremap <C-p> :GFiles<CR>
" currently open buffers
nnoremap <leader>; :Buffers<CR>

" ---coc.nvim---

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
