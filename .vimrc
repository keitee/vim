set nocompatible
filetype on
filetype plugin on
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" for user syntax
syntax enable

set incsearch

" set ignorecase
set nu

set smartindent
set shiftwidth=4
set tabstop=4

" show autocomplete menus
set wildmenu

" show editing mode
set showmode

" colorscheme darkblue
colorscheme desert

set cursorline

set autoread
set hlsearch
set nowrapscan

set foldenable
" set foldmethod=syntax
" set foldlevelstart=1
" set foldnestmax=5
" let g:is_bash=1
" let g:sh_fold_enabled=4
" let sh_fold_functions=1

" marks. to save the session info for up to 100 files and not to save global marks
"set viminfo='100,f0

au BufWinEnter,BufRead,BufNewFile *.nds set filetype=nds

" enable fold save and restore
au BufWinEnter *.nds silent loadview
au BufWinLeave *.nds mkview

" to see only matched line. do search first and hit \z
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
