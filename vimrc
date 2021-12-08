" References:
" - https://github.com/kracejic/dotfiles/blob/master/.vimrc
"
" If slow, profile vimrc so it loads quickly - especially autocmds via 'vim --startuptime vim.log'
"*****************************************************************************
"" Portable settings
"*****************************************************************************

" run portable settings vim -u /path/to/portable/.vim/.vimrc

" set default 'runtimepath' (without ~/.vim folders)
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" what is the name of the directory containing this file?
let s:portable = expand('<sfile>:p:h')

" add the directory to 'runtimepath'
let &runtimepath = printf('%s,%s,%s/after', s:portable, &runtimepath, s:portable)

set nocompatible              " be iMproved, required
filetype off                  " required -> turned on later after plugin are loaded
"*****************************************************************************
"" Vim-Plug install packages
"*****************************************************************************
"{{{
" Install via: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
"
" original repos on github
" Plug 'shime/vim-livedown'
" Plug 'juneedahamed/svnj.vim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'tshirtman/vim-cython'
" Plug 'editorconfig/editorconfig-vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'kana/vim-fakeclip'
Plug 'mxw/vim-jsx'
" Plug 'fidian/hexmode'
Plug 'tpope/vim-fugitive'
" wrapper around unix commands
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-git'
" aligning text (e.g. tables) on multiple lines
" Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-surround'
Plug 'vim-scripts/matchit.zip'
Plug 'SirVer/ultisnips'
" Snippets are separate from ultisnips engine
Plug 'honza/vim-snippets'
Plug 'scrooloose/syntastic'
" if has('patch-8.1.2269')
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer'}
" else
"     Plug 'ycm-core/YouCompleteMe', { 'commit':'d98f896', 'do': './install.py --clang-completer'}
" endif

" Plug 'yegappan/mru'
Plug 'kien/ctrlp.vim'
" Plug 'andviro/flake8-vim'
" Plug 'oplatek/Conque-Shell'
" Comment out not currently using plugins - vim startup slow
Plug 'will133/vim-dirdiff'

Plug 'mhinz/vim-startify'
" tail -f functionality
Plug 'vim-scripts/Tail-Bundle'
Plug 'morhetz/gruvbox'  " color theme

Plug 'tomtom/tcomment_vim'
Plug 's3rvac/AutoFenc'
Plug 'vim-scripts/Tabmerge'

call plug#end()
"}}}


"*****************************************************************************
"" PLUGIN SETTINGS
"*****************************************************************************
"{{{
filetype plugin indent on     " required!

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:gruvbox_contrast_light = 'hard'
silent! colorscheme gruvbox " interactively :colors mayansmoke

let g:fakeclip_terminal_multiplexer_type = 'tmux'
"" vim-scripts/UltiSnips
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets = '<c-o>' " terminal does not understand <c-tab>
let g:ultisnips_python_style = 'sphinx'
let g:ultisnips_author = 'Ondrej Platek'
let g:ultisnips_author_email = 'ondrej.platek@seznam.cz'


let g:ycm_python_binary_path = 'python3'
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_add_preview_to_completeopt = 1 " add preview string
let g:ycm_complete_in_comments = 1
let g:ycm_path_to_python_interpreter = 'python3'
let g:ycm_autoclose_preview_window_after_completion = 1 " close preview automaticly

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['/fsx/oplatek/*', '/home/oplatek/code/*', '/Users/oplatek/*']

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }


let g:jsx_ext_required = 0

" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length 120 --ignore=E126,E127,E128,E121,E203,E225,E226,E402,E731,F401,E302,W503'

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

let g:startify_show_files_number = 20
let g:startify_session_dir = '~/.vim/session'
let g:startify_show_sessions = 1

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

autocmd BufWritePre *.py execute ':Black'


set diffopt+=vertical

"}}}

"*****************************************************************************
"" GENERAL SETTINGS
"*****************************************************************************
"{{{
let mapleader=","
let g:mapleader=","
syntax on
set wildmenu
set wildignore=*.o,*~,*.pyc,.git\*,.hg\*,.svn\*
set wildmode=longest,list
set ruler
set magic " For regular expression turn magic on
set autoread " Reloads when file is changed externally
autocmd FileChangedShell *
        \ echohl WarningMsg |
        \ echo "File has been changed outside of vim." |
        \ echohl None
set smartcase " If searching try to be smart
set clipboard=unnamed ""+y, "+p for like system clipboard
set confirm " Confirmation instead operation failure e.g :q
" set lazyredraw  " will not redraw the screen while running macros->faster
set nojoinspaces " does not put two spaces after join (like in US)
set completeopt=menuone,longest,preview
set hlsearch " syntax highlighting
set ffs=unix,mac,dos " Use Unix as the standard file type
silent! colorscheme mayansmoke " interactively :colors mayansmoke
let g:tex_flavor='latex'

" start of default statusline
set statusline=%f\ %h%w%m%r\
" Info part of status line statusline
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{fugitive#statusline()}
set statusline+=%*

" end of default statusline (with ruler)
set statusline+=%=%(%l,%c%V\ %=\ %P%)

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

"autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif  " TODO document what does it do?


" Encoding: Using Autofenc
" good if a)enca program installed b) encoding specified in header
set enc=utf8 tenc=utf8 fenc=utf8 fencs=ucs-bom,utf8,iso-8859-2,ascii
if $LC_CTYPE=="cs_CZ.ISO-8859-2"|set tenc=iso-8859-2|endif
"au BufReadPost * if &fenc=="ascii"|set fenc=utf8|endif

" Key mapping: switch keymaps
map <S-Tab> :if &keymap==''\|set keymap=czech\|else\|set keymap=\|endif<CR>
" ensure sane defaults
set nocp ru ls=2 nosm smd is bs=indent,eol,start nf=alpha
set nowmnu wim=longest,list,full mouse=iv kmp=czech imi=0 ims=0 noimc
set nospell  " spell checks are slow on large files -> See augroup group_spell where it is enabled
set spl=en
" spellcheck: command; ]S next error; zg add to spelldic; z= correct from spelldic
map <silent> <F1> :if !&spell\|set spl=csa spell\|elseif &spl=='csa'\|set spl=en spell\|else\|set nospell\|endif<CR>


" Formatting
set autoindent
set expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=2 foldlevelstart=99

" Persistent undo - Enable undo that lasts between sessions.
if has("persistent_undo")
    set undofile
    set undolevels=1000   " How many undos
    set undoreload=10000  " number of lines to save for undo
    let &undodir = expand('$HOME/.vim-undo')
    if filewritable(&undodir) == 0 && exists("*mkdir")
        " If undodir doesn't exist try create one(BUG-should be solved)
        " http://code.google.com/p/vim-undo-persistence/source/detail?r=70
        call mkdir(&undodir, "p", 0700)
    endif
    augroup persistent_undo
        au!
        au BufWritePre /tmp/*,*.tmp,*.log,*.bak,*.scratch,*.vim-scratch setlocal noundofile
    augroup END
endif
"}}}

"*****************************************************************************
"                                 Autocommands
"*****************************************************************************
"{{{
" Why groups? http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
augroup group_quickfix_enter
    autocmd!
    autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
augroup END
augroup group_quickfix_leave
    autocmd!
autocmd BufWinLeave * if exists("g:qfix_win")&&expand("<abuf>")==g:qfix_win|unlet! g:qfix_win|endif
augroup END
augroup group_spell
    autocmd!
    autocmd FileType tex,markdown,html,wiki setlocal spell
augroup END

function ProgramSet()
    setlocal number fdm=syntax fo=tcqnl1 formatlistpat=^\\s*\\%\\(\\d\\+\\\|[A-Za-z]\\\|[IVXLCDM]\\+\\)[\\]:.)}\\t]\\s*
    if exists('+colorcolumn')
        setlocal colorcolumn=89
    endif
endfunction

augroup group_program
    autocmd!
    autocmd FileType javascript,python,c,cpp,cs,java,sh,perl,pyrex,make,tex call ProgramSet()
augroup END

" Foldmethod
augroup group_hashtag_comment
    autocmd!
    autocmd FileType gdb,txt setlocal comments=sO:\#\ -,mO:\#\ \ ,fO:\#,:\#  " comments in gdbinit and in requirements.txt
augroup END

augroup filetype_python
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
augroup END
augroup group_comment_marker
    autocmd!
    autocmd FileType vim,tex setlocal foldmethod=marker
augroup END
" Comments

augroup filetypedetect
    au BufNewFile,BufRead *.tex,*.Rnw setf tex
augroup END

" Fix bug where crontab cannot use Vim backup files & crontab is complaining:
" crontab: temp file must be edited in place
autocmd filetype crontab setlocal nobackup nowritebackup

" fswitch
au! BufEnter *.cpp,*.cc,*.c let b:fswitchdst = 'h,hpp'
au! BufEnter *.h,*hpp let b:fswitchdst = 'cc,cpp'
"}}}

"*****************************************************************************
"                                  Mappings
"*****************************************************************************
"{{{
nnoremap <Leader>d :YcmCompleter GetDoc<Cr>
nnoremap <Leader>f :YcmCompleter GoTo<Cr>
nnoremap <Leader>r :YcmForceCompileAndDiagnostics<CR>
nnoremap <Leader>c :YcmDiags<CR>

" fswitch
nnoremap <Leader>s :FSHere<CR>


nnoremap <C-n> :put=''<CR>
imap kk <Esc>
" open any filetype and http://url_links in external apps on Linux
map <Leader>o :silent !xdg-open <cfile> > /dev/null 2>&1 & <CR>
map <Leader>e :Explore <CR>
map <Leader>v :Vexplore <CR>

" Quickfix and errors
map <silent> <F8> :if exists("g:qfix_win")\|ccl\|else\|cope\|endif<Cr>|map! <F8> <C-o><F8>
noremap <Leader>cp :cp<Cr>
noremap <Leader>cn :cn<Cr>
"}}}
