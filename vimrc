" Notes {
"
" 	This is the personal .vimrc file of Emery Miller
"
" }

" Environment {
	" Basics {
		set nocompatible 		" must be first line
	" }

	" Pathogen {
		silent! call pathogen#runtime_append_all_bundles()
		call pathogen#helptags()
	" }
" } 
	
" General {
	set background=dark        " Assume a dark background
	filetype plugin indent on  	" Automatically detect file types.
	set mouse=a					" automatically enable mouse usage
	"set autochdir 				" always switch to the current file directory.. 
	" not every vim is compiled with this, use the following line instead
	" If you use command-t plugin, it conflicts with this, comment it out.
     "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
	scriptencoding utf-8
	set autowrite                  " automatically write a file when leaving a modified buffer
	"set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
	"set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	"set virtualedit=onemore 	   	" allow for cursor beyond last character
	set history=1000  				" Store a ton of history (default is 20)
	set spell 		 	        	" spell checking on
	

    set hidden                  "Allow use of hidden buffers without the error prompt that shows by default
	" Setting up the directories {
		"set backup 						" backups are nice ...
		"set backupdir=$HOME/.vimbackup//  " but not when they clog .
		"set directory=$HOME/.vimswap// 	" Same for swap files
		"set viewdir=$HOME/.vimviews// 	" same for view files
		
		"" Creating directories if they don't exist
		"silent execute '!mkdir -p $HOME/.vimbackup'
		"silent execute '!mkdir -p $HOME/.vimswap'
		"silent execute '!mkdir -p $HOME/.vimviews'
		"au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
		"au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
	" }
	
	" Tabbing behaviour {
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
	" }
	
	" Showing hidden characters{
		nmap <leader>l :set list!<CR>
		set listchars=tab:▸\ ,eol:¬
		"highlight NonText guifg=#4a4a59
		"highlight SpecialKey guifg=#4a4a59
	" }
    " Vimrc easy editing {
        if has("autocmd")
            autocmd bufwritepost .vimrc source $MYVIMRC
        endif
" }

" Vim UI {
	colorscheme koehler    	    " load a colorscheme
	set tabpagemax=15 				" only show 15 tabs
	set showmode                   	" display the current mode

	"set cursorline  				" highlight current line
	"hi cursorline guibg=#333333 	" highlight bg color of current line
	"hi CursorColumn guibg=#333333   " highlight cursor

	"if has('cmdline_info')
	"	set ruler                  	" show the ruler
	"	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
	"	set showcmd                	" show partial commands in status line and
									" selected characters/lines in visual mode
	"endif

	if has('statusline')
		set laststatus=1           	" show statusline only if there are > 1 windows
		" Use the commented line if fugitive isn't installed
		"set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P " a statusline, also on steroids
		set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
	endif

	set backspace=indent,eol,start 	" backspace for dummys
	set linespace=0 				" No extra spaces between rows
	set nu 							" Line numbers on
	set showmatch                  	" show matching brackets/parenthesis
	set incsearch 					" find as you type search
	set hlsearch 					" highlight search terms
	set winminheight=0 				" windows can be 0 line high 
	set ignorecase 					" case insensitive search
	set smartcase 					" case sensitive when uc present
	set wildmenu 					" show list instead of just completing
	set wildmode=list:longest,full 	" comand <Tab> completion, list matches, then longest common part, then all.
	set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
	set scrolljump=5 				" lines to scroll when cursor leaves screen
	set scrolloff=3 				" minimum lines to keep above and below cursor
	set foldenable  				" auto fold code
	set gdefault					" the /g flag on :s substitutions by default

" }

" Formatting {
	set nowrap                     	" wrap long lines
	set autoindent                 	" indent at the same level of the previous line
	"set matchpairs+=<:>            	" match, to be used with % 
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	" Remove trailing whitespaces and ^M chars
	autocmd FileType c,cpp,java,php,js,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key Mappings {

	"The default leader is '\', but many people prefer ',' as it's in a standard
	"location
	let mapleader = ','
    "Easy editing of .vimrc file
    nmap <leader>v :tabedit $MYVIMRC<CR>

	" Easier moving in tabs and windows
	map <C-J> <C-W>j
	map <C-K> <C-W>k
	map <C-L> <C-W>l
	map <C-H> <C-W>h

	" Yank from the cursor to the end of the line, to be consistent with C and D.
	nnoremap Y y$

	" Shortcuts
	" Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
	cmap cd. lcd %:p:h

	" visual shifting (does not exit Visual mode)
	vnoremap < <gv
	vnoremap > >gv 

	imap hh <ESC>

" }

" Language addons {
    " Java {
        autocmd Filetype java set makeprg=javac\ %
        set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
        map <C-7> :make<Return>:copen<Return>
        map <C-8> :cprevious<Return>
        map <C-9> :cnext<Return>
    " }
" }
" Plugins {

	
	" Ctags {
	""	set tags=./tags;/,~/.vimtags
	" }

	" EasyTags {
	""	let g:easytags_cmd = '/usr/local/bin/ctags'
	" }

	" SnipMate {
		" Setting the author var
	"	let g:snips_author = 'Emery Miller'
		" Shortcut for reloading snippets, useful when developing
	"	nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
	" }

	" NerdTree {
	"	map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
	""	map <leader>e :NERDTreeFind<CR>
	""	nmap <leader>nt :NERDTreeFind<CR>

	""	let NERDTreeShowBookmarks=1
	""	let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
	""	let NERDTreeChDirMode=0
	""	let NERDTreeQuitOnOpen=0
	""	let NERDTreeShowHidden=1
	""	let NERDTreeKeepTreeInNewTab=1
	" }
" }

" GUI Settings {
	" GVIM- (here instead of .gvimrc)
	if has('gui_running')
		syntax on
		set guioptions-=T          	" remove the toolbar
		set lines=40               	" 40 lines of text instead of 24,
		set transparency=5          " Make the window slightly transparent
	else
		set term=builtin_ansi       " Make arrow and other keys work
	endif
" }
"
" Cucumber alignment {
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
    
" }
