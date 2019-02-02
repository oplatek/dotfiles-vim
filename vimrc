" silent python print 'using python2'
" TODO profile vimrc so it loads quickly - especially autocmds via 'vim --startuptime vim.log'
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


"*****************************************************************************
"" Vundle Load
"*****************************************************************************
"{{{
" Load vundle
" no vi-compatible
set nocompatible

" Setting up Vundle - the vim plugin bundler
let s:vundle_readme=expand(printf('%s/bundle/vundle/README.md', s:portable))
let s:bundle_dir = s:portable . '/bundle'
let s:vundle_dir = s:bundle_dir . '/vundle'
if !filereadable(s:vundle_readme)
  echo "Installing Vundle..."
  echo "Type :BundleInstall for installing the plugins"
  execute 'silent !mkdir -p ' . s:bundle_dir
  execute 'silent !git clone https://github.com/gmarik/vundle ' . s:vundle_dir
endif

" required for vundle
filetype off

" add the bundle directory to 'runtimepath'
let &runtimepath = printf('%s/bundle/vundle,%s', s:portable, &runtimepath)
call vundle#rc(s:bundle_dir)

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
"}}}

"*****************************************************************************
"" Vundle install packages
"*****************************************************************************
"{{{
"
" original repos on github
" Bundle 'shime/vim-livedown'
" Bundle 'juneedahamed/svnj.vim'
" Bundle 'editorconfig/editorconfig-vim'
" Bundle 'tshirtman/vim-cython'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'kana/vim-fakeclip'
Bundle 'mxw/vim-jsx'
" Bundle 'fidian/hexmode'
Bundle 'tpope/vim-fugitive'
" wrapper around unix commands
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-git'
" aligning text (e.g. tables) on multiple lines
" Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
" Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/matchit.zip'
Bundle 'SirVer/ultisnips'
" Snippets are separate from ultisnips engine
Bundle 'honza/vim-snippets'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
" Bundle 'yegappan/mru'
Bundle 'kien/ctrlp.vim'
" Bundle 'andviro/flake8-vim'
" Bundle 'oplatek/Conque-Shell'
" Comment out not currently using plugins - vim startup slow
Bundle 'DirDiff.vim'
Bundle 'mhinz/vim-startify'

" vim-scripts at www.vim.org
Bundle 'tComment'
" Bundle 'taglist.vim'
Bundle 'mayansmoke'
"alternate files
" Bundle 'a.vim'
Bundle 's3rvac/AutoFenc'
" Bundle 'bling/vim-airline'
Bundle 'vim-scripts/Tabmerge'
" Bundle 'vim-scripts/gtags.vim'
" TODO explore hewes/unite-gtags

"}}}


"*****************************************************************************
"" PLUGIN SETTINGS
"*****************************************************************************
"{{{
filetype plugin indent on     " required!

let g:fakeclip_terminal_multiplexer_type = 'tmux'
"" vim-scripts/UltiSnips
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
" let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsListSnippets = '<c-o>' " terminal does not understand <c-tab>
let g:ultisnips_python_style = 'sphinx'
let g:ultisnips_author = 'Ondrej Platek, Ufal MFF UK'
let g:ultisnips_author_email = 'oplatek@ufal.mff.cuni.cz'


let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_add_preview_to_completeopt = 1 " add preview string
let g:ycm_complete_in_comments = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
" let g:ycm_autoclose_preview_window_after_completion = 1 " close preview automaticly
let g:ycm_global_ycm_extra_conf = '' "where to search for .ycm_extra_conf.py if not found


" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'


let g:jsx_ext_required = 0

" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E126,E127,E128,E121,E225,E226,E401,E402,E501,W291'

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


set diffopt+=vertical

"}}}

"*****************************************************************************
"" GENERAL SETTINGS
"*****************************************************************************
"{{{
let mapleader=","
let g:mapleader=","
syntax on
filetype plugin on
set nocompatible               " be iMproved
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
set ffs=unix,dos,mac " Use Unix as the standard file type
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

autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

if has('gui_running')
    set guifont=-misc-fixed-medium-r-normal--15-*-iso8859-2
    if has('gui_gtk2')
      set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
    elseif has('gui_Photon')
      set guifont=Bitstream\ Vera\ Sans\ Mono:s11
    elseif has('gui_kde')
     set guifont=Bitstream\ Vera\ Sans\ Mono/11/-1/5/50/0/0/0/1/0
    elseif has('x11')
     set guifont=*-lucidatypewriter-medium-r-normal-*-*-110-*-*-m-*-*
    else
     set guifont=Lucida_Console:h11:cDEFAULT
    endif
    "disables icons shows only tooltips
    set tb=
endif

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

set nospell
set spl=en
" spellcheck: command; ]S next error; zg add to spelldic; z= correct from spelldic
map <silent> <F1> :if !&spell\|set spl=csa spell\|elseif &spl=='csa'\|set spl=en spell\|else\|set nospell\|endif<CR>


" Formatting
filetype indent on
set autoindent smartindent
set expandtab smarttab tabstop=4 shiftwidth=4 softtabstop=4 foldlevelstart=99

" Persistent undo
if has("persistent_undo")
" Enable undo that lasts between sessions.
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
    autocmd FileType tex,text,markdown,html,wiki setlocal spell
augroup END
" autocmd BufEnter * let &titlestring=":Vim:" . expand("%:t") | set title  " FIXME DO I MISS IT?

function ProgramSet()
    setlocal number fdm=syntax fo=tcqnl1 formatlistpat=^\\s*\\%\\(\\d\\+\\\|[A-Za-z]\\\|[IVXLCDM]\\+\\)[\\]:.)}\\t]\\s*
    if exists('+colorcolumn')
        setlocal colorcolumn=79
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
augroup gropu_comment_marker
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
"}}}

"*****************************************************************************
"                                  Mappings
"*****************************************************************************
"{{{
nnoremap <Leader>d :YcmCompleter GetDoc<Cr>
nnoremap <Leader>f :YcmCompleter GoTo<Cr>
nnoremap <Leader>r :YcmForceCompileAndDiagnostics<CR>
nnoremap <Leader>c :SyntasticCheck<CR>


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
