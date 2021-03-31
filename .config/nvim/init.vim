let mapleader =","

"---PLUGINS---"

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Quick guide: :PlugUpdate :PlugInstall :PlugClean :UpdateRemotePlugins
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Almost defaults
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
" Aesthetics
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'ryanoasis/vim-devicons'  " pkg: ttf-nerd-fonts-symbols
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'luochen1990/rainbow'
" Toolkit
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
" Development
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " pkg: ctags; :CocInstall coc-?
Plug 'jpalardy/vim-slime'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'  " pkg: python-black, python-isort, shellcheck, prettier
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " pkg: python-pynvim
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

"---BASICS---"

	set title
	set go=a
	set mouse=a
	set nohlsearch
	set clipboard+=unnamedplus
	set noshowmode
	set noruler
	set laststatus=0
	set noshowcmd

	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber

	set t_Co=256                           " ALL the colors!
	set ttyfast                            " don't lag...
	set cursorline                         " track position
	"set nowrap                            " don't wrap lines
	"set nobackup                          " disable backup files (filename~)
	set splitbelow splitright              " place new files below the current
	set showmatch                          " matching brackets & the like
	set clipboard+=unnamed                 " yank and copy to X clipboard
	set backspace=2                        " full backspacing capabilities (indent,eol,start)
	set scrolloff=10                       " keep 10 lines of context
	set number relativenumber              " show line numbers
	set directory=~/.vim/swap              " save swap files here
	set linebreak                          " attempt to wrap lines cleanly
	set wildmenu                           " enhanced tab-completion shows all matching cmds in a popup menu
	set wildmode=list:longest,full         " full completion options
	set spelllang=en_us                    " real English spelling
	set dictionary+=/usr/share/dict/words  " use standard dictionary
	"set spellfile=$HOME/Sync/vim/spell/en.tf-8.add

	let g:is_posix=1                       " POSIX shell scripts
	let g:loaded_matchparen=1              " disable parenthesis hlight plugin
	let g:is_bash=1                        " bash syntax the default for hilighting
	let g:vimsyn_noerror=1                 " hack for correct syntax hlighting

" tabs and indenting
	set tabstop=4                          " tabs appear as n number of columns
	set shiftwidth=4                       " n cols for auto-indenting
	set autoindent                         " auto indents next new line
	" set expandtab                        " spaces instead of tabs

" listchars
	set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

" status bar info and appearance
	set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
	set laststatus=2
	set cmdheight=1

" Enable autocompletion:
	set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=dark \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right:
	set splitbelow splitright

" Toggle colored right border after 80 chars
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

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	map <leader>S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>C :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

"--LaTeX--"
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

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=dark
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
	if &diff
		highlight! link DiffText MatchParen
	endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

"--Colorscheme--"
	colorscheme gruvbox
	" let g:gruvbox_transparent_bg=1
	" highlight Normal ctermbg=None " alpha

" Vim slime
    let g:slime_target = "tmux"

"--CoC--"
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


"--NERDTree--"
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif
	" If empty file
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	" If opened directory
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"--Airline--"
	let g:airline_theme='bubblegum'

"--tagbar--""
	let g:tagbar_autofocus=0
	let g:tagbar_width=20
	autocmd BufEnter *.py :call tagbar#autoopen(0)
	autocmd BufEnter *.tex :call tagbar#autoopen(0)

"--Slime--"
	let g:slime_python_ipython = 1
	let g:slime_cell_delimiter = "#%%"
	nmap <leader>c <Plug>SlimeSendCell

"--Ale--"
	" let g:ale_linters = {'python': ['flake8', 'pydocstyle', 'bandit', 'mypy']}
	" let g:ale_linters = {'python': ['pylint']} ", 'pydocstyle', 'bandit', 'mypy']}  # broken pylint
	let g:ale_fixers = {
				\'python': ['black', 'isort'],
				\'html': ['prettier'],
				\'css': ['prettier'],
				\'javascript': ['prettier'],
				\'yaml': ['prettier'],
				\}
	let g:ale_fix_on_save = 1
	let g:ale_lint_on_insert_leave = 0 " Slow
	let g:ale_lint_on_text_changed = 0 " Slow
	let g:ale_lint_on_enter = 0 " Slow

"--VimWiki--"
	let g:vimwiki_list = [{'path': '~/cloud/Notes',
						  \ 'syntax': 'markdown', 'ext': '.md'}]
	nmap <Leader>w+ <Plug>VimwikiNormalizeLink

"--NERDTree--"
	let NERDTreeShowHidden=1
	let g:NERDTreeMinimalUI=1

"--Rainbow Parentheses--"
	let g:rainbow_active = 1

"--UltiSnips--"
	let g:UltiSnipsExpandTrigger="<c-e>"
	let g:UltiSnipsJumpForwardTrigger="<c-f>"
	let g:UltiSnipsJumpBackwardTrigger="<c-b>"
	let g:UltiSnipsSnippetDirectories=["UltiSnips"]
	let g:ultisnips_python_style="numpy"

"--Buftabline--"
	set hidden
	nnoremap <C-N> :bnext<CR>
	nnoremap <C-P> :bprev<CR>
