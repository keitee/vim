" vimrc for vim
"
"
" {===========================================================================
" general settings

" detect OS
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')

" set font and size
if has("gui_running")
  if has("gui_gtk2")
    " set guifont=FreeMono\ 12    " for ubuntu
    " set guifont=DroidSansMono   " for debian
    " set guifont=Hack            " for debian
    " set guifont=D2Coding\ 11    " for debian
    set guifont=D2Coding          " for debian
  endif
endif


" Be iMproved
" Compatible mode means compatibility to venerable old vi. When you :set
" compatible, all the enhancements and improvements of Vi Improved are turned
" off. It's not recommended to do this, but some systems provide (mostly for
" backwards compatibility with old Unix systems) a vi command that is
" implemented with Vim in compatible mode.
"
" Note that once a personal initialization file ~/.vimrc exists, Vim
" automatically turns on 'nocompatible' mode, so this usually is nothing to
" worry about. For the full story, :help 'compatible' has all the details.

if has('vim_starting')
   set nocompatible
endif


" {===========================================================================
" edit settings

" In vim 7.3.74 and higher you can do following `to alias` unnamed register to
" the + register, which is the system clipboard. By doing this, don't need to
" "+p but use p to make it available to other application in the system and vice
" versa.

set clipboard=unnamedplus

" for user syntax
syntax enable

" for showmatch
set showmatch

" set ignorecase
set smartcase

" line number. set number
set nu
set autoindent
set cindent

" show editing mode
set showmode

" show autocomplete menus
set wildmenu
set cursorline
set autoread
set autowrite
set nowrapscan
set foldenable
" for line wrapping and linebreak
set nowrap linebreak nolist

" remove _ from keyword set
" set iskeyword-=_ 


" {===========================================================================
" edit, indent, tabs settings

set smartindent
set shiftwidth=2 
set tabstop=2 
set softtabstop=2
set expandtab
set textwidth=80
set fo+=l
set colorcolumn=80

scriptencoding utf-8
set encoding=utf-8
set listchars=tab:»\ ,eol:¬
"set showbreak=«\ 
set showbreak=<< 


" {===========================================================================
" search settings

set incsearch
set hlsearch
" <C-u> is scroll up. <C-l> clears and redraws the screen (see :h CTRL-L). This
" mapping builds on top of the usual behavior by muting search highlighting.
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" search for visual selection
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
"}}}


" {===========================================================================
" spell settings
set spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add 
   
" utility mappings {{{
" to wrap a word with ' or " current time
map <F5> i'<Esc>ea'<Esc>
map <F6> i"<Esc>ea"<Esc>


"{{{ scroll
"===
   nnoremap <silent> n nzz
   nnoremap <silent> N Nzz
   nnoremap <silent> * *zz
   nnoremap <silent> # #zz
   nnoremap <silent> g* g*zz
   nnoremap <silent> g# g#zz
   nnoremap <silent> <C-o> <C-o>zz
   nnoremap <silent> <C-i> <C-i>zz
   nnoremap <silent> <C-d> <C-d>zz
   nnoremap <silent> <C-u> <C-u>zz
"}}}

"{{{ quickfix
"===
  nmap <F2> :copen<CR>
  nmap <F4> :cclose<CR>
  nnoremap <C-n> :cn<CR>
  nnoremap <C-p> :cp<CR>
"}}}

" tag completion {{{
   inoremap <c-x> <c-]> <c-]>
" }}}


" {{{ more match chars
set matchpairs+=<:>
" }}}
"

"
" solarized colorscheme {{{
"NeoBundleLazy 'altercation/vim-colors-solarized', {'autoload':{'insert':1}}
if has('gui_running')
   set background=dark
   colorscheme solarized
   " colorscheme jellybeans
else
   colorscheme torte
endif
" }}}
   

" {===========================================================================
" plugin for linux

if s:is_windows != 1
  " echom prints mesg on a console for linux and shows a diaglog for windows
  echom '+linux'

  " Required! why? if not, using ohter plugins do not work properly
  filetype plugin indent on


  " Installing plugins
  " With vim-plug, you declare the list of plugins you want to use in your Vim
  " configuration file. It's ~/.vimrc for ordinary Vim, and
  " ~/.local/share/nvim/site/autoload/plug.vim for Neovim. The list should start
  " with call plug#begin(PLUGIN_DIRECTORY) and end with call plug#end().
  "
  " Plugins will be downloaded under the specified directory.
  call plug#begin('~/.vim/plugged') 

  " Declare the list of plugins.
  
  " {{{
  " "plugin-indent-guide"
  "
  " note: this is slow so plan not to use it
  " https://github.com/Yggdroot/indentLine
  " NeoBundle 'Yggdroot/indentLine'
  
  " https://github.com/nathanaelkane/vim-indent-guides
  " :help indent-guides
  Plug 'nathanaelkane/vim-indent-guides'
  " }}}

  " {{{
  " "plugin-fzf"
  " PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run the install script if you use fzf only in Vim.
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " vim-plug: :PlugUpdate fzf
  " }}}

  " List ends here. Plugins become visible to Vim after this call.
  call plug#end()

  " After adding the above to the top of your Vim configuration file, reload it
  " (:source ~/.vimrc) or restart Vim. Now run :PlugInstall to install the
  " plugins.

  " Updating plugins
  " Run :PlugUpdate to update the plugins. After the update is finished, you can
  " review the changes by pressing D in the window. Or you can do it later by
  " running :PlugDiff.
  " 
  " Reviewing the changes 
  " Updated plugins may have new bugs and no longer work correctly. With
  " :PlugDiff command you can review the changes from the last :PlugUpdate and
  " roll each plugin back to the previous state before the update by pressing X
  " on each paragraph.
  " 
  " Removing plugins 
  " Delete or comment out Plug commands for the plugins you want to remove.
  " Reload vimrc (:source ~/.vimrc) or restart Vim Run :PlugClean. It will
  " detect and remove undeclared plugins.
  
  " Use this option to customize the size of the indent guide.
  let g:indent_guides_guide_size = 1
  
  " Use this option to control which indent level to start showing guides from.
  let g:indent_guides_start_level = 2
  
  " to define custom colors instead of using the ones the plugin automatically
  " generates for you let g:indent_guides_auto_colors = 0
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
  "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
  
  " Mapping :nmap <silent> <Leader>ig <NeoBundle>IndentGuidesToggle }}}
  
  " This is the default extra key bindings
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  
  " An action can be a reference to a function that processes selected lines
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

endif
