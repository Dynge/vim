" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

set encoding=utf-8
set nocompatible

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
"" Indentation
  Plug 'Vimjas/vim-python-pep8-indent'

  "" Syntax highlighting
  Plug 'dense-analysis/ale'
  Plug 'uiiaoo/java-syntax.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'yyq123/vim-syntax-logfile'
  Plug 'mechatroner/rainbow_csv'

  "" AutoCompletion
  Plug 'codota/tabnine-vim'

  "" List of methods and functions in file
  Plug 'majutsushi/tagbar'

  "" Errors
  Plug 'vim-syntastic/syntastic'

  "" Smart commenting
  Plug 'preservim/nerdcommenter'

  "" Show indentation guides
  Plug 'yggdroot/indentline'

  "" Colors
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'ryanoasis/vim-devicons'

  "" File browsing
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  "" Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  "" Powerline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  "" Testing
  Plug 'vim-test/vim-test'

  "" Working Directory
  Plug 'airblade/vim-rooter'

  Plug 'mhinz/vim-startify'
call plug#end()

" Resizing of windows
nmap <M-Right> :vertical resize +1<CR>
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

"Terminal
if has('win32')
  set shell=powershell
end
if has('unix')
  set shell=cmd
end

"ALE
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \   'rst': ['rstcheck'],
      \   'java': ['javac'],
      \   'xml': ['xmllint'],
      \   'css': ['stylelint'],
      \}
let g:ale_fixers = {
      \   'python': ['black'],
      \   'xml': ['xmllint'],
      \   'java': ['uncrustify'],
      \   'c': ['uncrustify'],
      \   'css': ['prettier'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 0
"Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
"I have some custom icons for errors and warnings but feel free to change them.
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'



"TagBar
" Ctrl-t to open Tagbar
map <C-t> :TagbarToggle<CR>
" Path to Ctags exe
let g:tagbar_ctags_bin = '~/Documents/ctags/ctags-2021-02-09_p5.9.20210207.0-3-gee5f9c55-x64/ctags.exe'
let g:tagbar_autofocus = 1

" Folding
nnoremap <space> za
set foldlevel=10
filetype plugin indent on
autocmd Filetype java AnyFoldActivate

" Ctrl-p
nmap <C-P> :FZF<CR>
" let g:ctrlp_show_hidden = 1


" Testing macros
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Colors
set t_Co=256
colorscheme onehalfdark
let g:airline_theme = 'onehalfdark'

" Powerline options
set laststatus=2 " Always display status bar


" Syntax highlights
syntax on
let python_highlight_all=1

" NERDTree settings
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
nnoremap <C-n> :NERDTreeToggle<CR>


" Rooter settings
let g:rooter_patterns = ['.git', 'Makefile', 'setup.py', 'pom.xml']


" Fixing scroll speed
set lazyredraw
set regexpengine=1

" Session hotkeys
let g:sessions_dir = '$HOME/.vim/vim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'


" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
  set directory=$HOME/tmp/
  set backupdir=$HOME/tmp/
  set undodir=$HOME/tmp/
endif

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
