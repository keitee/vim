" Vim filetype plugin file
" Language:	c
" Maintainer:	
" Last Change:	2016 June 28

" current
" note: not sure since it do not work for me.
" NeoBundle 'tyru/current-func-info.vim'
" nnoremap <C-g>f :echo cfi#format("%s", "")<CR>

" pulgin-commentary
" https://github.com/tpope/vim-commentary/issues/30
" to use '//' instead of '/* */'
"
" You can have // by default if you 
" setlocal commentstring=//\ %s in after/ftplugin/c.vim. 
" There is no support for a multiline mode.

setlocal commentstring=//\ %s
