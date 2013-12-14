" detect OS {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
"}}}

"if has("gui_running")
"  if has("gui_gtk2")
"    set guifont=FreeMono\ 12
"  endif
"endif

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

"
" for editing {{{
set autoindent
set cindent
set smartindent
set shiftwidth=3
set tabstop=3
set expandtab
set tw=100
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

" utility mappings {{{
:map! <F3> a<C-R>=strftime('%c')<CR><Esc>
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
   call neobundle#rc(expand('~/.vim/bundle/'))
   NeoBundleFetch 'Shougo/neobundle.vim'
   filetype plugin indent on     " Required! why? if not, using ohter plugins do not work properly

   " vimproc
   NeoBundle 'Shougo/vimproc'

   set clipboard=unnamedplus
   let s:settings.autocomplete_method = 'neocomplete'
   "let s:settings.autocomplete_method = 'ycm'
   call add(s:settings.plugin_groups, 'unite')

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


"
" unite {{{
"
" :Unite [{options}] {sources}			*:Unite*
" 
" unite-options
"		-buffer-name={buffer-name} 
"     Specify a buffer name. The default buffer name is 'default'.
"
"		-default-action={default-action} 
"     Specify a default action.  The default value is 'default'.
"     -default-action=tabopen
"
"		-no-quit 
"     Doesn't close unite buffer after firing an action. Unless you specify it, a unite
"     buffer gets closed when you selected an action which is "is_quit".
"
"		-auto-preview
"		When you selected a candidate, it runs "preview" action automatically.
"
"		-auto-highlight
"		When you selected a candidate, it runs "highlight" action automatically.
"
"		-auto-resize
"		Auto resize unite buffer height by candidates number.  
"
"		-toggle
"		Close unite buffer window if one of the same buffer name exists.
"
if count(s:settings.plugin_groups, 'unite') "{{{
   NeoBundle 'Shougo/unite.vim' "{{{

   " neobundle#get({bundle-name})                         *neobundle#get()*
   " Get the neobundle options dictionary for {bundle-name}. Useful for setting hooks.

   let bundle = neobundle#get('unite.vim')
   function! bundle.hooks.on_source(bundle)

     " The popular recursive file search, using fuzzy file matching:
     call unite#filters#matcher_default#use(['matcher_fuzzy'])

     " Changes the default sorter used by |unite-filter-sorter_default| into {sorters}.
     " sorter_rank. Matched rank order sorter. The higher the matched word is or the longer the
     " matched length is, the higher the rank is.  This sorter is useful for file candidate source.
     " Note: This sorter is slow.
     call unite#filters#sorter_default#use(['sorter_rank'])

     " ?
     call unite#set_profile('files', 'smartcase', 1)

     " unite#custom#source({source-name}, {option-name}, {value})
     "                 Set {source-name} source specialized {option-name} to {value}.
     "                 You may specify multiple sources with separating "," in
     "                 {source-name}.
     call unite#custom#source('line,outline','matchers','matcher_fuzzy')
   endfunction

   if s:is_windows != 1
      " The Default value is expand('~/.unite'); the absolute path of it.
      let g:unite_data_directory='~/.vim/.cache/unite'
   endif

	" If this variable is 1, unite buffer will be in Insert Mode immediately. The default value is 0.
   let g:unite_enable_start_insert=1

   " If defined and not 0, unite enables |unite-source-history/yank|. Note: This value has to be
   " set in .vimrc.  This variable is not defined by default.
   let g:unite_source_history_yank_enable=1

   " Specify the maximum number of files that |unite-source-file_rec| saves the caches. The default
   " value is 2000.
   " let g:unite_source_rec_max_cache_files=5000
   "
   " Q: file_rec and file_rec/async cannot find all files.
   " https://github.com/Shougo/unite.vim/issues/356
   " https://github.com/Shougo/unite.vim/issues/370
   " 
   " A: It is feature. cf: |g:unite_source_rec_max_cache_files|.
   " And the default max candidates are limited. You can custom it by
   " |unite#custom#source()|. >
   "         let g:unite_source_rec_max_cache_files = 0
   "         call unite#custom#source('file_rec,file_rec/async',
   "         \ 'max_candidates', 0)
   " 
   " And you must clear previous cache in file_rec sources.
   " To clear cache, you must execute |<Plug>(unite_redraw)| in unite buffer(in default it is mapped to <C-l>).
   "
   call unite#custom#source('file_rec,file_rec/async','max_candidates',0)
   let g:unite_prompt='» '

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

   " Note: with large projects this may cause some performance problems. Normally it is recommended
   " to use |unite-source-file_rec/async| source, which requires |vimproc|. Do not use this for
   " windows.

   "mappings
   "    <space><space>  go to anything (files, buffers, MRU, bookmarks)
   "    <space>f        select from files
   "    <space>y        select from previous yanks
   "    <space>l        select line from current buffer. search in a current file
   "    <space>b        select from current buffers
   "    <space>/        recursively search all files for matching text (uses ag or ack if found)
   "    <space>s        recursively search for word under a cursor
   "    <space>m        show mappings
   "    <space>w        select tabs
   "    <space>d        select dirs
   "    <space>t        select tags
   "    <space>c        select function
   "    <space>tt       select tags
   "    <space>o        select outline(funtion)
   "    <space>h        select help

   if s:is_windows
     nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec buffer file_mru bookmark<cr><c-u>
     nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec<cr><c-u>
   else
     nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
     nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
   endif
   nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
   nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
   " nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
   nnoremap <silent> [unite]b :<C-u>Unite -quick-match buffer<cr>
   " nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -no-split -buffer-name=search grep:.<cr>
   nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
   " see *unite-source-grep* 
   nnoremap <silent> [unite]s :<C-u>Unite -no-quit -buffer-name=search grep:.::<c-r><c-w><cr>
   nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
   nnoremap <silent> [unite]w :<C-u>Unite -quick-match tab<cr>
   nnoremap <silent> [unite]d :<C-u>Unite -quick-match directory<cr>
   nnoremap <silent> [unite]t :<C-u>Unite -auto-preview -buffer-name=tag tag<cr>
   "nnoremap <silent> [unite]c :CtrlPFunky<cr>
   "nnoremap <silent> [unite]g :CtrlPTag<cr>

   NeoBundle 'majutsushi/tagbar'
   nnoremap <silent> [unite]tb :TagbarToggle<cr>

   "
   NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
   " nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
   "
   NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
   nnoremap <silent> [unite]tt :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
   " Like ctrlptag. parses the current buffer's content and extracts headings from the buffer
   NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
   nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
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
" gtag
"
if has('cscope')
  set cscopetag cscopeverbose
  
  if has('quickfix')
    set cscopequickfix=s+,c+,d+,i+,t+,e+
  endif
  
  " for gtag
  set csprg=gtags-cscope

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help
  cnoreabbrev csc call setqflist([])
  
  map <c-up> :cp<CR>
  map <c-down> :cn<CR>
endif


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
