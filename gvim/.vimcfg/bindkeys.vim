" Author: wangkexiong
" License: MIT License.
" Description: Here defines the shotcuts for fast working.
"              I ripped them out here for easy checking and reminder.

" => General Fast Working
"
noremap <leader><leader>     :w!<cr>:echo Strip("                           Fast saving...")<cr>
noremap <leader>qq           :q!<cr>:echo Strip("                           Fast quit current frame")<cr>
noremap <leader>qa           :qa!<cr>:echo Strip("                          Fast quit vim")<cr>
noremap <leader>ee           :tabedit! $MYVIMRC<cr>:echo Strip("            Fast edit configuration")<cr>

noremap <leader>bb           :call SaveSess('backup.vim')<cr>:echo Strip("  Fast save backup session")<cr>
noremap <leader>rr           :source $HOME/last.vim<cr>:echo Strip("        Manually Restore last working env")<cr>

" => User Interface
"
noremap <S-Space>            :setlocal list!<cr>:echo Strip("               Togger to display special characters")<cr>

" => Files, backups and undo
"
noremap <leader>fd           :se ff=dos<cr>:echo Strip("                    Set fileformat to DOS")<cr>
noremap <leader>fu           :se ff=unix<cr>:echo Strip("                   Set fileformat to UNIX")<cr>
noremap <leader>fm           :se ff=mac<cr>:echo Strip("                    Set fileformat to MAC")<cr>

noremap <Leader>fr           mz:%s/<C-V><cr>//ge<cr>`z:echo Strip("         Remove Windows ^M")<cr>

" => Text, tab and indent related
"
noremap <leader>fh           :call ToHexModle()<cr>:echo Strip("            Togger between NORMAL and HEX editor mode")<cr>

" => Moving around, tabs, windows and buffers
"
" Treat long lines as break lines (useful when moving around in them)
noremap j                    gj:echo Strip("                                Moving down as break lines for every long lines")<cr>
noremap k                    gk:echo Strip("                                Moving up as break lines for every long lines")<cr>

noremap <silent><leader><cr> :noh<cr>:echo Strip("                          Disable highlight")<cr>

" Smart way to move between windows
noremap <C-j>                <C-W>j:echo Strip("                            Move to down window")<cr>
noremap <C-k>                <C-W>k:echo Strip("                            Move to up window")<cr>
noremap <C-h>                <C-W>h:echo Strip("                            Move to left window")<cr>
noremap <C-l>                <C-W>l:echo Strip("                            Move to right window")<cr>

" Useful mappings for managing tabs
noremap <M-1>                1gt:echo Strip("                               Move to 1st tab")<cr>
noremap <M-2>                2gt:echo Strip("                               Move to 2nd tab")<cr>
noremap <M-3>                3gt:echo Strip("                               Move to 3rd tab")<cr>
noremap <M-4>                4gt:echo Strip("                               Move to 4th tab")<cr>
noremap <M-5>                5gt:echo Strip("                               Move to 5th tab")<cr>
noremap <M-6>                6gt:echo Strip("                               Move to 6th tab")<cr>
noremap <M-7>                7gt:echo Strip("                               Move to 7th tab")<cr>
noremap <M-8>                8gt:echo Strip("                               Move to 8th tab")<cr>
noremap <M-9>                9gt:echo Strip("                               Move to 9th tab")<cr>
noremap <leader>tn           :tabnew<cr>:echo Strip("                       Create new tab")<cr>
noremap <leader>to           :tabonly<cr>:echo Strip("                      Close all other tab pages")<cr>
noremap <leader>tc           :tabclose<cr>:echo Strip("                     Close current tab page")<cr>
noremap <leader>t,           :tabprevious<cr>:echo Strip("                  Move to previous tab")<cr>
noremap <leader>t.           :tabnext<cr>:echo Strip("                      Move to next tab")<cr>

noremap <leader>tm           :tabmove |                                     "Move current tab to after page <N>"
noremap <leader>te           :tabedit <c-r>=expand("%:p:h")<cr>/|           "Using new tab to edit file with current buffer's path

" => Editing mappings
"
nnoremap <M-j>               mz:m+<cr>`z:echo Strip("                       Exchange current line with next line")<cr>
nnoremap <M-k>               mz:m-2<cr>`z:echo Strip("                      Exchange current line with previous line")<cr>
vnoremap <M-j>               :m'>+<cr>`<my`>mzgv`yo`z:echo Strip("          Exchange current line with next line")<cr>
vnoremap <M-k>               :m'<-2<cr>`>my`<mzgv`yo`z:echo Strip("         Exchange current line with previous line")<cr>

if has("mac") || has("macunix")
    nnoremap <D-j>           <M-j>
    nnoremap <D-k>           <M-k>
    vnoremap <D-j>           <M-j>
    vnoremap <D-k>           <M-k>
endif

" => Spell checking
"
nnoremap <leader>ss          :setlocal spell!<cr>:echo Strip("              Togger Spell Check")<cr>
nnoremap <leader>sn          ]s:echo Strip("                                Move to next bad word")<cr>
nnoremap <leader>sp          [s:echo Strip("                                Move to previous bad word")<cr>
nnoremap <leader>s?          z=
nnoremap <leader>sa          zg:echo Strip("                                Add current word in dictionary")<cr>

" => Fold
"
nnoremap <Space>             za:echo Strip("                                Togger fold")<cr>
vnoremap <Space>             za:echo Strip("                                Togger fold")<cr>

" => Buffer
"
command! Bclose              call BufcloseCloseIt()
noremap <leader>bn           :e ~/buffer<cr>:echo Strip("                   Quickly open a buffer for scriptable")<cr>
noremap <leader>bd           :Bclose<cr>:echo Strip("                       Close current buffer")<cr>
noremap <leader>ba           :%bdelete<cr>:echo Strip("                     Close all the buffers")<cr>

noremap <leader>b,           :bprevious<cr>:echo Strip("                    Move to previous buffer")<cr>
noremap <leader>b.           :bnext<cr>:echo Strip("                        Move to next buffer")<cr>
noremap <C-Left>             :bprevious<cr>:echo Strip("                    Move to previous buffer")<cr>
noremap <C-Right>            :bnext<cr>:echo Strip("                        Move to next buffer")<cr>
inoremap <C-Left>            <ESC>:bprevious<CR>:echo Strip("               Move to previous buffer")<cr>
inoremap <C-Right>           <ESC>:bnext<CR>:echo Strip("                   Move to next buffer")<cr>

noremap <leader>pp           :setlocal paste!<cr>:echo Strip("              Toggle paste mode")<cr>

" => 3rd Party Plugins
"
nmap <silent><F1>            :NERDTreeToggle<cr>
nmap <silent><F2>            <Plug>ToggleProject<cr>
nmap <silent><F3>            :call My_Grep()<cr>|                           "Searching...
inoremap <F5>                <ESC>u@.:echo Strip("                          Convert Inserted Text to Normal Mode Commands")<cr>
nmap <silent><F11>           :TagbarToggle<cr>
nmap <silent><F12>           :call GUIHideEnabler()<cr>:echo Strip("        Togger to display menu and toolbar")<cr>

autocmd FileType vimwiki     nnoremap <silent><buffer><Space> :TaskToggle<cr>
nmap <leader>task            :TaskToday<cr>

map <Leader>on               :OctopressNew<CR>
map <Leader>ol               :OctopressList<CR>
map <Leader>og               :OctopressGrep<CR>

autocmd FileType javascript  map  <silent><F5>  :w!<cr>:JSHint<cr>
autocmd FileType javascript  imap <silent><F5>  <ESC>:w!<cr>:JSHint<cr>

" For python programming, the following autocomplet mapping are used:
"   <Tab> <S-Tab>            snipmate
"   <C-j>                    rope autocomplete (pymode with rope enabled)
"   <C-Tab> <C-S-Tab>        Python dictionary autocomplete (pydiction)

nmap <leader>todo            <Plug>TaskList

