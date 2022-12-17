set exrc
set secure
set encoding=utf-8
scriptencoding utf-8

" Autoload external plugins
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" External plugins
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sbdchd/neoformat'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
call plug#end()

let mapleader=','

" Builtin optional plugins
" Activate matchit plugin
runtime! macros/matchit.vim

" Activate man page plugin
runtime! ftplugin/man.vim

" Builtin options and settings
if !has('nvim')
	" Change cursor shapes based on whether we are in insert mode,
	let &t_SI = "\<esc>[6 q"
	let &t_EI = "\<esc>[2 q"
	if exists('&t_SR')
		let &t_SR = "\<esc>[4 q"
	endif

	" The number of color to use
	set t_Co=256
endif

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Use English as default
language en_US.utf-8

filetype plugin indent on
syntax enable

set wrap
set tw=60

" Set height of status line
set laststatus=2

" Changing folding behaviour
setlocal foldmethod=indent
set nofoldenable
set foldlevel=99
set fillchars=fold:\  "The backslash escapes a space
set foldtext=CustomFoldText()

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Clipboard settings, always use clipboard for all delete, yank, change, put
set clipboard+=unnamed
set clipboard+=unnamedplus

set noswapfile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」

" Show line number and relative line number
set number relativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" Perform dot commands over visual blocks
vnoremap . :normal .<CR>

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" List all items and start selecting matches in cmd completion
set wildmode=list:full

" Show current line where the cursor is
set cursorline

" Set a ruler at column 80, see https://stackoverflow.com/q/2447109/6064933
set colorcolumn=80

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3

" Use mouse to select and resize windows, etc.
if has('mouse')
	set mouse=nic  " Enable mouse in several mode
	set mousemodel=popup  " Set the behaviour of mouse
endif

" Do not show mode on command line since vim-airline can show it
set noshowmode

" Do not show ruler
set noruler

" Fileformats to use for new files
set fileformats=unix,dos

" The mode in which cursorline text can be concealed
set concealcursor=nc

" The way to show the result of substitution in real time for preview
if exists('&inccommand')
	set inccommand=nosplit
endif

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Do not use visual and error bells
set novisualbell noerrorbells

" The level we start to fold
"set foldlevel=0

" The number of command and search history to keep
set history=500

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+

" Auto-write the file based on some condition
set autowrite

" Show hostname, full path of file and last-mod time on the window title. The
" meaning of the format str for strftime can be found in
" http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
" lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
set title
set titlestring=
set titlestring+=%(%{hostname()}\ \ %)
set titlestring+=%(%{expand('%:p')}\ \ %)
set titlestring+=%{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}

" Persistent undo even after you close a file and re-open it.
" For vim, we need to set up an undodir so that $HOME is not cluttered with
" undo files.
if !has('nvim')
	if !isdirectory($HOME . '/.local/vim/undo')
		call mkdir($HOME . '/.local/vim/undo', 'p', 0700)
	endif
	set undodir=~/.local/vim/undo
endif
set undofile

" Completion behaviour
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window

" Settings for popup menu
set pumheight=15  " Maximum number of items to show in popup menu
if exists('&pumblend')
	set pumblend=5  " Pesudo blend effect for popup menu
endif

" Scan files given by `dictionary` option
set complete+=k,kspell complete-=w complete-=b complete-=u complete-=t

set spelllang=en,cjk  " Spell languages

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

" Virtual edit is useful for visual block edit
set virtualedit=block

" Correctly break multi-byte characters such as CJK,
" see https://stackoverflow.com/q/32669814/6064933
set formatoptions+=mM

" Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
set tildeop

" Do not add two spaces after a period when joining lines or formatting texts,
" see https://stackoverflow.com/q/4760428/6064933
set nojoinspaces

" Text after this column is not highlighted
set synmaxcol=500

" Increment search
set incsearch

set wildmenu

" Do not use corsorcolumn
set nocursorcolumn

set backspace=indent,eol,start  " Use backsapce to delete

" Tab mappings
map <leader>n :tabnew<space>
map <A-h> :tabp<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt

" Coc bindings
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<cr>
nmap <silent> gy :call CocAction('jumpTypeDefinition', 'tab drop')<cr>
nmap <silent> gr :call CocAction('jumpReferences', 'tab drop')<cr>
nmap <silent> gh:CocCommand clangd.switchSourceHeader<cr>
nmap <silent> gth:CocCommand clangd.switchSourceHeader tabe<cr>

nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" for coc-vimtex
let g:tex_flavor = 'latex'

" Open my bibliography file in split
map <leader>b :vsp<space>$BIB<CR>
map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Fzf
nmap <C-f> :Files<CR>

" C++ vs C filetypes
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :Files<CR>
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Automatically deletes all trailing whitespace and newlines (except one, posix standard) at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
	highlight! link DiffText MatchParen
endif

" Plugin-specific
" Goyo plugin makes text more readable when writing prose
map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

function! CustomFoldText()
	let indentation = indent(v:foldstart - 1)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = " " . foldSize . " lines "
	let foldLevelStr = repeat("+--", v:foldlevel)
	let expansionString = repeat(" ", indentation)
	return expansionString . foldLevelStr . foldSizeStr
endfunction

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

" Variables
" Do not load netrw by default since I do not use it, see
" https://github.com/bling/dotvim/issues/4
let g:loaded_netrwPlugin = 1

" Do not load tohtml.vim
let g:loaded_2html_plugin = 1

" Auto commands
" Do not use smart case in command line mode,
" extracted from https://vi.stackexchange.com/q/16509/15292
if exists('##CmdLineEnter')
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif

" Set textwidth for text file types
augroup text_file_width
	autocmd!
	" Sometimes, automatic filetype detection is not right, so we need to
	" detect the filetype based on the file extensions
	autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=79
augroup END

if exists('##TermOpen')
	augroup term_settings
		autocmd!
		" Do not use number and relative number for terminal inside nvim
		autocmd TermOpen * setlocal norelativenumber nonumber
		" Go to insert mode by default to start typing command
		autocmd TermOpen * startinsert
	augroup END
endif

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
	autocmd!
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
		\ | execute "normal! g`\"zvzz"
		\ | endif
augroup END

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379. For older Vim (version 7.4), the
" help file are in gzip format, do not warn this.
augroup non_utf8_file_warn
	autocmd!
	autocmd BufRead * if &fileencoding != 'utf-8' && expand('%:e') != 'gz'
				\ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

augroup number_toggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END

" Custom key mappings
" Save key strokes (now we do not need to press shift to enter command mode).
" Vim-sneak has also mapped `;`, so using the below mapping will break the map
" used by vim-sneak
nnoremap ; :
xnoremap ; :

" Quicker way to open command window
nnoremap q; q:

" Turn the word under cursor to upper case
inoremap <silent> <c-u> <Esc>viwUea

" Turn the current word into title case
inoremap <silent> <c-t> <Esc>b~lea

" Quit all opened buffers
nnoremap <silent> <leader>Q :qa<CR>

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" Move the cursor based on physical lines, not the actual lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0

" Do not include white space characters when using $ in visual mode,
" see https://vi.stackexchange.com/a/18571/15292
xnoremap $ g_

" Go to start or end of line easier
nnoremap H ^
xnoremap H ^
nnoremap L g_
xnoremap L g_

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv

" For more info , see https://superuser.com/q/246641/736190 and
" https://unix.stackexchange.com/q/162528/
" https://stackoverflow.com/questions/67370086/how-to-remap-coc-nvim-autocomplete-key
inoremap <silent><expr> <tab> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use Esc to quit builtin terminal
if exists(':tnoremap')
	tnoremap <ESC>   <C-\><C-n>
endif

" Change text without putting the text into register,
" see https://stackoverflow.com/q/54255/6064933
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Clear highlighting
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

nnoremap <up> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <down> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <right> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>
nnoremap <left> :echoerr "Don't use arrow keys, use H, J, K, L instead!"<CR>

" UI settings
if !has('gui_running')
	augroup MyColors
		autocmd!
		autocmd ColorScheme * call MyHighlights()
	augroup END
else
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
endif

function! MyHighlights() abort
	highlight clear

	" The following colors are taken from ayu_mirage vim-airline theme,
	" link: https://github.com/vim-airline/vim-airline-themes/
	hi User1 ctermfg=0 ctermbg=114
	hi User2 ctermfg=114 ctermbg=0

	" The following colors are taken from vim-gruvbox8,
	" link: https://github.com/lifepillar/vim-gruvbox8
	hi Normal ctermfg=187 ctermbg=NONE cterm=NONE
	hi CursorLineNr ctermfg=214 ctermbg=NONE cterm=NONE
	hi FoldColumn ctermfg=102 ctermbg=NONE cterm=NONE
	hi SignColumn ctermfg=187 ctermbg=NONE cterm=NONE
	hi VertSplit ctermfg=59 ctermbg=NONE cterm=NONE

	hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE
	hi Comment ctermfg=102 ctermbg=NONE cterm=italic
	hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE
	hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
	hi ErrorMsg ctermfg=234 ctermbg=203 cterm=bold
	hi Folded ctermfg=102 ctermbg=237 cterm=italic
	hi LineNr ctermfg=243 ctermbg=NONE cterm=NONE
	hi MatchParen ctermfg=NONE ctermbg=59 cterm=bold
	hi NonText ctermfg=239 ctermbg=NONE cterm=NONE
	hi Pmenu ctermfg=187 ctermbg=239 cterm=NONE
	hi PmenuSbar ctermfg=NONE ctermbg=239 cterm=NONE
	hi PmenuSel ctermfg=239 ctermbg=109 cterm=bold
	hi PmenuThumb ctermfg=NONE ctermbg=243 cterm=NONE
	hi SpecialKey ctermfg=102 ctermbg=NONE cterm=NONE
	hi StatusLine ctermfg=239 ctermbg=187 cterm=reverse
	hi StatusLineNC ctermfg=237 ctermbg=137 cterm=reverse
	hi TabLine ctermfg=243 ctermbg=237 cterm=NONE
	hi TabLineFill ctermfg=243 ctermbg=237 cterm=NONE
	hi TabLineSel ctermfg=142 ctermbg=237 cterm=NONE
	hi ToolbarButton ctermfg=230 ctermbg=59 cterm=bold
	hi ToolbarLine ctermfg=NONE ctermbg=59 cterm=NONE
	hi Visual ctermfg=NONE ctermbg=59 cterm=NONE
	hi WildMenu ctermfg=109 ctermbg=239 cterm=bold
	hi Conceal ctermfg=109 ctermbg=NONE cterm=NONE
	hi Cursor ctermfg=NONE ctermbg=NONE cterm=reverse
	hi DiffAdd ctermfg=142 ctermbg=234 cterm=reverse
	hi DiffChange ctermfg=107 ctermbg=234 cterm=reverse
	hi DiffDelete ctermfg=203 ctermbg=234 cterm=reverse
	hi DiffText ctermfg=214 ctermbg=234 cterm=reverse
	hi Directory ctermfg=142 ctermbg=NONE cterm=bold
	hi EndOfBuffer ctermfg=234 ctermbg=NONE cterm=NONE
	hi IncSearch ctermfg=208 ctermbg=234 cterm=reverse
	hi ModeMsg ctermfg=214 ctermbg=NONE cterm=bold
	hi MoreMsg ctermfg=214 ctermbg=NONE cterm=bold
	hi Question ctermfg=208 ctermbg=NONE cterm=bold
	hi Search ctermfg=214 ctermbg=234 cterm=reverse
	hi SpellBad ctermfg=203 ctermbg=NONE cterm=italic,underline
	hi SpellCap ctermfg=109 ctermbg=NONE cterm=italic,underline
	hi SpellLocal ctermfg=107 ctermbg=NONE cterm=italic,underline
	hi SpellRare ctermfg=175 ctermbg=NONE cterm=italic,underline
	hi Title ctermfg=142 ctermbg=NONE cterm=bold
	hi WarningMsg ctermfg=203 ctermbg=NONE cterm=bold
	hi Boolean ctermfg=175 ctermbg=NONE cterm=NONE
	hi Character ctermfg=175 ctermbg=NONE cterm=NONE
	hi Conditional ctermfg=203 ctermbg=NONE cterm=NONE
	hi Constant ctermfg=175 ctermbg=NONE cterm=NONE
	hi Define ctermfg=107 ctermbg=NONE cterm=NONE
	hi Debug ctermfg=203 ctermbg=NONE cterm=NONE
	hi Delimiter ctermfg=208 ctermbg=NONE cterm=NONE
	hi Error ctermfg=203 ctermbg=234 cterm=bold,reverse
	hi Exception ctermfg=203 ctermbg=NONE cterm=NONE
	hi Float ctermfg=175 ctermbg=NONE cterm=NONE
	hi Function ctermfg=142 ctermbg=NONE cterm=bold
	hi Identifier ctermfg=109 ctermbg=NONE cterm=NONE
	hi Ignore ctermfg=fg ctermbg=NONE cterm=NONE
	hi Include ctermfg=107 ctermbg=NONE cterm=NONE
	hi Keyword ctermfg=203 ctermbg=NONE cterm=NONE
	hi Label ctermfg=203 ctermbg=NONE cterm=NONE
	hi Macro ctermfg=107 ctermbg=NONE cterm=NONE
	hi Number ctermfg=175 ctermbg=NONE cterm=NONE
	hi Operator ctermfg=107 ctermbg=NONE cterm=NONE
	hi PreCondit ctermfg=107 ctermbg=NONE cterm=NONE
	hi PreProc ctermfg=107 ctermbg=NONE cterm=NONE
	hi Repeat ctermfg=203 ctermbg=NONE cterm=NONE
	hi SpecialChar ctermfg=203 ctermbg=NONE cterm=NONE
	hi SpecialComment ctermfg=203 ctermbg=NONE cterm=NONE
	hi Statement ctermfg=203 ctermbg=NONE cterm=NONE
	hi StorageClass ctermfg=208 ctermbg=NONE cterm=NONE
	hi Special ctermfg=208 ctermbg=NONE cterm=italic
	hi String ctermfg=142 ctermbg=NONE cterm=italic
	hi Structure ctermfg=107 ctermbg=NONE cterm=NONE
	hi Todo ctermfg=fg ctermbg=234 cterm=bold,italic
	hi Type ctermfg=214 ctermbg=NONE cterm=NONE
	hi Typedef ctermfg=214 ctermbg=NONE cterm=NONE
	hi Underlined ctermfg=109 ctermbg=NONE cterm=underline
	hi CursorIM ctermfg=NONE ctermbg=NONE cterm=reverse

	hi Comment cterm=NONE
	hi Folded cterm=NONE
	hi SpellBad cterm=underline
	hi SpellCap cterm=underline
	hi SpellLocal cterm=underline
	hi SpellRare cterm=underline
	hi Special cterm=NONE
	hi String cterm=NONE
	hi Todo cterm=bold

	hi NormalMode ctermfg=137 ctermbg=234 cterm=reverse
	hi InsertMode ctermfg=109 ctermbg=234 cterm=reverse
	hi ReplaceMode ctermfg=107 ctermbg=234 cterm=reverse
	hi VisualMode ctermfg=208 ctermbg=234 cterm=reverse
	hi CommandMode ctermfg=175 ctermbg=234 cterm=reverse
	hi Warnings ctermfg=208 ctermbg=234 cterm=reverse
endfunction

if exists('&termguicolors')
	" If we want to use true colors, we must a color scheme which support true
	" colors, for example, https://github.com/sickill/vim-monokai
	set notermguicolors
endif
set background=dark
colorscheme desert

" Highlight trailing spaces and leading tabs
call matchadd('WarningMsg', '\s\+$')
call matchadd('WarningMsg', '^\t\+')

" statusline settings
let g:currentmode={
	\ 'n'  : 'NORMAL ',
	\ 'v'  : 'VISUAL ',
	\ 'V'  : 'V·Line ',
	\ "\<C-V>" : 'V·Block ',
	\ 'i'  : 'INSERT ',
	\ 'R'  : 'R ',
	\ 'Rv' : 'V·Replace ',
	\ 'c'  : 'Command ',
\}

set statusline=
set statusline+=%1*
" Show current mode
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%{&spell?'[SPELL]':''}

set statusline+=%#WarningMsg#
set statusline+=%{&paste?'[PASTE]':''}

set statusline+=%2*
" File path, as typed or relative to current directory
set statusline+=\ %F

set statusline+=%{&modified?'\ [+]':''}
set statusline+=%{&readonly?'\ []':''}

" Truncate line here
set statusline+=%<

" Separation point between left and right aligned items.
set statusline+=%=

set statusline+=%{&filetype!=#''?&filetype.'\ ':'none\ '}

" Encoding & Fileformat
set statusline+=%#WarningMsg#
set statusline+=%{&fileencoding!='utf-8'?'['.&fileencoding.']':''}

set statusline+=%2*
set statusline+=%-7([%{&fileformat}]%)

" Warning about byte order
set statusline+=%#WarningMsg#
set statusline+=%{&bomb?'[BOM]':''}

set statusline+=%1*
" Location of cursor line
set statusline+=[%l/%L]

" Column number
set statusline+=\ col:%2c

augroup check_mixed_tabs
	autocmd!
	autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning
		\ | let &statusline=&statusline
augroup END

augroup disable_auto_commenting
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

" Find if they are mixed indentings.
function! StatuslineTabWarning()
	if !exists('b:statusline_tab_warning')
		" If the file is unmodifiable, do not warn this.
		if !&modifiable
			let b:statusline_trailing_space_warning = ''
			return b:statusline_trailing_space_warning
		endif

		let has_leading_tabs = search('^\t\+', 'nw') != 0
		let has_leading_spaces = search('^ \+', 'nw') != 0

		if has_leading_tabs && has_leading_spaces
			let b:statusline_tab_warning = ' [mixed-indenting]'
		elseif has_leading_tabs
			let b:statusline_tab_warning = ' [tabbed-indenting]'
		else
			let b:statusline_tab_warning = ''
		endif
	endif

	return b:statusline_tab_warning
endfunction
