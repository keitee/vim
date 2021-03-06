﻿" detect OS {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
"}}}

"  please check your Vim supports signs by running 
"  :echo has('signs')
"  1 means you're all set; 0 means you need to install a Vim with signs
"  support. 

if has("gui_running")
  if has("gui_gtk3")
    " set guifont=FreeMono\ 12    " for ubuntu
    " set guifont=DroidSansMono   " for debian
    set guifont=Hack\ 10              " for debian
    " set guifont=D2Coding              " for debian
  endif
endif


" for neobundle {{{
if has('vim_starting')
   set nocompatible               " Be iMproved
   if s:is_windows
      set runtimepath+=$VIM/vimfiles/bundle/neobundle.vim/
   else
      set runtimepath+=~/.vim/bundle/neobundle.vim/
   endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
"}}}


"{{{ edit
"===
   " clipboard
   set clipboard=unnamed
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
"}}}


"{{{ search
"===
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


"{{{ indent, custom tab and eof char
"===
   set smartindent
   set shiftwidth=2 
   set tabstop=2 
   set softtabstop=2
   set expandtab
   set textwidth=80
   set colorcolumn=80
   
   scriptencoding utf-8
   set encoding=utf-8
   set listchars=tab:»\ ,eol:¬
   "set showbreak=«\ 
   set showbreak=<< 

   " note: this is slow so plan not to use it
   " https://github.com/Yggdroot/indentLine
   " NeoBundle 'Yggdroot/indentLine'

   " https://github.com/nathanaelkane/vim-indent-guides
   " :help indent-guides
   NeoBundle 'nathanaelkane/vim-indent-guides'
  
   " Use this option to customize the size of the indent guide.
   let g:indent_guides_guide_size = 1
   
   " Use this option to control which indent level to start showing guides from.
   let g:indent_guides_start_level = 2
   
   " to define custom colors instead of using the ones the plugin automatically
   " generates for you
   " let g:indent_guides_auto_colors = 0
   "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
   "autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
   
   " Mapping :nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
"}}}


"{{{ spell
"===
   set spelllang=en_gb
   set spellfile=~/.vim/spell/en.utf-8.add 
   
   " utility mappings {{{
   " to wrap a word with ' or " current time
   map <F5> i'<Esc>ea'<Esc>
   map <F6> i"<Esc>ea"<Esc>
"}}}


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
   
"
" plugin groups {{{
"
let s:settings = {}
let s:settings.plugin_groups = []

"{{{ linux
if s:is_windows != 1
  " echom prints mesg on a console for linux and shows a diaglog for windows
  echom '+linux'

  " Required! why? if not, using ohter plugins do not work properly
  filetype plugin indent on

  " "pulgin-comment"
  "
  " commentary.vim
  "
  " Comment stuff out. Use gcc to comment out a line (takes a count), gc to
  " comment out the target of a motion (for example, gcap to comment out a
  " paragraph), gc in visual mode to comment out the selection, and gc in operator
  " pending mode to target a comment. You can also use it as a command, either
  " with a range like :7,17Commentary, or as part of a :global invocation like
  " with :g/TODO/Commentary. That's it.
  "
  " https://github.com/tpope/vim-commentary/issues/30
  " to use '//' instead of '/* */'
  "
  " You can have // by default if you 
  " setlocal commentstring=//\ %s in after/ftplugin/c.vim. 
  " There is no support for a multiline mode.
  NeoBundle 'tpope/vim-commentary'
  set commentstring=//\ %s

  " nerd commenter
  NeoBundle 'scrooloose/nerdcommenter'

  " plugin-vimproc
  NeoBundle 'Shougo/vimproc'

  set clipboard=unnamedplus

  " let s:settings.autocomplete_method = 'neocomplete'
  " let s:settings.autocomplete_method = 'ycm'

  call add(s:settings.plugin_groups, 'unite')
  call add(s:settings.plugin_groups, 'editing')

  " vim-airline
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'vim-airline/vim-airline-themes'
  " NeoBundle 'bling/vim-airline'
  
  " The default setting of 'laststatus' is for the statusline to not appear
  " until a split is created. If you want it to appear all the time, add the
  " following to your vimrc: set laststatus=2
  set laststatus=2
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep=' '
  let g:airline#extensions#tabline#left_alt_sep='¦'

  " Finally, you can add the convenience variable let g:airline_powerline_fonts
  " = 1 to your vimrc which will automatically populate the g:airline_symbols
  " dictionary with the powerline symbols.
  let g:airline_powerline_fonts = 1
  let g:airline_theme='dark'
  let g:airline_left_sep='>'
  " }}}
else 
  "{{{ windows
  " neobundle
  call neobundle#rc(expand('$VIM/vimfiles/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  filetype plugin indent on     " Required!

  let g:neobundle#types#git#default_protocol='git'

  let s:settings.autocomplete_method = ''
  call add(s:settings.plugin_groups, 'ctrlp')
  "}}}
endif
"}}}



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


  " CACHE: 
  "
  " Q: file_rec and file_rec/async cannot find all files.
  "
  " https://github.com/Shougo/unite.vim/issues/356
  " https://github.com/Shougo/unite.vim/issues/370
  " https://github.com/Shougo/unite.vim/issues/459

  " A: It is a feature.
  "
  " g:unite_source_rec_max_cache_files
  "   Specify the maximum number of files that `unite-source-file_rec` saves the
  "   caches. The default value is 20000.
  "
  " Also, the default max candidates are limited. You can customize it by
  "
  " |unite#custom#source()|
  "
  "   let g:unite_source_rec_max_cache_files = 0
  "   call unite#custom#source('file_rec,file_rec/async',
  "   \ 'max_candidates', 0)
  "
  " |unite#custom#source({source-name}, {option-name}, {value})|
  "
  "   max_candidates (Number)
  "   Changes the max candidates into {value}.  If {value} is 0, which means no
  "   limit.
  "
  " Also, you must clear previous cache in file_rec sources and wait until the
  " cache is completed.
  "
  " In a directory including large file, making the cache is slow. Thus, I don't
  " recommend it.
  "
  " To clear cache, you must execute |<Plug>(unite_redraw)| in unite buffer(in
  " default it is mapped to <C-l>).
  "
  " 
  " note: |unite-options-sync| may be useful. It blocks Vim until the cache is
  " completed.
  "
  " IGNORE:
  "
  " Q: file_rec/async source does not look .gitignore using ag.
  " https://github.com/Shougo/unite.vim/issues/398
  " 
  " A: It is a feature. file_rec/async does not ignore .gitignore files by
  " default.  You must change |g:unite_source_rec_async_command| value and
  " re-create cache by |<Plug>(unite_redraw)| mapping.

  let g:unite_source_rec_max_cache_files = 0
  call unite#custom#source('file_rec,file_rec/async','max_candidates',0)

  let g:unite_prompt='» '

  " :h g:unite_source_grep_command
  if executable('ag')
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_max_candidates=50000
    let g:unite_source_grep_command = 'ag'
    " " let g:unite_source_grep_default_opts =
    " "   \ '-U -i --vimgrep --hidden --ignore ' .
    " "   \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_default_opts =
       \ '-m 1000000 -U -S --vimgrep --hidden --ignore ' .
       \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    
    " let g:unite_source_grep_default_opts='-U --nocolor --nogroup -S'
    " note: DO NOT WORK due to C4 option
    " let g:unite_source_grep_default_opts='-U --vimgrep --nocolor --nogroup -S -C4'

    let g:unite_source_grep_recursive_opt = ''


    " Using ag as recursive command. *g:unite_source_rec_async_command*
    " Use -U to make sure it uses .agignore otherwise may get no result since it
    " uses .gitignore which it can find it in search directories.
    let g:unite_source_rec_async_command =
      \ ['ag', '-U', '--follow', '--nocolor', '--nogroup', '-g', '']
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

  " MAPPING:
  " note: vimproc and source with bang(!) Not for windows since no vimproc in windows
  " note: do not like -quick-match since need to press other keys to go to input mode.
  "
  " "open search"
  " let cwd=getcwd()
  nnoremap <silent> [unite]os :Unite file_list:/home/kyoupark/git/kb/si/flist.out -toggle -unique -buffer-name=files<cr>
  "nnoremap <silent> [unite]o :Unite -toggle -unique -buffer-name=files file file_rec/async:!<cr>
  "nnoremap <silent> [unite]oc :UniteWithCurrentDir -toggle -unique -buffer-name=files file_rec/async:!<cr>
  "nnoremap <silent> [unite]op :UniteWithProjectDir -toggle -unique -buffer-name=files file_rec/async:!<cr>
  nnoremap <silent> [unite]q :Unite -toggle -unique -buffer-name=quick buffer<cr>
  nnoremap <silent> [unite]r :Unite -toggle -unique -buffer-name=recent file_mru<cr>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=lines line<cr>

  " bookmarks open, add,
  nnoremap <silent> [unite]bo :<C-u>Unite -auto-resize -buffer-name=marks bookmark:_<cr>
  nnoremap <silent> [unite]ba :UniteBookmarkAdd<cr>

  nnoremap <silent> [unite]v :set list!<cr>
  nnoremap <silent> [unite]s :set spell!<cr>
  nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]n :set ft=nds<cr>
  nnoremap <silent> [unite]nn :set ft=<cr>
  " show date 
  nnoremap <silent> [unite]nd :syn clear ndsFieldDate<cr>

  " for "search" and see *unite-source-grep* 
  " can set a pattern but runs on all files under current working directory.
  nnoremap <silent> [unite]// :<C-u>Unite -buffer-name=search grep:.<cr>
  " set a pattern from the current cursor and runs on all files under current
  " working directory.
  nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search grep:.::<c-r><c-w><cr>

  nnoremap <silent> [unite]n :set ft=nds<cr>
  nnoremap <silent> [unite]nn :set ft=<cr>
  
  " tab
  nnoremap <silent> [unite]nt :tabnew<cr>
  nnoremap <silent> [unite]ct :tabclose<cr>

  " " *unite-gtags*
  " 
  " NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}}
  " nnoremap <silent> [unite]tt :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>

  " " note: prefer to use -no-split since otherwise, will be three windows; one
  " " for main, one for result, and one for preview.

  " " - tag definitions on `cword`
  " nnoremap <silent> [unite]td :Unite -auto-resize gtags/def<CR>
  " vnoremap <silent> [unite]tds <ESC>:Unite gtags/def:.GetVisualSelection()<CR>

  " " - tag references/definitions on `cword` 
  " nnoremap <silent> [unite]tc :Unite -auto-resize gtags/context<CR>
  " vnoremap <silent> [unite]tcs <ESC>:Unite gtags/context:.GetVisualSelection()<CR>

  " " - tag grep which shows input prompt for a pattern
  " nnoremap <silent> [unite]tg :Unite -auto-resize gtags/grep<CR>

  " " - tag list
  " " note: this may be too slow when tag db is huge.
  " " nnoremap <silent> [unite]to :Unite -auto-resize gtags/completion<CR>

  " " - tag file
  " nnoremap <silent> [unite]tf :Unite -auto-resize gtags/file<CR>

  " " - tag reference on `cword`
  " nnoremap <silent> [unite]tr :Unite -auto-resize gtags/ref<CR>
  " vnoremap <silent> [unite]trs <ESC>:Unite gtags/ref:.GetVisualSelection()<CR>

  " mapping-gtags
  " 
  " tag search. picks up the cword and shows a prompt for a pattern
  nnoremap <silent> [unite]tp :Gtags<CR>
  " tag cword. no prompt
  " nnoremap <silent> [unite]gc :Gtags <c-r><c-w><CR>
  nnoremap <silent> [unite]tc :GtagsCursor<CR>
  " tag reference
  nnoremap <silent> [unite]tr :Gtags -r <c-r><c-w><CR>
  " tag grep search
  nnoremap <silent> [unite]tg :Gtags -g <c-r><c-w><CR>
  " tag selection. do NOT work?
  " vnoremap <silent> [unite]gs <ESC>:Gtags .GetVisualSelection()<CR>

  " mapping-gtags-current-file
  "
  " Like ctrlptag. parses the current buffer's content and extracts headings from the buffer
  NeoBundle 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}}
  nnoremap <silent> [unite]to :<C-u>Unite -auto-resize -buffer-name=outline outline<CR>

  " note: outline is better since do not use hotfix windows and do not move to
  " the windows to search a tag
  " tag current file
  " nnoremap <silent> [unite]tf :Gtags -f %<CR>

  " for tagbar
  NeoBundle 'majutsushi/tagbar'
  nnoremap <silent> [unite]tb :TagbarToggle<cr>

  " nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  " nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -no-split -buffer-name=search grep:.<cr>
  " from quick-match, can get usual listing of directories so do not need separate command
  " nnoremap <silent> [unite]d :<C-u>Unite -quick-match directory<cr>
  "nnoremap <silent> [unite]t :<C-u>Unite -auto-preview -buffer-name=tag tag<cr>
  "nnoremap <silent> [unite]t :<C-u>Unite -buffer-name=tag tag<cr>
  "nnoremap <silent> [unite]c :CtrlPFunky<cr>
  "nnoremap <silent> [unite]g :CtrlPTag<cr>

  " *netrw*
  " for run a browser on link
  let g:netrw_browsex_viewer= "iceweasel"
  " tree list style
  let g:netrw_liststyle=3

  nnoremap <silent> [unite]e :Explore<CR>

  " *git* {{{
  " Limit line length of git commits to 72 cols
  au FileType gitcommit set tw=72
  
  " vim-fugitive
  " https://github.com/tpope/vim-fugitive
  NeoBundle 'tpope/vim-fugitive'
  
  " vim-gitgutter
  " https://github.com/airblade/vim-gitgutter
  NeoBundle 'airblade/vim-gitgutter'

  " to turn off vim-gitgutter by default
  let g:gitgutter_enabled = 0
  nnoremap <silent> [unite]gg :GitGutterToggle<CR>

  " note: this emits an error saying that GitGutterAddLine is not recognized?
  " GitGutterAddLine          " default: links to DiffAdd
  " GitGutterChangeLine       " default: links to DiffChange
  " GitGutterDeleteLine       " default: links to DiffDelete
  " GitGutterChangeDeleteLine " default: links to GitGutterChangeLineDefault, i.e. DiffChange
  "}}}

  " for "copying filename"
  nnoremap <silent> [unite]f :let @+ = expand("%")<CR>

  "
  NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}}
  " nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
  "
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
" if s:settings.autocomplete_method == 'neocomplete' 

"   " if has('lua')
"   "    echom '+neocomplete'
"   " endif

"   " " NeoBundleLazy 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7'} 
"   " NeoBundle 'Shougo/neocomplete.vim', {'autoload':{'insert':1}, 'vim_version':'7'} 
"   " let g:neocomplete#enable_at_startup=1
"   " let g:neocomplete#data_directory='~/.vim/.cache/neocomplete'
"   " " }}}
  
"   " "" neosnippet {{{
"   " "" .vim/bundle/neosnippet.vim/autoload/neosnippet/snippets
"   " "NeoBundle 'Shougo/neosnippet.vim' 

"   " "" If you want to use a different collection of snippets than the built-in ones, 
"   " "" then you can set a path to the snippets with the g:neosnippet#snippets_directory variable (e.g Honza's Snippets)
"   " "" See .vim/bundle/vim-snippets/snippets/cpp.snippets for cpp example.
"   " "NeoBundle 'honza/vim-snippets'

"   " "" Tell Neosnippet about the other snippets
"   " "let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
"   " "" Enable snipMate compatibility feature.
"   " "let g:neosnippet#enable_snipmate_compatibility=1
"   " "" Use C-n and C-p to select it in the popup
"   " "imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
"   " "smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"   " "" use shift-tab to lotate snippets as C-p
"   " "imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
"   " "smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
"   " "" }}}
  
"   " " delimate {{{
"   " " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
"   " " NeoBundle 'Raimondi/delimitMate' 
"   " " }}}
" " " }}}
" elseif s:settings.autocomplete_method == 'ycm' 
" "
" " youcompleteme/ultisnips {{{
" "
"   echom '+ycm'

"   " NeoBundle 'Valloric/YouCompleteMe', {'vim_version':'7.3.584'} 
"   NeoBundle 'Valloric/YouCompleteMe'
"   let g:ycm_complete_in_comments_and_strings=1
"   "let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
"   "let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
"   let g:ycm_filetype_blacklist={'unite': 1}

"   " NeoBundle 'SirVer/ultisnips' 
"   " let g:UltiSnipsExpandTrigger="<tab>"
"   " let g:UltiSnipsJumpForwardTrigger="<tab>"
"   " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"   " let g:UltiSnipsSnippetsDir='~/.vim/snippets'
" " " }}}
" endif 

" " " 
" " " syntastic: syntax checking for a variaty of language {{{
" " " https://github.com/vim-syntastic/syntastic
" " "
" NeoBundle 'scrooloose/syntastic' 
"   let g:syntastic_error_symbol = '?'
"   let g:syntastic_style_error_symbol = '?'
"   let g:syntastic_warning_symbol = '?'
"   let g:syntastic_style_warning_symbol = '$'
" " " }}}

" vim-cpp-modern: Enhanced C and C++ syntax highlighting {{{
" https://github.com/bfrg/vim-cpp-modern

NeoBundle 'bfrg/vim-cpp-modern' 
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


"" {{{ ctrlp for windows
"" 
"" Press <c-f> and <c-b> to cycle between modes.
"" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
"" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new ver/hor split.
"" 
"" help ctrlp-commands
""
"if count(s:settings.plugin_groups, 'ctrlp') "{{{
"  echom '+ctrlp'
"  NeoBundle 'kien/ctrlp.vim', { 'depends': 'tacahiroy/ctrlp-funky' } 
"  let g:ctrlp_clear_cache_on_exit=1
"  let g:ctrlp_max_height=40
"  let g:ctrlp_show_hidden=0
"  let g:ctrlp_follow_symlinks=1
"  let g:ctrlp_working_path_mode=0
"  let g:ctrlp_max_files=20000
"  "let g:ctrlp_cache_dir='~/.vim/.cache/ctrlp'
"  let g:ctrlp_reuse_window='startify'
"  let g:ctrlp_extensions=['funky']
"
"  nnoremap [ctrlp] <nop>
"  nmap <space> [ctrlp]
"
"  "mappings
"  "    <space><space>  go to anything (files, buffers, MRU, bookmarks)
"  "    <space>f        select from files
"  "    <space>b        select from current buffers
"  "    <space>m        select mru
"  "    <space>d        select dirs
"  "    <space>t        select tags
"  "    <space>c        select function
"  nnoremap [ctrlp]f :CtrlP<cr>
"  nnoremap [ctrlp]b :CtrlPBuffer<cr>
"  nnoremap [ctrlp]m :CtrlPMRU<cr>
"  nnoremap [ctrlp]d :CtrlPDir<cr>
"  nnoremap [ctrlp]t :CtrlPTag<cr>
"  nnoremap [ctrlp]c :CtrlPFunky<cr>
"endif "}}}


" {{{
" installation check.
NeoBundleCheck
" }}}
