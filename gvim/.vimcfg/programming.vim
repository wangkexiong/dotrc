" Author: wangkexiong
" License: MIT License.
"
" Configuration for happy programming

" => Source code handling ------------------------------------------------- {{{
" Trailing white space on save
autocmd BufWrite *.coffee  :call DeleteTrailingWS()
"
" }}}

" => Build make program --------------------------------------------------- {{{
" Before using, make sure the compiler are in the PATH
"
autocmd BufRead *.dot  :compiler dot
autocmd BufRead *.erl  :compiler erlang
"
" }}}

" => Python --------------------------------------------------------------- {{{
"
autocmd BufNewFile,BufRead *.jinja  set syntax=htmljinja
autocmd BufNewFile,BufRead *.mako   set ft=mako
"
" }}}

" => JavaScript section --------------------------------------------------- {{{
"
autocmd FileType javascript  setl nocindent
autocmd FileType javascript  call JavaScriptFold()

function! JavaScriptFold()
    try
        setlocal foldmethod=syntax
        setlocal foldlevelstart=1
        syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
    catch
    endtry
endfunction
"
" }}}

" => CoffeeScript section ------------------------------------------------- {{{
"
"autocmd FileType coffee  call CoffeeScriptFold()

function! CoffeeScriptFold()
    try
        setl foldmethod=indent
        setl foldlevelstart=1
    catch
    endtry
endfunction
"
" }}}

" => Groovy section ------------------------------------------------------- {{{
"
autocmd BufNewFile,BufRead *.gradle  set ft=groovy
"
" }}}

" vim: set foldlevelstart=0 foldmethod=marker foldmarker={{{,}}}: "
