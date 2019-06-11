if !has("win32")
    " Favourite font setting
    if has("gui_running")
        if has("unix")
            set guifont=文泉驿等宽微米黑\ 12
        elseif has("mac")
            set guifont=Bitstream\ Vera\ Sans\ Mono:h14
            set nomacatsui
            set termencoding=macroman
        endif
    endif

    " Autoreload vimrc change
    autocmd! bufwritepost .vimrc source $HOME/.vimrc
endif

" Now Include the common configuration
source $HOME/vimcfg/common.vim
source $HOME/vimcfg/programming.vim
