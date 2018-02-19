set t_Co=256
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
set directory^=$HOME/.vim/tmp//
set cursorline
set showcmd
set number
set hidden
set hlsearch
set backspace=2
let mapleader=","
autocmd Filetype html setlocal ts=4 sts=4 sw=4 omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.coffee set ft=coffee
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
autocmd bufread Cakefile set ft=coffee
if has('nvim')
    let s:editor_root=expand("~/.nvim")
else
    let s:editor_root=expand("~/.vim")
endif
if has("unix")
    let s:uname = system("uname")
    let g:python_host_prog='/usr/bin/python'
    if s:uname == "Darwin\n"
        let g:python_host_prog='/usr/bin/python'
    endif
endif

" Setting up base16-shell
"let base16_installed=1
"let base16_readme="~/.config/base16-shell/README.md"
"if !filereadable(base16_readme)
"    echo "Install base16-shell"
"    echo ""
"    silent execute "!git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell"
"    let base16_installed=0
"endif

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/vundle/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    " silent execute "! mkdir -p ~/." . s:editor_path_name . "/bundle"
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/gmarik/vundle " . s:editor_root . "/bundle/vundle"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root . '/bundle')

Plugin 'gmarik/vundle.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jasoncodes/ctrlp-modified.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'vim-scripts/taglist.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'thinca/vim-localrc'
Plugin 'kchmck/vim-coffee-script'
Plugin 'groenewege/vim-less'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'rstacruz/sparkup'
Plugin 'tomtom/tcomment_vim'
"Plugin 'SirVer/ultisnips'
Plugin 'rhysd/vim-grammarous'
Plugin 'honza/vim-snippets'
Plugin 'rodjek/vim-puppet'
Plugin 'vim-scripts/argtextobj.vim'
Plugin 'vim-scripts/pydoc.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'hashivim/vim-hashicorp-tools'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
" Setting up Vundle - the vim plugin bundler end

set laststatus=2

filetype plugin indent on

inoremap jj <Esc>
nnoremap <leader>m :w <BAR> !lessc %:t:r.css<CR><space>
nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <leader>ne :NERDTreeTabsOpen<cr>
nmap <leader>nt :NERDTreeTabsOpen<cr>
nmap <leader>nq :NERDTreeTabsClose<cr>
map <leader>n :bn<cr>
map <leader>p :bp<cr>
nmap <silent> <leader>l :set list!<CR>
map <silent> <leader>/ :let @/ = ""<CR>

set listchars=tab:▸\ ,eol:¬

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree']

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['\.pyc$']

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
let &colorcolumn="110,".join(range(116,999),",")

let g:syntastic_check_on_open = 1

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_theme="dark"
" Required for CtrlSpace integration
let g:airline_exclude_preview = 1
" End CtrlSpace integration
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'warning' ]
    \ ]

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|site-packages|node_modules)$',
    \ 'file': '\v\.(exe|so|dll|pyc|debug\.js|simple\.js)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_reuse_window = 'startify'

let g:clang_library_path = '/usr/lib/llvm-3.2/lib/'

let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z' ]
      \ ]

let g:ctrlspace_project_root_markers = [".git", ".hg", ".svn", ".bzr", "_darcs", "CVS", "proj.sln"]

" Set up ultisnips - need to symlink vim scripts to be run when files are opened
if !isdirectory(s:editor_root . "/ftdetect")
    silent execute "!ln -s " . s:editor_root . "/bundle/ultisnips/ftdetect " . s:editor_root . "/"
endif
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="sphinx"
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_core_mode = 'external_command'

" fugitive git bindings
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>gob :AsyncRun git checkout -b<Space>
nnoremap <Leader>gps :AsyncRun git push<CR>
nnoremap <Leader>gpl :AsyncRun git pull<CR>

" Quickfix bindings
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>

" clearsearch binding
nnoremap <Leader>cs :noh<CR>

" set viminfo='100,n$HOME/.vim/files/info/viminfo " Change to nvim agnostic path if necessary

function! NumberOfWindows()
  let i = 1
  while winbufnr(i) != -1
  let i = i+1
  endwhile
  return i - 1
endfunction

function! DonotQuitLastWindow()
  if NumberOfWindows() != 1
    let v:errmsg = ""
    silent! quit
    if v:errmsg != ""
        "echohl ErrorMsg | echomsg v:errmsg | echohl NONE
        "echoerr v:errmsg
        echohl ErrorMsg | echo v:errmsg | echohl NONE
    endif
  else
     echohl Error | echo "Can't quit the last window..." | echohl None
  endif
endfunction

if has("gui_running")
    cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'call DonotQuitLastWindow()' : 'q'
    cnoreabbrev <expr> qa getcmdtype() == ":" && getcmdline() == 'qa' ? 'call DonotQuitLastWindow()' : 'qa'
endif

set bg=dark
"colorscheme base16-default-dark 

hi Search ctermfg=237 ctermbg=13
hi MatchParen cterm=underline
hi SyntasticWarning ctermbg=yellow ctermfg=black
hi SyntasticError ctermbg=red ctermfg=black

hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE

let &titleold=substitute(system("uname"),'\(.*\)\n','%\1%','')
let &titlestring = expand("%:p")
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term =~ "xterm" || &term =~ "nvim"
  set title
endif
