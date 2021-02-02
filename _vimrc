" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

set encoding=utf-8

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

  " Make sure you use single quotes
  " Better folding
  Plug 'tmhedberg/SimpylFold'
  " Indentation
  Plug 'Vimjas/vim-python-pep8-indent'

  " Syntax highlighting
  Plug 'nvie/vim-flake8'
  Plug 'vim-syntastic/syntastic'
  Plug 'dense-analysis/ale'
  Plug 'sheerun/vim-polyglot'

  " Formatting
  Plug 'ambv/black'

  " Scrolling smooter
  Plug 'psliwka/vim-smoothie'

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
  Plug 'kien/ctrlp.vim'
  Plug 'mileszs/ack.vim'

  " Git
  Plug 'tpope/vim-fugitive'

  " Powerline
  Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

  " Markdown 
  Plug 'plasticboy/vim-markdown'
  Plug 'godlygeek/tabular'

  " Testing
  Plug 'vim-test/vim-test'

  " Distraction free
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'


call plug#end()
" Leader
let mapleader = ","

" Limelight settings "
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.2

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 5

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = 10
" Enter Limelight with Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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
let python_highlight_all=1
syntax on

" Formatting
autocmd BufWritePost *.py execute ':Black'

" ALE
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \    'python': ['yapf'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

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
set foldlevel=3

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

