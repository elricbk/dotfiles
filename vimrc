set nocompatible              " be iMproved, required
filetype off                  " required

" Needed to remap wbe to CamelCase motion instead of by word
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

let g:loaded_matchit = 1

call plug#begin('~/.vim/bundle')

Plug 'camelcasemotion'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'

Plug 'altercation/vim-colors-solarized'
Plug 'justinmk/vim-dirvish'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'a.vim'
Plug 'rking/ag.vim'
Plug 'valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'SirVer/UltiSnips'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/Vader.vim'

Plug 'elricbk/vim-cpp-organize-includes'
Plug 'elricbk/vim-cpp-fix-includes'
Plug 'elricbk/vim-yawiki'

Plug 'sheerun/vim-polyglot'
Plug 'FooSoft/vim-argwrap'

Plug 'AndrewRadev/sideways.vim'

Plug 'haya14busa/vim-asterisk'

call plug#end()

filetype plugin indent on

set hidden

set ts=4 sw=4 et ai ci nu rnu

syntax on

" Search options
set hlsearch
set ignorecase
set smartcase

" Completion options
set cot+=longest
set cot-=preview

let mapleader=","
nnoremap \ ,

set background=light
colorscheme solarized

noremap <Leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <Leader>gi :YcmCompleter GoToInclude<CR>
noremap <Leader>gt :YcmCompleter GetType<CR>

let g:ycm_confirm_extra_conf = 0
let g:jedi#related_names_command = ""
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#auto_vim_configuration = 0

" Let's use 'screen lines' instead of actual ones
nnoremap j gj
nnoremap k gk

" Allow running commands in cyrillic layout
set langmap=йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;qwertyuiop[]asdfghjkl;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

" More support for cyrillic
cabbrev ц w
nnoremap о gj
nnoremap л gk

" Move .swp files to a single folder
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" Use nice fonts in airline plugin
let g:airline_powerline_fonts = 1

" Add helper function to extract variables in C++/Python
function! ExtractVariable()
    let name = inputdialog("Extracted variable name: ")
    if name ==? ""
        return
    endif

    " Restore visual selection and replace it with variable name
    execute "normal! gvc" . name
    " Add line before current, paste variable name and equals sign
    if &ft == 'cpp'
        execute "normal! O" . "const auto " . name . " = "
    else
        execute "normal! O" . name . " = "
    endif
    " Paste actual variable value
    normal p
    if &ft == 'cpp'
        execute "normal! A;"
    endif
endfunction

noremap <Leader>ev y:call ExtractVariable()<cr>

" Helper function to transform C/C++ enums to operator<<
function! OstreamizeEnumFunction()
    let header = "inline<CR>std::ostream& operator << (std::ostream& os, ENUM_CLASS_NAME value)<CR>{<CR>const static std::map<ENUM_CLASS_NAME, std::string> VALUES = {<CR>"
    let footer = "<CR>};<CR>return os << (VALUES.count(value) ? VALUES.at(value) : "UNKNOWN");<CR>}"
    " Drop empty lines
    silent! g/^\s*$/d
    " Save enum name to 'a' register
    silent! normal gg
    silent! s/\venum\s+(class\s+)?(\w+)/\=setreg('a', submatch(2))/n
    " Drop first and last lines
    silent! 0d
    silent! $d
    " Drop spaces and commas
    silent! %s/\v\s+|,//g
    " Prepend each enum value with enum name
    silent! %s/\ze\w\+/\=@a . '::'/
    " Transform it to std::map initializer list value
    silent! %s/\v\w+::(\w+)/{&, "\1"},/
    " Prepend function header
    silent! 0s/^/\=header/
    " Append function footer
    silent! $s/$/\=footer/
    " Replace placeholder values with enum name
    silent! %s/ENUM_CLASS_NAME/\=@a/g
    silent! %s/<CR>//g
    " Format the result
    silent! normal gg=G
endfunction

command! OstreamizeEnum call OstreamizeEnumFunction()

" Helper function to allow easier URL reading
" Works on buffer as whole
function! s:UrlSplit()
    substitute /?/?/e
    % substitute /&//ge
    % substitute /%2C/,/ge
    % substitute /%3D/=/ge
    % substitute /%3B/;/ge
    silent! /=
    if g:tabular_loaded
        silent! Tabularize /=
    endif
    match Function /^\w\+/
    2match String /\s\+=\s\zs.*$/
    3match Comment /=/
endfunction

command! UrlSplit :call <SID>UrlSplit()

" More convenient paste
noremap <Leader>p :set paste!<CR>

" Allowing to select text which was just pasted
nmap gV `[v`]

" Remapping ultisnips to allow working with YCM
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"

" Fixing some CtrlP issues
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.a,*.o,*.d,*.pyc,*/genfiles/*,genfiles/*,*/git_mobflow_msg*
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" For now we only need MRU functionality from CtrlP
let g:ctrlp_types = ['mru']
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_root_markers=['.ctrlp']
let g:ctrlp_max_files = 0
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_by_filename = 1

" Simple expanding of path of open file
cabbr <expr> %% expand('%:p:h')

" Using Ctrl-A emacs-like in command line
cnoremap <C-A> <Home>

" Better handling of Ctrl-P/N in command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Gradle highlighting
au BufNewFile,BufRead *.gradle setf groovy

" Better handling of CPP extensions in a.vim
let g:alternateExtensions_h = "cpp,c"
let g:alternateExtensions_cpp = "inc,h,H,HPP,hpp"

" Prefix for fzf commands
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~15' }
nnoremap <Leader>t :<C-u>FzfFiles<CR>

" More sane default split policy
set splitright
set splitbelow

" Some autoexpansion of brackets
inoremap {<CR> {<CR>}<Esc>O
inoremap {<C-j> {<CR>}<Esc>O

" Supercharged dot formula for words replacing
nnoremap c> *Ncgn
nnoremap c< #Ncgn

" Working with arguments
nnoremap <Leader>aw :<C-U>ArgWrap<CR>
nnoremap <Leader>ar :<C-U>SidewaysRight<CR>
nnoremap <Leader>al :<C-U>SidewaysLeft<CR>

" Trying `vim-asterisk` mappings
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif

