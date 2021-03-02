" Neovim config

let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

""""" Plugins
" Quick guide: :PlugUpdate :PlugInstall :PlugClean :UpdateRemotePlugins
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Almost defaults
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'frazrepo/vim-rainbow'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Aesthetics
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
" Toolkit
Plug 'tpope/vim-eunuch'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
" Development
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Requires ctags package
Plug 'jpalardy/vim-slime'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " Requires python-pynvim package
"Plug 'luochen1990/rainbow'
"Plug 'frazrepo/vim-rainbow'
call plug#end()

" Open NERDTree if opened directory or none
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Empty file
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif " Directory

" Colorscheme
colorscheme gruvbox
" let g:gruvbox_transparent_bg=1
" highlight Normal ctermbg=None " alpha

" Airline statusbar theme
let g:airline_theme='bubblegum'

" Many sane defaults
set t_Co=256                            " ALL the colors!
set ttyfast                             " don't lag…
set cursorline                          " track position
set nocompatible                        " leave the old ways behind…
"set nowrap                             " don't wrap lines
"set nobackup                           " disable backup files (filename~)
set splitbelow splitright               " place new files below the current
set showmatch                           " matching brackets & the like
set clipboard+=unnamed                  " yank and copy to X clipboard
set encoding=utf-8                      " UTF-8 encoding for all new files
set backspace=2                         " full backspacing capabilities (indent,eol,start)
set scrolloff=10                        " keep 10 lines of context
set number relativenumber               " show line numbers
set directory=~/.vim/swap               " save swap files here
"set ww=b,s,h,l,<,>,[,]                 " whichwrap -- left/right keys can traverse up/down
set linebreak                           " attempt to wrap lines cleanly
set wildmenu                            " enhanced tab-completion shows all matching cmds in a popup menu
set wildmode=list:longest,full          " full completion options
set spelllang=en_us                     " real English spelling
set dictionary+=/usr/share/dict/words   " use standard dictionary
"set spellfile=$HOME/Sync/vim/spell/en.utf-8.add

let g:is_posix=1                        " POSIX shell scripts
let g:loaded_matchparen=1               " disable parenthesis hlight plugin
let g:is_bash=1                         " bash syntax the default for hlighting
let g:vimsyn_noerror=1                  " hack for correct syntax hlighting

" tabs and indenting
set tabstop=4                           " tabs appear as n number of columns
set shiftwidth=4                        " n cols for auto-indenting
" set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line

" listchars
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

" status bar info and appearance
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
set laststatus=2
set cmdheight=1

" keep cursor centered
" :nnoremap j jzz
" :nnoremap k kzz

" {{{ toggle colored right border after 80 chars
set colorcolumn=0
let s:color_column_old = 80

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction

nnoremap <bar> :call <SID>ToggleColorColumn()<cr>
" }}}

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	"nnoremap S :%s//g<Left><Left>
	map <leader>S :%s//g<Left><Left>

" Enable autocompletion:
	set wildmode=longest,list,full

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>C :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

""""" LaTeX
let g:tex_flavor = 'latex'
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically deletes all trailing whitespace at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
    autocmd BufWritePre * %s/\n\+\%$//e
    autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Python

    let g:pymode = 1
    let g:pymode_run_bind = '<leader>r'

" Terminal
    tnoremap <C-y> <C-\><C-n>

" Vim slime
    let g:slime_target = "tmux"

" IPython cells -- probable deprecation for slime built-ins
"    nnoremap <leader>c :IPythonCellExecuteCell<CR>

""""" CoC
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" coc extensions
    "let g:coc_global_extensions = [
    "    'coc-pairs',
    "]

" tagbar
let g:tagbar_autofocus=0
let g:tagbar_width=20
autocmd BufEnter *.py :call tagbar#autoopen(0)

" slime for IPython
let g:slime_python_ipython = 1
let g:slime_cell_delimiter = "#%%"
nmap <leader>c <Plug>SlimeSendCell

" Python syntax highlight
" let g:pymode_syntax=1
" let g:pymode_syntax_slow_sync=1
" let g:pymode_syntax_all=1
" let g:pymode_syntax_print_as_function=g:pymode_syntax_all
" let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
" let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
" let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
" let g:pymode_syntax_highlight_self=g:pymode_syntax_all
" let g:pymode_syntax_indent_errors=g:pymode_syntax_all
" let g:pymode_syntax_string_formatting=g:pymode_syntax_all
" let g:pymode_syntax_space_errors=g:pymode_syntax_all
" let g:pymode_syntax_string_format=g:pymode_syntax_all
" let g:pymode_syntax_string_templates=g:pymode_syntax_all
" let g:pymode_syntax_doctests=g:pymode_syntax_all
" let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
" let g:pymode_syntax_builtin_types=g:pymode_syntax_all
" let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
" let g:pymode_syntax_docstrings=g:pymode_syntax_all

" Python reformat with Black on save and reload buffer
" autocmd BufWritePost *.py execute '!black %' | edit

" Ale formatting and fixing Python
" let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'bandit', 'mypy']}
" let g:ale_linters = {'python': ['pylint']} ", 'pydocstyle', 'bandit', 'mypy']}  # broken pylint
let g:ale_fixers = {'python': ['black', 'isort']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 0 " Slow
let g:ale_lint_on_text_changed = 0 " Slow
let g:ale_lint_on_enter = 0 " Slow

" VimWiki
let g:vimwiki_list = [{'path': '~/cloud/Notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
nmap <Leader>w+ <Plug>VimwikiNormalizeLink

" NERDTree
let NERDTreeShowHidden=1
