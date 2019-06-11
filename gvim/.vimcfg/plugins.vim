" Extensions are managed by vundle
" If you want to customize the plugin configuration
" Be sure to surround with try block.
"
" Tips:
"   If author owns his own github, use it, otherwise:
"       By default will check https://www.github.com/vim-scripts/ for bundles,
"       you may use "AddBundle('vimwiki')" to install it.
"
"       Vundle supports personal github for plugins,
"       you may use "AddBundle('aklt/plantuml-syntax')" to install it.
" Section:
"
" => Text Thinking -------------------------------------------------------- {{{
" Working with wiki
call AddBundle(['vimwiki', 'msanders/snipmate.vim', 'vimgtd--nianyang'])
try
    " To avoid tab mapping conflict with snipmate
    let g:vimwiki_table_mappings=0
    let g:vimwiki_camel_case=0
    let g:vimwiki_hl_cb_checked=1
    let g:vimwiki_CJK_length=1
    let g:vimwiki_folding=1
    let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'

    let wikipath=$WORK.'/vimwiki/'
    let wikifile={}
    let wikifile.path=wikipath
    let wikifile.path_html=wikipath.'/html/'
    let g:vimwiki_list=[wikifile]
catch
endtry

" Support plantUML syntax
call AddBundle('aklt/plantuml-syntax')

" Working with Octopress
call AddBundle(['glidenote/octoeditor.vim', 'tangledhelix/vim-octopress'])
try
    let g:octopress_path=$WORK.'/octopress/'

    let g:octopress_template_dir_path=$WORK.'/octopress/template'
    let g:octopress_published=0

    if !isdirectory(g:octopress_path.'source/_posts')
        call mkdir(g:octopress_path.'source/_posts', "p")
    endif

    let g:octopress_post_suffix="md"
    autocmd BufNewFile,BufRead *.markdown,*.textile,*.md  set filetype=octopress
catch
endtry
"
" }}}

" => Programming ---------------------------------------------------------- {{{
" Show tags for easy jumpping
call AddBundle('taglist.vim')
try
    let Tlist_Process_File_Always=1
    let Tlist_Show_One_File=1
    let Tlist_Use_Right_Window=1
    let Tlist_Exit_OnlyWindow=1
catch
endtry

" Provides support for expanding abbreviations similar to emmet.
call AddBundle('mattn/emmet-vim')
try
    let g:user_emmet_install_global=0
    autocmd FileType html,css  EmmetInstall
catch
endtry

" vim 7.2+, it will detect if a html file is a jinja template.
call AddBundle('lepture/vim-jinja')

" Code beautify
call AddBundle('JavaScript-Indent')
try
    let g:js_indent_log=0               " Disable Log
catch
endtry

" Lining up the elements on neighbouring lines
call AddBundle('godlygeek/tabular')

" Coffee-Script programming support: syntax, indenting, compiling
call AddBundle('kchmck/vim-coffee-script')
try
    autocmd BufNewFile,BufRead *.coffee  set ft=coffee
    autocmd BufNewFile,BufReadPost *.coffee  set foldmethod=indent
catch
endtry

" Front for the jshint NodeJS module
call AddBundle('walm/jshint.vim')       " Required: npm install jshint -g

" Helps you to create python code very quickly by utilizing libraries
" including pylint, rope, pydoc, pyflakes, pep8, and mccabe for features
" like static analysis, refactoring, folding, completion, documentation, and more.
call AddBundle('klen/python-mode')      " Requires +python compiled
try
    "let g:pymode_rope=1
    "let g:pymode_rope_complete_on_dot=1
    "let g:pymode_rope_completion_bind='<C-j>'
catch
endtry

" With generated dictionary, qucik prompt for the autocomplete.
call AddBundle('Pydiction')   " No +python complied needed
try
    "Generate dict using `python pydiction.py flask -f ../../dict/pythonlib`
    let g:pydiction_location=$WORK.'/dict/pythonlib'
catch
endtry

" Erlang support: (Forked but with more features)
" - Syntax highlighting
" - Code indenting
" - Code folding
" - Code omni completion
" - Syntax checking with quickfix support
" - Code skeletons for the OTP behaviours
" - Uses configuration from Rebar
call AddBundle('jimenezrick/vimerl')
try
    let erlang_folding=1
    autocmd BufNewFile,BufReadPost *.erl  set foldtext=DisplayFoldText()
catch
endtry
"
" }}}

" => Utility -------------------------------------------------------------- {{{
" Pending tasks list
call AddBundle('TaskList.vim')

" Project files management
call AddBundle('vimplugin/project.vim')
try
    let g:proj_flags="imstv"
catch
endtry

" NerdTree
call AddBundle('scrooloose/nerdtree')

" NerdComment
call AddBundle('scrooloose/nerdcommenter')

" Indexer tags in Project
call AddBundle(['DfrankUtil', 'vimprj', 'indexer.tar.gz'])
try
    let g:indexer_disableCtagsWarning=1
catch
endtry
"
" }}}

" => Better Looking ------------------------------------------------------- {{{
" molokai scheme cloned from textmate
call AddBundle('tomasr/molokai')
try
    colorscheme molokai
catch
endtry

" Display sign for marks
call AddBundle('ShowMarks')
try
    " mark z is not used
    " since easy move and tailing whitespace functions will use this mark
    let showmarks_include='abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ'
    let showmarks_textlower="'\t"       " Display marks as its usage like 'a
endtry

" Vim-Powerline
call AddBundle(['bling/vim-airline', 'tpope/vim-fugitive', 'airblade/vim-gitgutter', 'majutsushi/tagbar'])
try
    let g:airline#extensions#tabline#enabled=1
    let g:airline_powerline_fonts=1

    let g:gitgutter_avoid_cmd_prompt_on_windows=0

    if !$COLORFULTERM " {{{-------------There is no 256 colors support, remove powerline from loading
        let paths=[resolve(g:bundle_dir).'/vim-airline']
        let prepends=join(paths, ',')
        let appends=join(paths, '/after,').'/after'
        exec 'set rtp-='.fnameescape(expand(prepends, 1))
        exec 'set rtp-='.fnameescape(expand(appends, 1))
    endif " }}}
catch
endtry
"
" }}}

" vim: set foldlevelstart=0 foldmethod=marker foldmarker={{{,}}}: "
