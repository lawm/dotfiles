
if 0 == 1

" Load plugins with vim-plug
set nocompatible
filetype off

call plug#begin('~/.vim/bundle')
Plug '~/.vim/bundle/vim-airline'
Plug '~/.vim/bundle/vim-gitgutter', { 'on': [] }
Plug 'git://github.com/tpope/vim-fugitive.git'
Plug 'git://github.com/ctrlpvim/ctrlp.vim'
Plug 'git://github.com/conormcd/matchindent.vim'
Plug 'git://github.com/vim-scripts/AutoComplPop', { 'on': [] }
Plug '~/.vim/bundle/tagbar'
call plug#end()

syntax enable
filetype plugin indent on


" Save/restore open buffers
function! SaveSession(dir)
    let l:fname = a:dir . '/Session.vim'
    exec 'mksession! ' . l:fname
    let l:blines = []
    for line in readfile(l:fname)
        if line =~ '^badd'
            call add(l:blines, line)
        endif
    endfor
    call writefile(l:blines, l:fname)
endfunction

if isdirectory("/var/tmp/lawrence")
    nnoremap <Leader>sm :<C-U>call SaveSession('/var/tmp/lawrence')<CR>
    nnoremap <Leader>ss :source /var/tmp/lawrence/Session.vim<CR>:b2<CR>
else
    nnoremap <Leader>sm :mksession! ~/Session.vim<CR>
    nnoremap <Leader>ss :source ~/Session.vim<CR>:e<CR>
endif

set sessionoptions=buffers

" Remove [no name] buffer ?
set shortmess+=I

endif " 0 == 1

" Set indent options
set smartindent
set ts=4
set sw=4
set expandtab

" Ignore case when searching
set incsearch
set ignorecase
set smartcase

" F10 to toggle paste mode, so vim doesn't re-indent
set pastetoggle=<F10>

" F11 to toggle showing tabs and trailing spaces
set listchars=tab:>-,trail:~,extends:>,precedes:<
function! SetListEcho()
    set list!
    echo "list=" . &list . " et=" . &et . " sw=" . &sw . " sts=" . &sts . " ts=" . &ts
endfunction
map <F11> :<C-U>call SetListEcho()<CR>

" Enable mouse operations
set mouse=a

" Vim window resizing by mouse in tmux
if &term == "screen" || &term == "screen-256color"
    set ttymouse=xterm2
endif

" Show tab completion menu in command mode
set wildmenu
set wildmode=list:longest

set diffopt+=vertical

" Color
set background=dark
colorscheme desert256
hi Normal guibg=#3a3a3a guifg=#eeeeee
hi NonText guibg=#3a3a3a
if &term == "screen" || &term == "screen-256color" || &term == "xterm-256color" || &term == "nvim"
    if &term != "nvim"
        set t_Co=256
    endif
    hi Normal ctermfg=254 ctermbg=237
    hi NonText ctermfg=254 ctermbg=237
else
    set t_Co=16
endif


hi clear DiffText
hi DiffText       cterm=NONE ctermbg=217 ctermfg=0


hi clear Pmenu
hi clear PmenuSel
hi Pmenu ctermfg=188 ctermbg=235
hi link PmenuSel CursorLine

hi clear CursorLine
hi CursorLine ctermfg=NONE ctermbg=23

" Press , or 2, to highlight all occurrences of a word.  \, to clear
hi My2Match term=reverse ctermfg=15 ctermbg=4 guifg=White guibg=Blue
function! MatFunc()
    let currwin=winnr()
    let w = expand("<cword>")
    if v:count == 0
        windo exec 'match Error /\<' . w . '\>/'
    else
        windo exec '2match My2Match /\<' . w . '\>/'
    endif
    execute currwin . 'wincmd w'
endfunction

function! MatFuncClear()
    let currwin=winnr()
    if v:count == 0
        windo match
    else
        windo 2match
    endif
    execute currwin . 'wincmd w'
endfunction

nnoremap , :<C-U>call MatFunc()<CR>
nnoremap <Leader>, :<C-U>call MatFuncClear()<CR>

" F8 to find a file named with the current word
nnoremap <F8> :<C-U>noautocmd find **/<C-R><C-W>.<C-R>=expand('%:e')<CR>

" F9 to search the current word
nnoremap <F9> :<C-U>noautocmd vimgrep /<C-R><C-W>/ **/*.<C-R>=expand('%:e')<CR>


" Trim trailing spaces by :call TrimTrailingSpace()
function! TrimTrailingSpace()
    %s/\s*$//
    ''
:endfunction

" Easier window navigation
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Buffer switching shortcuts
noremap  <F3> :<C-U>bp!<CR>
noremap  <F4> :<C-U>bn!<CR>
inoremap <F3> <ESC>:bp!<CR>
inoremap <F4> <ESC>:bn!<CR>

noremap <Leader>[ :<C-U>bp!<CR>
noremap <Leader>] :<C-U>bn!<CR>
nnoremap <Leader>d :<C-U>bd<CR>
nnoremap <Leader>1 :<C-U>b 1<CR>
nnoremap <Leader>2 :<C-U>b 2<CR>
nnoremap <Leader>3 :<C-U>b 3<CR>
nnoremap <Leader>4 :<C-U>b 4<CR>
nnoremap <Leader>5 :<C-U>b 5<CR>
nnoremap <Leader>l :<C-U>bl<CR>

" Netrw default mode in :E
let g:netrw_liststyle=2
" Netrw default hide hidden files
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

" Fix some java syntax highlighting problems
let java_allow_cpp_keywords=1

" Command mode emacs style bindings
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" Always show statusline
set laststatus=2

" s to insert single character
"function! RepeatChar(char, count)
"    return repeat(a:char, a:count)
"endfunction
"nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
"nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Next search result with 2 lines padding
set scrolloff=2

" Show tag in preview window
nnoremap <Leader>t <C-W>g}
nnoremap <C-Space> <C-W>}
nnoremap <Leader><C-Space> :<C-U>pcl<CR>
nnoremap <C-@> <C-W>}
nnoremap <Leader><C-@> :<C-U>pcl<CR>

" Persistent undo
if has('persistent_undo')      "check if your vim version supports it
    set undofile                 "turn on the feature
    if isdirectory("/var/tmp/lawrence")
        set undodir=/var/tmp/lawrence/.vimundo  "directory where the undo files will be stored
    else
        set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
    endif
endif

" Completion:
" skip tags completion, include unloaded buffers
set complete=.,w,b,u,i
" show menu even when 1 match
set completeopt=menuone,preview
" skip /usr/include in include file completion
set path=.,,

" Copy to system clipboard with Ctrl-C
vnoremap <C-c> "+y

" Allow erase old text
set bs=2

"
fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    "echo getline(search("^\\( \\{4}\\|\\t\\)\\?\\a\\S\\{-}\\( \\a\\S\\{-}\\)\\+\\s\\?(.*[^;]\\s\\{-}$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
nnoremap <Leader>f :<C-U>call ShowFuncName()<CR>


""""""""""" Plugin Configuration
" Airline
let g:airline_theme='raven'
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline#extensions#branch#enabled=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_tab_nr=0
let g:airline#extensions#tabline#show_tab_type=0
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#buffer_nr_format='%s '
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#fnamecollapse=0
let g:airline#extensions#tabline#fnametruncate=12
let g:airline#extensions#tabline#buffer_min_count=2
let g:airline#extensions#tabline#tab_min_count=2
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : ' ',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

" Ctrlp
if isdirectory("/var/tmp/lawrence/.ctrlp")
    let g:ctrlp_cache_dir = '/var/tmp/lawrence/.ctrlp'
endif
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'
set wildignore +=*.o
let g:ctrlp_mruf_exclude = 'COMMIT_EDITMSG$'

" Gitgutter
hi link GitGutterAdd          DiffAdd
hi link GitGutterChange       DiffChange
hi link GitGutterDelete       DiffDelete
hi link GitGutterChangeDelete DiffChange
let g:gitgutter_enabled = 0
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
function! GitGutterLoadToggle()
    if !exists('g:loaded_gitgutter')
        call plug#load('vim-gitgutter')
    endif
    GitGutterToggle
endfunction
nmap <F2> :<C-U>call GitGutterLoadToggle()<CR>

" Vim-fugitive: Goto git work directory of current file
function! GcdEcho()
    Gcd
    echo "" . getcwd()
endfunction
nnoremap <Leader>c :<C-U>call GcdEcho()<CR>

" AutoComplPop
let g:acp_completeOption = '.,w,b,i'
let g:acp_behaviorKeywordCommand = "\<C-p>"
inoremap <expr> <Tab>   pumvisible() ? "\<C-y>" : "\<Tab>"
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <C-Space> <C-p>
inoremap <C-@> <C-p>
function! ComplLoadToggle()
    if !exists('g:loaded_autoload_acp')
        call plug#load('AutoComplPop')
        let g:compl_enable = 1
        return
    endif
    if g:compl_enable == 0
        let g:compl_enable = 1
        AcpEnable
    else
        let g:compl_enable = 0
        AcpDisable
    endif
endfunction
nnoremap <Leader>y :<C-U>call ComplLoadToggle()<CR>

" disable system plugins
let g:loaded_vimballPlugin = "1"
let loaded_spellfile_plugin = 1
