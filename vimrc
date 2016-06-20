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

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
" Plugin 'scrooloose/nerdtree'
Plugin 'justinmk/vim-dirvish'
Plugin 'scrooloose/nerdcommenter'

" Plugin 'guyon/TabBar'
" Plugin 'rbgrouleff/bclose.vim'

Plugin 'altercation/vim-colors-solarized'
" Plugin 'majutsushi/tagbar.git'
" Plugin 'milkypostman/vim-togglelist'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
" Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'scrooloose/syntastic'
Plugin 'camelcasemotion'
Plugin 'a.vim'
Plugin 'rking/ag.vim'
" Plugin 'justinmk/vim-sneak'
Plugin 'valloric/YouCompleteMe'
Plugin 'SirVer/UltiSnips'
" Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'wincent/command-t'

Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'sgur/vim-textobj-parameter'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

Plugin 'elricbk/vim-cpp-organize-includes'
Plugin 'elricbk/vim-cpp-fix-includes'

Plugin 'pangloss/vim-javascript'
Plugin 'FooSoft/vim-argwrap'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set hidden

set ts=4 sw=4 et ai ci nu

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

" Switch to next/previous buffer. Makes sense only with TabBar plugin
" map <C-S-J> :bn<CR>
" map <C-S-K> :bp<CR>

set background=light
colorscheme solarized

" Max size for TabBar plugin
" let g:Tb_MaxSize=0

" map <Leader>n :NERDTreeToggle<CR>
" map <Leader>t :TagbarToggle<CR>
noremap <Leader>f :CtrlPMRU<CR>
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
    if name != ""
        " Restore visual selection and replace it with variable name
        execute "normal gvc" . name
        " Add line before current, paste variable name and equals sign
        if (&ft == 'cpp')
            execute "normal O" . "auto " . name . " = "
        else
            execute "normal O" . name . " = "
        endif
        " Paste actual variable value
        normal p
        if (&ft == 'cpp')
            execute "normal A" . ";"
        endif
    endif
endfunction

noremap <Leader>ev y:call ExtractVariable()<cr>

" More convenient paste
noremap <Leader>p :set paste!<CR>

" Allowing to select text which was just pasted
nmap gV `[v`]

" Remapping ultisnips to allow working with YCM
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-m>"

" Fixing some CtrlP issues
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.a,*.o,*.d,*.pyc,*/genfiles/*,genfiles/*
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_root_markers=['.ctrlp']
let g:ctrlp_max_files = 0

" Simple expanding of path of open file
cabbr <expr> %% expand('%:p:h')

" Command-t options
let g:CommandTCancelMap = ['<ESC>', '<C-c>']
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTCursorLeftMap = ['']
let g:CommandTMaxCachedDirectories = 0
let g:CommandTMaxFiles = 200000
let g:CommandTTagIncludeFilenames = 1
let g:CommandTCursorColor = 'StatusLine'

" Using Ctrl-A emacs-like in command line
cnoremap <C-A> <Home>

" Better handling of Ctrl-P/N in command line
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Gradle highlighting
au BufNewFile,BufRead *.gradle setf groovy

" Better handling of CPP extensions in a.vim
let g:alternateExtensions_H = "cpp,c"
let g:alternateExtensions_CPP = "inc,h,H,HPP,hpp"

" Prefix for fzf commands
let g:fzf_command_prefix = 'Fzf'

" More sane default split policy
set splitright
set splitbelow

" Some autoexpansion of brackets
inoremap {<CR> {<CR>}<Esc>O
inoremap {<C-j> {<CR>}<Esc>O

" Supercharged dot formula for words replacing
nnoremap c> *Ncgn
nnoremap c< #Ncgn

" Open folder of current file
nnoremap <Space><Space> :e %:p:h<CR>

if filereadable(expand("~/.vimrc_local"))
    source ~/.vimrc_local
endif
