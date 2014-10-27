set smartindent
set ts=4
set sw=4
set expandtab

" load plugins using pathogen
execute pathogen#infect()

" ignore case when searching
set incsearch
set ignorecase
set smartcase

" F10 to toggle paste mode, so vim doesn't re-indent
set pastetoggle=<F10>

" F11 to toggle showing tabs and trailing spaces
set listchars=tab:>-,trail:~,extends:>,precedes:<
function! SetListEcho()
    set list!
    echo "list="&list
endfunction
map <F11> :<C-U>call SetListEcho()<CR>

" enable mouse operations
set mouse=a

" for vim window resizing by mouse in tmux
if &term == "screen" || &term == "screen-256color"
    set ttymouse=xterm2
endif

" show tab completion menu in command mode
set wildmenu
set wildmode=list:longest

if &term == "screen-256color"
    "|| &term == "xterm"
    set t_Co=256
else
    set t_Co=16
endif

"for solarized, set terminal colors, use t_Co=16, background=dark
"set background=dark
"let g:solarized_contrast="high"
"colorscheme solarized

" press , or 2, to highlight all occurrences of a word.  \, to clear
highlight My2Match term=reverse ctermfg=15 ctermbg=4 guifg=White guibg=Blue
function! MatFunc()
    if v:count == 0
        exec 'match Error /\<' . expand("<cword>") . '\>/'
    else
        exec '2match My2Match /\<' . expand("<cword>") . '\>/'
    endif
endfunction

function! MatFuncClear()
    if v:count == 0
        match
    else
        2match
    endif
endfunction

"nnoremap , :<C-U>mat Error /\<<C-R><C-W>\>/<CR>
"nnoremap <Leader>, :<C-U>mat<CR>
nnoremap , :<C-U>call MatFunc()<CR>
nnoremap <Leader>, :<C-U>call MatFuncClear()<CR>

" F8 to find a file named with the current word
"function! FindFunc()
"    let l:ext = expand('%:e')
"endfunction
"nnoremap <F8> :<C-U>call FindFunc()<CR>
nnoremap <F8> :<C-U>find **/<C-R><C-W>.<C-R>=expand('%:e')<CR>

" F9 to search the current word
nnoremap <F9> :<C-U>noautocmd vimgrep <C-R><C-W> **/*.<C-R>=expand('%:e')<CR>


" function to trim trailing spaces
function! TrimTrailingSpace()
    %s/\s*$//
    ''
:endfunction

"----------- minibufexpl -----------
"let g:miniBufExplModSelTarget=1
let g:miniBufExplUseSingleClick=1
"let g:miniBufExplForceSyntaxEnable=1
"let g:miniBufExplTabWrap=1
"let g:miniBufExplMaxHeight=2
let g:did_minibufexplorer_syntax_inits = 1
"let g:miniBufExplCheckDupeBufs = 0
let g:miniBufExplCycleArround=1
let g:miniBufExplSetUT=0

"let g:miniBufExplDebugLevel = 5
"let g:miniBufExplDebugMode  = 2

noremap  <F1> :MBEToggle<CR>
noremap  <F3> :<C-U>MBEbp<CR>
noremap  <F4> :<C-U>MBEbn<CR>
inoremap <F3> <ESC>:MBEbp<CR>
inoremap <F4> <ESC>:MBEbn<CR>

"let g:miniBufExplMapWindowNavVim=1
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

if &t_Co == 16 || &t_Co == 256
    hi clear MBENormal
    hi clear MBEVisibleActive
    hi clear MBEVisibleChangedActive
    hi MBEVisibleActiveNormal term=reverse cterm=reverse
    hi MBEVisibleActiveChanged term=reverse cterm=reverse ctermbg=Red
else
    hi MBENormal ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
    hi MBEChanged ctermbg=LightGray ctermfg=Red guibg=LightGray guifg=Red
    hi MBEVisibleNormal ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
    hi MBEVisibleChanged ctermbg=LightGray ctermfg=DarkRed guibg=LightGray guifg=DarkRed
    hi MBEVisibleActiveNormal ctermbg=Black ctermfg=Green guibg=Black guifg=White
    hi MBEVisibleActiveChanged term=bold,reverse ctermbg=Black ctermfg=Red guibg=Black guifg=Red
endif
"if &term == "xterm"
"    hi MBEChanged ctermbg=LightGray ctermfg=Red guibg=LightGray guifg=Red
"    hi MBEVisibleNormal ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
"    hi MBEVisibleChanged ctermbg=LightGray ctermfg=DarkRed guibg=LightGray guifg=DarkRed
"    hi MBEVisibleActive term=reverse cterm=reverse
"    hi MBEVisibleChangedActive term=bold,reverse cterm=bold,reverse ctermbg=Red
"endif

hi StatusLine     term=bold,reverse cterm=bold,reverse
hi StatusLineNC   term=reverse cterm=reverse

noremap <Leader>[ :<C-U>MBEbp<CR>
noremap <Leader>] :<C-U>MBEbn<CR>

" fix some syntax highlighting colors
"set t_Co=16
if exists("g:colors_name") && g:colors_name != "solarized"
    hi Search ctermfg=Black
endif

if 1
    "hi DiffAdd        cterm=NONE ctermbg=4 ctermfg=Black
    hi DiffAdd        cterm=NONE ctermbg=2 ctermfg=Black
    hi DiffChange     cterm=NONE ctermbg=81 ctermfg=Black
    hi DiffDelete     cterm=NONE ctermbg=6 ctermfg=Black
    hi clear DiffText
    hi DiffText       cterm=NONE ctermbg=1 ctermfg=0 "guifg=Black guibg=Red "ctermbg=DarkRed
endif

if !has("gui_running")
    hi clear Visual
    hi Visual cterm=reverse
    hi Pmenu ctermfg=Black
    hi PmenuSel ctermfg=Black
    hi PmenuSbar ctermfg=Black
else
    "set guifont=Inconsolata\ 12
endif

hi clear MatchParen
hi MatchParen ctermfg=9

" default mode in :E
let g:netrw_liststyle=2
" fix some java syntax highlighting
let java_allow_cpp_keywords=1

" command mode emacs style bindings
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
"cnoremap <Esc>b <S-Left>
"cnoremap <Esc>f <S-Right>

" always show statusline
set laststatus=2

highlight signcolumn ctermbg=DarkGrey
let g:gitgutter_enabled = 0
let g:gitgutter_eager = 0
"nmap <leader>gu :GitGutterToggle<CR>
nmap <F2> :<C-U>GitGutterToggle<CR>


" s to insert single character
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
