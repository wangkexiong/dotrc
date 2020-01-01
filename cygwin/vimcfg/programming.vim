if exists('loaded_taglist')
    let Tlist_Show_One_File = 1         "Only show tags for current file
    let Tlist_Exit_OnlyWindow = 1       "Exit VIM if tag window is the only one
    let Tlist_Use_Right_Window = 1      "Display taglist window right
    let Tlist_Use_SingleClick = 1       "Jump by single click
    let Tlist_Show_One_File = 0         "show tags for multiple files
    let Tlist_File_Fold_Auto_Close = 1  "AutoFold the other tags
    let Tlist_Process_File_Always = 1   "Always update

    if has ("gui_running")
        map <silent><F12> :TlistToggle<cr>
    else
        map <leader>tl    :TlistToggle<cr>
    endif
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

" Trailing white space on save
autocmd BufWrite *.py       :call DeleteTrailingWS()
autocmd BufWrite *.coffee   :call DeleteTrailingWS()

" Set make program
autocmd BufRead *.erl       :compiler erlang
autocmd BufRead *.dot       :compiler dot
