set nocompatible              " be iMproved, required
filetype off                  " required

let g:loaded_matchit = 1

" This mapping should go here as we'll use <Leader> in plugin mappings
let mapleader=","
nnoremap \ ,

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'

Plug 'vim-scripts/camelcasemotion'
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

Plug 'altercation/vim-colors-solarized'

Plug 'justinmk/vim-dirvish'
let g:dirvish_mode=':sort ,^.*/,'

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

Plug 'vim-scripts/a.vim'
" Better handling of CPP extensions in a.vim
let g:alternateExtensions_h = "cpp,c"
let g:alternateExtensions_cpp = "inc,h,H,HPP,hpp"

Plug 'valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
" YCM options
let g:ycm_confirm_extra_conf = 0
let g:jedi#related_names_command = ""
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#auto_vim_configuration = 0
" YCM mappings
noremap <Leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <Leader>gi :YcmCompleter GoToInclude<CR>
noremap <Leader>gt :YcmCompleter GetType<CR>
noremap <Leader>gx :YcmCompleter FixIt<CR>

Plug 'SirVer/UltiSnips'
" Remapping ultisnips to allow working with YCM
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plug 'tenfyzhong/CompleteParameter.vim'
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
let g:complete_parameter_use_ultisnips_mapping = 1

" Text objects plugins
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Prefix for fzf commands
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~15' }
nnoremap <Leader>t :<C-u>FzfFiles<CR>
nnoremap <Leader>f :<C-u>FzfHistory<CR>

Plug 'FooSoft/vim-argwrap'
" Wrapping argument lists in calls and functions
nnoremap <Leader>aw :<C-U>ArgWrap<CR>
nnoremap <Leader>af :<C-U>ArgWrap<CR>%kJ>ib

Plug 'AndrewRadev/sideways.vim'
" Add 'argument' text object
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
" Moving arguments around
nnoremap <Leader>ar :<C-U>SidewaysRight<CR>
nnoremap <Leader>al :<C-U>SidewaysLeft<CR>

Plug 'haya14busa/vim-asterisk'
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

" Syntax plugins
Plug 'sheerun/vim-polyglot'
Plug 'zchee/vim-flatbuffers'
Plug 'elricbk/vim-yawiki'

" Misc stuff
Plug 'jszakmeister/vim-togglecursor'
Plug 'godlygeek/tabular'
Plug 'elricbk/vim-cpp-organize-includes'
Plug 'elricbk/vim-cpp-fix-includes'
Plug 'elricbk/vim-requester'

" Writing tests for plugins
Plug 'junegunn/Vader.vim'

call plug#end()

filetype plugin indent on
syntax on

set hidden

" Indentation settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
" No indent inside namespaces
set cinoptions=N-s

" Numbers column
set number
set relativenumber
" This seem to at least partially fix relative numbers slowdown in
" iTerm2/tmux/vim combo
set lazyredraw

" Search options
set hlsearch
set ignorecase
set smartcase

" Completion options
set completeopt+=longest
set completeopt-=preview

set background=light
colorscheme solarized

" Use 'screen lines' instead of actual ones
noremap <expr> j (v:count ? 'j' : 'gj')
noremap <expr> k (v:count ? 'k' : 'gk')

" Cyrillic support
" Allow running commands in cyrillic layout
set langmap=йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;qwertyuiop[]asdfghjkl;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>
cabbrev ц w
noremap <expr> о (v:count ? 'j' : 'gj')
noremap <expr> л (v:count ? 'k' : 'gk')

" Move .swp files to a single folder
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//
set undodir=~/.vim/undo//

" Allowing to select text which was just pasted
noremap gV `[v`]

" Better wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.a,*.o,*.d,*.pyc,*/genfiles/*,genfiles/*,*/git_mobflow_msg*

" More sane default split policy
set splitright
set splitbelow

" Simple expanding of path of open file
cabbrev <expr> %% expand('%:p:h')

" Using Ctrl-A emacs-like in command line
cnoremap <C-A> <Home>

" Better handling of Ctrl-P/N in command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Autoexpansion of curly brackets
inoremap {<CR> {<CR>}<Esc>O

" Supercharged dot formula for words replacing
nnoremap c> *Ncgn
nnoremap c< #Ncgn

" Add better grepping if 'rg' is available
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    nnoremap <expr> K ':grep! "\b' . expand('<cword>') . '\b"<CR>:botright cwindow<CR>'
    command! -nargs=+ -complete=file -bar Grep silent! grep! <args>|botright cwindow|redraw!
endif

" Gradle highlighting
augroup BufNewFile,BufRead *.gradle setf groovy

" Add helper function to extract variables in C++/Python
function! ExtractVariable()
    let name = inputdialog("Extracted variable name: ")
    if name ==? ""
        return
    endif

    " Restore visual selection and replace it with variable name
    execute "normal! gvc" . name

    let prefix = ''
    let suffix = ''
    if &ft == 'cpp'
        let prefix = "const auto "
        let suffix = ";"
    elseif &ft == 'vim'
        let prefix = "let "
    endif

    " Add line before current, paste variable name and equals sign
    execute "normal! O" . prefix . name . " = "
    " Paste actual variable value
    normal p
    execute "normal! A" . suffix
endfunction

noremap <Leader>ev y:call ExtractVariable()<cr>

" Helper function to transform C/C++ enums to operator<<
function! OstreamizeEnumFunction()
    let header = "inline<CR>std::ostream& operator << (std::ostream& os, ENUM_CLASS_NAME value)<CR>{<CR>const static std::map<ENUM_CLASS_NAME, std::string> VALUES = {<CR>"
    let footer = "<CR>};<CR>return os << (VALUES.count(value) ? VALUES.at(value) : \"UNKNOWN\");<CR>}"
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

if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif

