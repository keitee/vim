" detect OS {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
"}}}

if has("gui_running")
  if has("gui_gtk2")
    " set guifont=FreeMono\ 12    " for ubuntu
    " set guifont=DroidSansMono   " for debian
    set guifont=Hack              " for debian
  endif
endif

" for run a browser on link
:let g:netrw_browsex_viewer= "iceweasel"

"
" clipboard
set clipboard=unnamed

" for user syntax
syntax enable

" for showmatch
set showmatch

set incsearch

" set ignorecase
" for line number. set number
set nu


" for editing {{{
set autoindent
set cindent
"}}}

" for git {{{
" Limit line length of git commits to 72 cols
au FileType gitcommit set tw=72
"}}}

" show autocomplete menus
set wildmenu

" show editing mode
set showmode

" help: auto-format
" set formatoptions+=a

set cursorline

set autoread
set hlsearch
set nowrapscan

set foldenable

" for line wrapping and linebreak
set wrap linebreak nolist

" {{{ indent, custom tab and eof char
set smartindent

" sw(shiftwidth), ts(tabstop), sts(softtabstop), et(expandtab), tw(textwidth) 
set sw=2 
set ts=2 
set sts=2
set et 
set tw=80
set colorcolumn=80      " for color column

scriptencoding utf-8
set encoding=utf-8
set listchars=tab:»\ ,eol:¬
"set showbreak=«\ 
set showbreak=<< 
" }}}

" for spell
set spelllang=en_gb

set spelllang=en_gb
set spellfile=~/.vim/spell/en.utf-8.add 

" utility mappings {{{
  " to wrap a word with ' or " current time
  map <F5> i'<Esc>ea'<Esc>
  map <F6> i"<Esc>ea"<Esc>
" }}}

" search for selection {{{
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
" }}}

"
" auto center {{{
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

" qfix {{{
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

" Neobundle {{{
if has('vim_starting')
   set nocompatible               " Be iMproved
   if s:is_windows
      set runtimepath+=$VIM/vimfiles/bundle/neobundle.vim/
   else
      set runtimepath+=~/.vim/bundle/neobundle.vim/
   endif
endif
" }}}

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
   
"
" plugin groups {{{
"
let s:settings = {}
let s:settings.plugin_groups = []

if s:is_windows != 1
  " linux {{{
  " echom prints mesg on a console for linux and shows a diaglog for windows
  echom '+linux'

  " neobundle
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()

  " Required! why? if not, using ohter plugins do not work properly
  filetype plugin indent on

  " current
  NeoBundle 'tyru/current-func-info.vim'
  nnoremap <C-g>f :echo cfi#format("%s", "")<CR>

  " vimproc
  NeoBundle 'Shougo/vimproc'

  set clipboard=unnamedplus
  let s:settings.autocomplete_method = 'neocomplete'
  "let s:settings.autocomplete_method = 'ycm'
  call add(s:settings.plugin_groups, 'unite')
  call add(s:settings.plugin_groups, 'editing')

  " vim-airline
  NeoBundle 'bling/vim-airline'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'
  let g:airline_theme='serene'
  let g:airline_left_sep='>'
  " }}}
else 
  " windows {{{
  " neobundle
  call neobundle#rc(expand('$VIM/vimfiles/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  filetype plugin indent on     " Required!

  let g:neobundle#types#git#default_protocol='git'

  let s:settings.autocomplete_method = ''
  call add(s:settings.plugin_groups, 'ctrlp')
  " }}}
endif
" }}}


"" {{{ indent-guides
""
"" https://github.com/nathanaelkane/vim-indent-guides
""
"" :help indent-guides
""
"NeoBundle 'nathanaelkane/vim-indent-guides'
"
"" Use this option to customize the size of the indent guide.
"let g:indent_guides_guide_size = 1
"
"" Use this option to control which indent level to start showing guides from.
"let g:indent_guides_start_level = 2
"
"" to define custom colors instead of using the ones the plugin automatically generates for you
""let g:indent_guides_auto_colors = 0
""autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
""autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"
"" Mapping
"" :nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
"
"" }}}


" {{{ indent-line
"
" https://github.com/Yggdroot/indentLine
"
" NeoBundle 'Yggdroot/indentLine'
" }}}


"
" unite {{{
"
" :Unite [{options}] {sources} 
" 
" :h unite-options
"   -buffer-name={buffer-name} 
"     Specify a buffer name. The default buffer name is 'default'.
"
"   -default-action={default-action} 
"     Specify a default action.  The default value is 'default'.
"     -default-action=tabopen
"
"   -no-quit Doesn't close unite buffer after firing an action. Unless you
"   specify it, a unite buffer gets closed when you selected an action which is
"   "is_quit".
"
"   -auto-preview When you selected a candidate, it runs "preview" action
"   automatically.
"
"   -auto-highlight When you selected a candidate, it runs "highlight" action
"   automatically.
"
"   -auto-resize Auto resize unite buffer height by candidates number. However,
"   when use -no-split then no effect.
"
"   Note: from -prompt-direction="top" or "below" If it is "below",
"   |unite-options-auto-resize| is used automatically. To disable it, you must
"   set "-no-auto-resize" option.
"
"   -toggle Close unite buffer window if one of the same buffer name exists.
"
" This works as well for normal vi so can use it in console.

if count(s:settings.plugin_groups, 'unite') "{{{

  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'hewes/unite-gtags'

  " gtags
  " specify your project path as key. '_' in key means default configuration.
  let g:unite_source_gtags_project_config = {
  \ '_':                   { 'treelize': 1 }
  \ }
  let g:uniteSource__Gtags_Path='File'

  " let g:unite_source_gtags_project_config = {
  " \ 'gtags_libpath': ['/home/kpark/gtags-target/']
  " \ }

  " neobundle#get({bundle-name})                         *neobundle#get()*
  " Get the neobundle options dictionary for {bundle-name}. Useful for setting hooks.

  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)

    " The popular recursive file search, using fuzzy file matching:
    call unite#filters#matcher_default#use(['matcher_fuzzy'])

    " Changes the default sorter used by |unite-filter-sorter_default| into
    " {sorters}.  sorter_rank. Matched rank order sorter. The higher the matched
    " word is or the longer the matched length is, the higher the rank is.  This
    " sorter is useful for file candidate source.  Note: This sorter is slow.

    call unite#filters#sorter_default#use(['sorter_rank'])

    " ?
    " call unite#set_profile('files', 'smartcase', 1)


    " unite#custom#source({source-name}, {option-name}, {value})
    "
    " Set {source-name} source specialized {option-name} to {value}.  You may
    " specify multiple sources with separating "," in {source-name}.

    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
  endfunction

  " "unite-configs"
  "
  " cache directory. use absolute path.
  if s:is_windows != 1
     let g:unite_data_directory='~/.cache/unite'
  endif

  " If defined and not 0, unite enables |unite-source-history/yank|. Note: This
  " value has to be set in .vimrc. This variable is not defined by default.

  let g:unite_source_history_yank_enable=1

    " option: direction {*topleft, below, botright}
    "
    " To use full width unite window even when use vsplits. 
    "    'direction': 'botright',
    
    call unite#custom#profile('default', 'context', {
      \ 'direction': 'botright',
      \ 'start_insert' : 1,
      \ 'smartcase' : 1,
      \ 'auto_resize' : 1,
      \ 'prompt' : '>> '
      \ })

    " When use file_mru and file_rec both, file_rec shows relative path but mur
    " shows absolute path.  Is there any way to make them use the same way?

    call unite#custom#source('file, file_mru', 'converters', 'converter_relative_word')

  " Note: direction and -no-split option
  " when direction == below and not -no-split, then unite input buffer shrinks
  " downwards when types chars to narrow down.
  "
  " when direction == below and -no-split, then unite input buffer shrinks
  " upwards when types chars to narrow down.
  "
  " Therefore, use top when use both no-split and no no-split, since no-split
  " goes upwards.


  " "cache-size"
  " Q. file_rec and file_rec/async cannot find all files.
  " Specify the maximum number of files that |unite-source-file_rec| saves the
  " caches. The default value is 2000.
  "
  " https://github.com/Shougo/unite.vim/issues/356
  " https://github.com/Shougo/unite.vim/issues/370
  "
  " A. It is feature. cf: |g:unite_source_rec_max_cache_files|. And the default
  " max candidates are limited. You can custom it by
  "
  " And you must clear previous cache in file_rec sources. To clear cache, you
  " must execute |<Plug>(unite_redraw)| in unite buffer(in default it is mapped
  " to <C-l>).

  let g:unite_source_rec_max_cache_files = 0
  call unite#custom#source('file_rec,file_rec/async','max_candidates',20000)

  let g:unite_prompt='» '

  " :h g:unite_source_grep_command
  if executable('ag')
    let g:unite_source_grep_max_candidates=5000
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
  endif

  " to change default key mappings. see unite-key-mappings
  " function! s:unite_settings()
  "   nmap <buffer> Q <plug>(unite_exit)
  "   nmap <buffer> <esc> <plug>(unite_exit)
  "   imap <buffer> <esc> <plug>(unite_exit)
  " endfunction
  " autocmd FileType unite call s:unite_settings()

  nnoremap [unite] <nop>
  nmap <space> [unite]

  " "unite-mappings"
  " Note: vimproc and source with bang(!) Not for windows since no vimproc in windows
  " Note: do not like -quick-match since need to press other keys to go to input mode.
  "
  " "o"one   uses 'u' but sometimes recognized as undo so uses 'o'(one) instead
  nnoremap <silent> [unite]o :Unite -toggle -unique -buffer-name=files file file_rec/async:!<cr>
  nnoremap <silent> [unite]oc :UniteWithCurrentDir -toggle -unique -buffer-name=files file_rec/async:!<cr>
  nnoremap <silent> [unite]op :UniteWithProjectDir -toggle -unique -buffer-name=files file_rec/async:!<cr>
  nnoremap <silent> [unite]q :Unite -toggle -unique -buffer-name=quick buffer<cr>
  nnoremap <silent> [unite]r :Unite -toggle -unique -buffer-name=recent file_mru<cr>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=lines line<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=marks bookmark:_<cr>
  nnoremap <silent> [unite]v :set list!<cr>
  nnoremap <silent> [unite]s :set spell!<cr>
  nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>

  " for "search" and see *unite-source-grep* 
  nnoremap <silent> [unite]// :<C-u>Unite -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search grep:.::<c-r><c-w><cr>

  " for "gtags"
  " Note: prefer to use -no-split since otherwise, will be three windows; one for main, one for
  " result, and one for preview.
  nnoremap <silent> [unite]td :Unite -auto-resize gtags/def<CR>
  nnoremap <silent> [unite]tc :Unite -auto-resize gtags/context<CR>

  " note: this seems to be so slow and causes vim to hang sometimes
  " nnoremap <silent> [unite]to :Unite -auto-resize gtags/completion<CR>
  nnoremap <silent> [unite]to :Gtags<CR>

  nnoremap <silent> [unite]tf :Unite -auto-resize gtags/file<CR>
  nnoremap <silent> [unite]tr :Unite -auto-resize gtags/ref<CR>
  nnoremap <silent> [unite]tg :Unite -auto-resize gtags/grep<CR>
  vnoremap <silent> [unite]ts <ESC>:Unite gtags/def:.GetVisualSelection()<CR>

  " for "copying filename"
  nnoremap <silent> [unite]f :let @+ = expand("%")<CR>

  " "t"ag
  " Like ctrlptag. parses the current buffer's content and extracts headings from the buffer
  NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
  nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>

  " to tag search the word on cursor. will use quickfix window
  " Q: why it causes an error saying no tag file?
  " map g<C-]> :GtagsCursor<CR>

  " nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  " nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -no-split -buffer-name=search grep:.<cr>
  " from quick-match, can get usual listing of directories so do not need separate command
  " nnoremap <silent> [unite]d :<C-u>Unite -quick-match directory<cr>
  "nnoremap <silent> [unite]t :<C-u>Unite -auto-preview -buffer-name=tag tag<cr>
  "nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=tag tag<cr>
  "nnoremap <silent> [unite]c :CtrlPFunky<cr>
  "nnoremap <silent> [unite]g :CtrlPTag<cr>

  " for tagbar
  " NeoBundle 'majutsushi/tagbar'
  " nnoremap <silent> [unite]tb :TagbarToggle<cr>

  "
  NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
  " nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
  "
  NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
  nnoremap <silent> [unite]tt :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
  "
  NeoBundleLazy 'Shougo/unite-help', {'autoload':{'unite_sources':'help'}}
  nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
endif "}}}

"
" neocomplete {{{
"
" suffix of complete candidates in popup menu declaration.
" (This will be good for user to know where candidate from and what it is.)
" 
"     file -> [F] {filename}
"     file/include -> [FI] {filename}
"     dictionary -> [D] {words}
"     member -> [M] member
"     buffer -> [B] {buffername}
"     syntax -> [S] {syntax-keyword}
"     include -> [I]
"     neosnippet -> [neosnip]
"     vim -> [vim] type
"     omni -> [O]
"     tag -> [T]
"     other sources -> [plugin-name-prefix]
"     
if s:settings.autocomplete_method == 'neocomplete' 

  if has('lua')
     echom '+neocomplete'
  endif

  " neocomplete {{{
  " NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7'} 
  NeoBundle 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7'} 
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'
  " }}}
  
  " neosnippet {{{
  " .vim/bundle/neosnippet.vim/autoload/neosnippet/snippets
  NeoBundle 'Shougo/neosnippet.vim' 

  " If you want to use a different collection of snippets than the built-in ones, 
  " then you can set a path to the snippets with the g:neosnippet#snippets_directory variable (e.g Honza's Snippets)
  " See .vim/bundle/vim-snippets/snippets/cpp.snippets for cpp example.
  NeoBundle 'honza/vim-snippets'

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility=1
  " Use C-n and C-p to select it in the popup
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  " use shift-tab to lotate snippets as C-p
  imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  " }}}
  
  " delimate {{{
  " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
  " NeoBundle 'Raimondi/delimitMate' 
  " }}}
" }}}
elseif s:settings.autocomplete_method == 'ycm' 
"
" youcompleteme/ultisnips {{{
"
  echom '+ycm'

  NeoBundle 'Valloric/YouCompleteMe', {'vim_version':'7.3.584'} 
  let g:ycm_complete_in_comments_and_strings=1
  "let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
  "let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
  let g:ycm_filetype_blacklist={'unite': 1}

  NeoBundle 'SirVer/ultisnips' 
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetsDir='~/.vim/snippets'
" }}}
endif 

" 
" syntastic: syntax checking for a variaty of language {{{
"
NeoBundle 'scrooloose/syntastic' 
  let g:syntastic_error_symbol = '?'
  let g:syntastic_style_error_symbol = '?'
  let g:syntastic_warning_symbol = '?'
  let g:syntastic_style_warning_symbol = '$'
" }}}


" 
" gtag-cscope
"
"if has('cscope')
"  set cscopetag cscopeverbose
"  
"  if has('quickfix')
"    set cscopequickfix=s+,c+,d+,i+,t+,e+
"  endif
"  
"  " for gtag
"  set csprg=gtags-cscope
"
"  cnoreabbrev csa cs add
"  cnoreabbrev csf cs find
"  cnoreabbrev csk cs kill
"  cnoreabbrev csr cs reset
"  cnoreabbrev css cs show
"  cnoreabbrev csh cs help
"  cnoreabbrev csc call setqflist([])
"  
"  map <c-up> :cp<CR>
"  map <c-down> :cn<CR>
"endif


"
" ctrlp {{{ for windows
" 
" Press <c-f> and <c-b> to cycle between modes.
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new ver/hor split.
" 
" help ctrlp-commands
"
if count(s:settings.plugin_groups, 'ctrlp') "{{{
  echom '+ctrlp'
  NeoBundle 'kien/ctrlp.vim', { 'depends': 'tacahiroy/ctrlp-funky' } 
  let g:ctrlp_clear_cache_on_exit=1
  let g:ctrlp_max_height=40
  let g:ctrlp_show_hidden=0
  let g:ctrlp_follow_symlinks=1
  let g:ctrlp_working_path_mode=0
  let g:ctrlp_max_files=20000
  "let g:ctrlp_cache_dir='~/.vim/.cache/ctrlp'
  let g:ctrlp_reuse_window='startify'
  let g:ctrlp_extensions=['funky']

  nnoremap [ctrlp] <nop>
  nmap <space> [ctrlp]

  "mappings
  "    <space><space>  go to anything (files, buffers, MRU, bookmarks)
  "    <space>f        select from files
  "    <space>b        select from current buffers
  "    <space>m        select mru
  "    <space>d        select dirs
  "    <space>t        select tags
  "    <space>c        select function
  nnoremap [ctrlp]f :CtrlP<cr>
  nnoremap [ctrlp]b :CtrlPBuffer<cr>
  nnoremap [ctrlp]m :CtrlPMRU<cr>
  nnoremap [ctrlp]d :CtrlPDir<cr>
  nnoremap [ctrlp]t :CtrlPTag<cr>
  nnoremap [ctrlp]c :CtrlPFunky<cr>
endif "}}}


" {{{
" installation check.
NeoBundleCheck
" }}}
