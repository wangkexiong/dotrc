" The configuration is from web, the origination author information
" is below, I have changed something for my own working.
" I DO NOT guarantee it will also working for you. Using help tips will
" do you a lot of help. That's the way it works for me
"
" Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"   Another lazy way is place cursor under the word and press K (shift-k)
"
" Originator:
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Blog_post:
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version:
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
" => General ------------------------------------------------------------- {{{
"
set nocompatible

set shortmess=atIO                      " Set prompt messages

if has("multi_byte")                    " Set encoding in UTF-8
    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,latin1
    language messages en_US.utf-8
endif

set history=700                         " Set how many lines of history VIM has to remember
filetype plugin indent on               " Enable filetype plugins

set autoread                            " Set to auto read when a file is changed from the outside
let mapleader = ","                     " With a map leader it's possible to do extra key combinations
let g:mapleader = ","

set sessionoptions-=curdir              " SessionOptions Setup
set sessionoptions-=options
set sessionoptions+=sesdir

autocmd VimLeave *  call SaveSess('last.vim')
"autocmd VimEnter *  nested call RestoreSess('last.vim')
"
" }}}
" => Help file ----------------------------------------------------------- {{{
"
augroup ft_vim
    autocmd!

    autocmd FileType vim  setlocal foldmethod=marker
    autocmd BufWinEnter *.txt  if &ft == 'help' | wincmd L | vertical resize 80 | hi clear ExtraWhiteSpace | endif
augroup END
"
" }}}
" => Wile Menu - --------------------------------------------------------- {{{
"
set wildmenu
set wildmode=full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set wildignore+=classes                          " Clojure/Leiningen
set wildignore+=lib
"
" }}}
" => User Interface ------------------------------------------------------ {{{
"
set title                               " Set window title on
set nolist                              " Do not show unprintable chars by default
set listchars=eol:¬,tab:>-,trail:.      " Display sepcial charactor in list mode

if has("gui_running") " {{{-------------Set extra options when running in GUI mode
    set guioptions-=m                   "disable Menubar
    set guioptions-=T                   "disable QuickIcon Menu
    set guioptions-=r                   "disable scrollbar
    set guitablabel=%M\ %t
    set guicursor=a:block-blinkon0      "disable cursor blinking
endif " }}}

set so=7                                " Set 7 lines to the cursor
set ruler                               " Always show current position
set number                              " Show line number
set cmdheight=2                         " Height of the command bar
set hidden                              " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent          " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                          " Ignore case when searching
set smartcase                           " When searching try to be smart about cases
set hlsearch                            " Highlight search results
set incsearch                           " Makes search act like search in modern browsers
set lazyredraw                          " Don't redraw while executing macros (good performance config)
set magic                               " For regular expressions turn magic on
set showmatch                           " Show matching brackets when text indicator is over them
set mat=2                               " How many tenths of a second to blink when matching brackets
set noerrorbells                        " No annoying sound on errors
set novisualbell
set t_vb=
set timeoutlen=500

if v:version > 701                      " Highlight current line
    set cursorline
endif

let $COLORFULTERM=1                     " Check terminal color information
if &t_Co=~8 || &t_Co=~16
    let $COLORFULTERM=0
endif

" Highlight the area outside 80 columns
if exists('+colorcolumn')
    let &colorcolumn=join(range(81,999),",")
endif
autocmd ColorScheme *  if $COLORFULTERM | highlight ColorColumn ctermbg=235 guibg=#2c2d27 | endif

" Highlight personal defined text
autocmd BufEnter *  call HiSpecialArea()
autocmd ColorScheme *  highlight ExtraWhiteSpace guibg=yellow ctermbg=yellow

" Define 80+ column and Extra WhiteSpace display before colorscheme apply
" Otherwise it will raise 'group not defined error'
syntax enable                           " Enable syntax highlighting
colorscheme ron                         " Default colorschem
"
" }}}
" => Files, backups and undo --------------------------------------------- {{{
"
set ffs=unix,dos,mac                    " Use Unix as the standard file type

set nobackup                            " Turn backup off, since most stuff is in SVN, git ...
set noswapfile                          " Turn swap file off

let $UNDO=$WORK.'/undo/'                " Turn on persistent undo
if !isdirectory($UNDO)
    call mkdir($UNDO, "p")
endif

set undodir=$UNDO
set undofile
"
" }}}
" => Text, tab and indent related ---------------------------------------- {{{
"
set expandtab                           " Use spaces instead of tabs, C-Q<tab> for real tab
set smarttab                            " Be smart when using tabs ;)
set shiftwidth=4                        " 1 tab == 4 spaces
set tabstop=4
set lbr                                 " Linebreak on 500 characters
set tw=500
set ai                                  " Auto indent
set si                                  " Smart indent
set wrap                                " Wrap lines
"
" }}}
" => Moving around, tabs, windows and buffers ---------------------------- {{{
"
set autochdir                           " Auto switch CWD to the directory when opening buffer

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set showtabline=1
catch
endtry

augroup line_return " {{{---------------Line Return To Last Edit Position When Opening Files
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END " }}}

" Remember info about open buffers on close
set viminfo^=%
"
" }}}
" => Status line --------------------------------------------------------- {{{
"
set laststatus=2                        " Always show the status line

" Format the status line
set statusline=%{HasPaste()}%y[%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ %<%F\ %h%m%r%=%-40.(Line:\ %l/%L,\ Column:%c%V%)\ %p%%
"
" }}}
" => Spell checking ------------------------------------------------------ {{{
"
let $DICT=$WORK.'/dict/'                " Turn on persistent undo
if !isdirectory($DICT)
    call mkdir($DICT, "p")
endif

set dictionary+=$DICT/words.txt
set spellfile=$DICT/custom-dictionary.utf-8.add
"
" }}}
" => Fold ---------------------------------------------------------------- {{{
"
set foldlevelstart=0
set foldmethod=marker
set foldmarker={{{,}}}

set foldtext=DisplayFoldText()
"
" }}}
" => Helper functions ---------------------------------------------------- {{{
"
let s:guihide="Y"                       " By default, use minimum window
function! GUIHideEnabler() " {{{--------Control to display menu and toolbar
    if s:guihide == "N"
        let s:guihide = "Y"
        set guioptions-=T
        set guioptions-=m
    else
        let s:guihide = "N"
        set guioptions+=T
        set guioptions+=m
    endif
endfunction " }}}

let s:hexModle = "N"                    " By default, edit in normal mode
function! ToHexModle() " {{{------------Switch between normal mode and hex mode edit
  if s:hexModle == "Y"
    %!xxd -r
    let s:hexModle = "N"
  else
    %!xxd
    let s:hexModle = "Y"
  endif
endfunction " }}}

function! SaveSess(sessName) " {{{------Save Sessions for later restore
  execute 'mksession! ' . $HOME . '/'. a:sessName
endfunction " }}}

function! RestoreSess(sessName) " {{{---Restore saved session
    if filereadable($HOME . '/' . a:sessName)
        execute 'source ' . $HOME . '/' . a:sessName
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    execute 'sbuffer ' . l
                endif
            endfor
        endif
    endif
endfunction " }}}

function! DeleteTrailingWS() " {{{----- Delete trailing white space
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunction " }}}

function! HasPaste() " {{{--------------Returns true if paste mode is enabled
    if &paste
        return '[PASTE MODE]'
    endif
    return ''
endfunction " }}}

function! BufcloseCloseIt() " {{{-------Don't close window, when deleting a buffer
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
     endif
endfunction " }}}

function! My_Grep() " {{{---------------Show search result in quickfix window
    exe 'norm yiw'
    let searchWord = @"
    let searchWord = inputdialog("Please specify your pattern to search:",
                                 \searchWord)
    if searchWord == ""
        return
    endif

    let tempList = []
    exe '1,$g/'.searchWord.'/call add(tempList,line(".").":\t".getline("."))'

    copen 5
    set modifiable
    set buftype=help
    let @g = join(tempList,"\n")
    let tempList = []
    exe 'norm ggVGd'
    exe 'norm "gp'
    exe 'match search /'.searchWord.'/'

    nnoremap <buffer> <cr>          :call Goto_Line()<cr>
    nnoremap <buffer> <2-leftmouse> :call Goto_Line()<cr>
    nnoremap <buffer> <Down>        j :call Goto_Line()<cr>
    nnoremap <buffer> j             j :call Goto_Line()<cr>
    nnoremap <buffer> <Up>          k :call Goto_Line()<cr>
    nnoremap <buffer> k             k :call Goto_Line()<cr>
    let @g=""
endfunction " }}}

function! Goto_Line() " {{{-------------Move to the number of row (file) which in current line (Quickfix)
    let Temp = getline('.')
    let lineNo = matchstr(Temp, '^\d\+')
    if lineNo > 0
        exe "norm \<c-w>\<c-w>"
        exe "norm zR".lineNo."G"
        exe "norm \<c-w>\<c-w>"
    endif
endf " }}}

function! DisplayFoldText() " {{{-------Fold text display
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart + 1

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 3
    return line . ' …' . repeat(" ",fillcharcount) . ' ' . foldedlinecount . ' +'
endfunction " }}}

function! Strip(input_string) " {{{ ----Return striped string
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction " }}}

function! HiSpecialArea() " {{{ --------Define HighLight Special Area
    call matchadd('ExtraWhiteSpace', '\s\+$')
    call matchadd('ExtraWhiteSpace', '\t')
 endfunction " }}}
"
" }}}

" vim: set foldlevelstart=0 foldmethod=marker foldmarker={{{,}}}: "
