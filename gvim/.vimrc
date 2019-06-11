" Author: wangkexiong
" Source: https://github.com/wangkexiong/dotrc/blob/master/gvim/.vimrc
" Precondition: Need to install git first.
"               Vundle and other bundle plugins will be cloned using git.
" License: MIT License.

if !has("win32")
    " Favourite font setting
    if has("gui_running")
        if has("unix")
            set guifont=文泉驿等宽微米黑\ 12
        elseif has("mac")
            set guifont=Bitstream\ Vera\ Sans\ Mono:h12
            set nomacatsui
            set termencoding=macroman
        endif
    endif

    " Set conf directory
    let $CONF=$HOME.'/.vimcfg'
    " Set work directory
    let $WORK=$HOME.'/.vim'
endif

source $CONF/vundlewrapper.vim          " vundle automatic installation
source $CONF/common.vim                 " Common settings
source $CONF/plugins.vim                " Using vundle to manage vim plugins
source $CONF/programming.vim            " Programming settings
source $CONF/bindkeys.vim               " Binding shortcuts
