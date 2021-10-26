set encoding=utf-8
set nocompatible
set noshowmode " doesnt show -insert- flag twice (because of lightline)

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  " Send To Terminal
  Plug 'jpalardy/vim-slime'

  "" Text Editing
  Plug 'rstacruz/vim-closer'
  Plug 'svermeulen/vim-subversive'
  Plug 'tpope/vim-surround'
  Plug 'chaoren/vim-wordmotion'

  "" Folding
  Plug 'tmhedberg/SimpylFold'
  Plug 'Konfekt/FastFold'
  Plug 'pseewald/vim-anyfold'

  "" Environments
  Plug 'petobens/poet-v'

  "" Indentation
  Plug 'Vimjas/vim-python-pep8-indent'

  "" Syntax highlighting
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'yyq123/vim-syntax-logfile'
  Plug 'mechatroner/rainbow_csv'
  Plug 'frazrepo/vim-rainbow'

  "" AutoCompletion
  Plug 'codota/tabnine-vim'

  "" List of methods and functions in file
  Plug 'majutsushi/tagbar'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'pechorin/any-jump.vim'

  "" Errors
  Plug 'dense-analysis/ale'

  "" Smart commenting
  Plug 'preservim/nerdcommenter'

  "" Show indentation guides
  Plug 'yggdroot/indentline'

  "" Colors
  Plug 'jsit/toast.vim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'altercation/vim-colors-solarized'
  Plug 'ryanoasis/vim-devicons'
  Plug 'stillwwater/vim-nebula'
  Plug 'sainnhe/edge'

  "" File browsing
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'pechorin/any-jump.vim'

  "" Search in files
  Plug 'eugen0329/vim-esearch'

  "" Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'samoshkin/vim-mergetool'

  "" Powerline
  Plug 'itchyny/lightline.vim'
  Plug 'sainnhe/lightline_foobar.vim'

  "" Testing
  Plug 'vim-test/vim-test'

  "" Working Directory
  Plug 'airblade/vim-rooter'

  "" LateX & Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  "Plug 'gabrielelana/vim-markdown'
  Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

  "" Startup
  Plug 'dstein64/vim-startuptime'
  Plug 'mhinz/vim-startify'

  "" Searching
  Plug 'unblevable/quick-scope'
  Plug 'itchyny/vim-cursorword'
  Plug 'pechorin/any-jump.vim'

  "" Sessions
  Plug 'tpope/vim-obsession'

call plug#end()

" Change working directory to path of open buffer
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Rename under cursor
:command -nargs=1 Rename %s/<c-r><c-w>/<f-args>/i

" Terminal
let g:slime_target = "vimterminal"

" Resizing of windows
nmap <Right> :vertical resize +1<CR>
nmap <Left> :vertical resize -1<CR>
nmap <Down> :resize +1<CR>
nmap <Up> :resize -1<CR>

"Terminal
if has('win32')
  set shell=pwsh
end
if has('unix')
  set shell=cmd
end

"ALE
let g:ale_linters = {
      \   'python': ['flake8', "bandit"],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \   'java': ['javac'],
      \   'xml': ['xmllint'],
      \   'css': ['stylelint'],
      \   'rst': [],
      \ }
let g:ale_fixers = {
      \   'python': ['black', 'isort'],
      \   'xml': ['xmllint'],
      \   'java': ['uncrustify'],
      \   'c': ['uncrustify'],
      \   'css': ['prettier'],
      \ }
nmap <leader>n :ALENext<CR>
nmap <leader>N :ALEPrevious<CR>
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 0
"Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
"I have some custom icons for errors and warnings but feel free to change them.
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" Flake8 Settings
let g:ale_python_flake8_options = '--max-line-length=88'


" Quick-Scope Colors
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

"TagBar
" Alt-right/left to navigate forward/backward in the tags stack
map <M-Left> <C-T>
map <M-Right> <C-]>
" Ctrl-t to open Tagbar
map <C-t> :TagbarToggle<CR>
" Path to Ctags exe
let g:tagbar_ctags_bin = 'C:/ProgramData/chocolatey/bin/ctags.exe'
let g:tagbar_autofocus = 1

" Folding
nnoremap <space> za
autocmd Filetype java AnyFoldActivate
autocmd Filetype js AnyFoldActivate
autocmd Filetype css AnyFoldActivate
autocmd Filetype html AnyFoldActivate
autocmd Filetype xml AnyFoldActivate
let g:anyfold_fold_comments=1
set foldlevel=1
filetype plugin indent on

" Ctrl-p
nmap <C-P> :FZF<CR>
" let g:ctrlp_show_hidden = 1


" Testing macros
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest -vv<CR>
nmap <silent> t<C-f> :TestFile -vv<CR>
nmap <silent> t<C-s> :TestSuite -vv<CR>
nmap <silent> t<C-l> :TestLast -vv<CR>
nmap <silent> t<C-g> :TestVisit -vv<CR>

" Colors
if has("gui_running")
  set guifont=JetbrainsMono_Nerd_Font_Mono:h10
endif
set t_Co=256
set background=dark
let g:airline_theme = 'onehalfdark'
" Important!!
if has('termguicolors')
  set termguicolors
endif
" The configuration options should be placed before `colorscheme edge`.
let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
colorscheme edge

" Powerline options
set laststatus=2 " Always display status bar
" use lightline-buffer in lightline
let g:lightline = {
      \ 'colorscheme': 'one'
      \ }


" Syntax highlights
syntax on
let python_highlight_all=1

" NERDTree settings
nnoremap <C-n> :NERDTreeToggle<CR>

" Rooter settings
let g:rooter_patterns = ['.git', 'Makefile', 'setup.py', 'pom.xml']


" Fixing scroll speed
set lazyredraw
set regexpengine=1

" Session hotkeys
let g:session_dir = '$HOME/.vim/vim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Leader
let mapleader = ","

" Buffer settings
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bl :ls<CR>

" Tab Settings
nmap <leader>tl :tabnext<CR>
nmap <leader>th :tabprevious<CR>

" ESC mapping
:imap kj <Esc>

" Cursor settings
let &t_SI = "\<esc>[5 q" " I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" " block cursor for normal mode

" Line numbering
set relativenumber

" Cursor line
set cursorline

" Tab to indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Split views
set splitbelow
set splitright

" Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

 " Backup and swap files in specific temp directory
if has('win32')
  set directory=$HOME/AppData/Local/Temp/
  set backupdir=$HOME/AppData/Local/Temp/
  set undodir=$HOME/AppData/Local/Temp/
endif
if has('unix')
  set directory=/tmp/
  set backupdir=/tmp/
  set undodir=/tmp/
endif

" Virtual python env
let g:poetv_executables = ['poetry']
"let g:poetv_auto_activate = 1
"let g:poetv_set_environment = 1

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
