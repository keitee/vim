" Vim filetype plugin file
" Language:	nds log
" Maintainer:	
" Last Change:	2016 June 28

" Only do this when not done yet for this buffer
" if exists("b:did_ftplugin")
"   finish
" endif

" au BufNewFile,BufRead *.nds setf nds
au BufNewFile,BufRead *.nds set filetype=nds

" NDS:                      " ndsFieldHeader
" ^[2016:06:10 15:52:53] 
" 0946701324.837014         " ndsFieldTime
" !MIL    -EPG_TVG      	
"                           " ndsFieldTab
" < p:0x00000196            " ndsFieldProcess
"   P:APP                   " ndsFieldProcessName
"   t:0x2df56520            " ndsFieldThread
"   T:no name               " ndsFieldThreadName 
"
" M:ProgrammesRetriever F:createProgrammesList L:326 >
" T:PooledExecutor#4:Guide Programme 7 Title: The Big \
"   Bang Theory Start Time \
"   [2016:06:10 23:10:00]1465600200 Duration 1800
" 
syn match ndsFieldHeader '^[0-9:]*NDS: ' conceal
syn match ndsFieldTime '[0-9]\{10\}.[0-9]\{6\}' conceal
syn match ndsFieldTab '\t\{1,\}' conceal
" syn match ndsFieldSpace '\s\{1,\}' conceal
syn match ndsFieldProcess '\<p:0x\w\+\>' conceal
syn match ndsFieldProcessName '\<P:\w\+\>' conceal
syn match ndsFieldThread '\<t:0x\w\+\>' conceal
syn match ndsFieldThreadName '\<T:\w\+\>' conceal

set concealcursor=nc
set conceallevel=3

set nostartofline
set virtualedit=

