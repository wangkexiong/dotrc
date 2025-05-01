" Author: wangkexiong
" License: MIT License.
" Description: This is the Vundle <https://github.com/gmarik/vundle> wrapper.
"              Using AddBundle function to subscript plugins.
"              If new Bundle added, it will be installed next time VIM runs.
"
" As Vundle required, it should be executed at the very beginning during VIM initialization.

" => Get Vundle Manager working ------------------------------------------ {{{
"
let s:bundledir=$WORK.'/bundle'         " Directory settings
let s:vundledir=s:bundledir.'/vundle'
if !isdirectory(s:vundledir)
    call mkdir(s:vundledir, "p")
endif

let s:HasVundle=1                       " Assume vundle already installed
let s:bundle_install=[]

let vundle_readme=expand(s:vundledir.'/README.md')
if !filereadable(vundle_readme)         " {{{---Check Vundle if already installed
    try
        sil exe '!git clone https://github.com/gmarik/vundle "'.s:vundledir.'"'
        " Git operation ERROR, skip Bundle operation
        if v:shell_error != 0
            let s:HasVundle=0
        endif
    catch
        let s:HasVundle=0
    endtry
endif " }}}

filetype off                            " Required
exe 'set rtp+='.fnameescape(s:vundledir)

if s:HasVundle
    call vundle#begin(s:bundledir)      " Required
    autocmd VimEnter *  call InstallNewBundle()
    call vundle#end()                   " Required
endif
"
" }}}

" => Subscription Bundle helper interface -------------------------------- {{{
"
func! AddBundle(bundles) " {{{----------Add bundles under vundle management
    if s:HasVundle
        if type(a:bundles) == type([])
            for l:each in a:bundles
                call s:SubBundle(l:each)
            endfor
        elseif type(a:bundles) == type('string')
            call s:SubBundle(a:bundles)
        endif
    endif
endfunc

func! s:SubBundle(subitem)
    if s:CheckNewBundle(a:subitem)
        call add(s:bundle_install, a:subitem)
    endif
    Bundle a:subitem
endfunc

func! s:CheckNewBundle(subitem)
    " TODO may there be another more efficient way to check?
    let l:dir=vundle#config#init_bundle(a:subitem, '')['rtpath']
    let l:readme=glob(l:dir.'/[rR][eE][aA][dD][mM][eE]*')
    let l:doc=glob(l:dir.'/doc')
    return len(l:readme) ? 0 : (len(l:doc) ? 0 : 1)
endfunc " }}}

func! InstallNewBundle() " {{{----------Installed not already cloned bundles
    if len(s:bundle_install)
        let s:bundle_install=[]
        :PluginInstall
    endif
endfunc " }}}
"
" }}}

" vim: set foldlevelstart=0 foldmethod=marker foldmarker={{{,}}}: "
