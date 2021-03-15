" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

set encoding=utf-8

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  " Better folding
  Plug 'tmhedberg/SimpylFold'
  Plug 'Konfekt/FastFold'

  " Indentation
  Plug 'Vimjas/vim-python-pep8-indent'

  " Syntax highlighting
  Plug 'nvie/vim-flake8'
  Plug 'vim-python/python-syntax' 
  Plug 'vim-syntastic/syntastic'
  Plug 'sheerun/vim-polyglot'
  Plug 'mtdl9/vim-log-highlighting'

  " List of methods and functions in file
  Plug 'majutsushi/tagbar'

  " Formatting
  Plug 'ambv/black'

  " Smart commenting
  Plug 'preservim/nerdcommenter'

  " Show indentation guides
  Plug 'yggdroot/indentline'

  " Colors
  Plug 'sonph/onehalf', { 'rtp': 'vim' }

  " Ipython
  Plug 'williamjameshandley/vimteractive'

  " File browsing
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'chrismey/vim-conflicted'

  " Powerline
  Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

  " Markdown 
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  " Writing 
  Plug 'reedes/vim-pencil'

  " Testing
  Plug 'vim-test/vim-test'

call plug#end()

" Leader
let mapleader = ","

" Cursor line
set cursorline

" Fixing scroll speed
"set lazyredraw
"set regexpengine=1

" Session hotkeys
let g:sessions_dir = '$HOME/.vim/vim-sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:sessions_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:sessions_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'


"Markdown conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0


" Ctrl-p
nmap <C-P> :FZF<CR>
" let g:ctrlp_show_hidden = 1

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

" Powerline options
set laststatus=2 " Always display status bar

" ESC mapping
:imap kj <Esc>

" IPython
let g:vimteractive_default_shells = { 'python': 'ipython' }
let g:vimteractive_bracketed_paste_default = 0
let g:vimteractive_vertical = 1        " Vertically split terminals

" Syntax highlights
syntax on
let python_highlight_all=1

" Formatting
autocmd BufWritePost *.py execute ':Black'

" ALE
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
      \   'python': ['yapf'],
      \   'xml': ['xmllint'],
      \   'java': ['uncrustify'],
      \   'c': ['uncrustify'],
      \   'css': ['prettier'],
      \}
let g:ale_lint_on_text_changed = 'always'
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 0
" Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" I have some custom icons for errors and warnings but feel free to change them.
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'

"TagBar
" Ctrl-b to open Tagbar
map <C-b> :TagbarToggle<CR>
" Path to Ctags exe
let g:tagbar_ctags_bin = '~/Documents/ctags/ctags-2021-02-09_p5.9.20210207.0-3-gee5f9c55-x64/ctags.exe'

" Line numbering
set relativenumber

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

" Folding
nnoremap <space> za
set foldmethod=indent
set foldlevel=2

" Cursor settings
let &t_SI = "\<esc>[5 q" " I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" " block cursor for normal mode



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

