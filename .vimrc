"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A ~*~Beautiful~*~ vimrc file
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Vundle/Plugins

set nocompatible
filetype off

" Set vundle location. This changes a bit based on whether we're in the
" dotfiles directory or not.
if getcwd() == '/Users/maxdelgiudice/dotfiles'
   set rtp+=.vim/bundle/Vundle.vim
else
   set rtp+=~/.vim/bundle/Vundle.vim
endif

call vundle#begin()

""" Plugins
Plugin 'gmarik/Vundle.vim'                  " Plugin manager
Plugin 'Shougo/vimproc.vim'                 " TODO Async Utility. Not sure if still needed?
Plugin 'easymotion/vim-easymotion'          " TODO Come back to this
Plugin 'ervandew/supertab'                  " Tab completion
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" {{{ fzf settings
  let g:statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>. :AgIn

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

  function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
  endfunction
  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

  function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  endfunction

  command! ProjectFiles execute 'Files' s:find_git_root()
" }}}
Plugin 'jnurmine/Zenburn'                   " My color scheme
Plugin 'altercation/vim-colors-solarized'   " vim colors
Plugin 'tpope/vim-fugitive'                 " Git integration
Plugin 'w0rp/ale'                           " Async linting tool
Plugin 'SirVer/ultisnips'                   " Snippets engine
Plugin 'honza/vim-snippets'                 " Snippets engine
Plugin 'Shougo/deoplete.nvim'               " Completion engine
" {{{ deoplete settings
  let g:deoplete#enable_at_startup = 1
" }}}
Plugin 'roxma/nvim-yarp'                    " Deoplete dependency
Plugin 'roxma/vim-hug-neovim-rpc'           " Deoplete dependency

" Clojure
Plugin 'tpope/vim-fireplace'                " REPL integration
Plugin 'vim-scripts/paredit.vim'            " Code editing features - balanced parens, etc

" Gradle
Plugin 'tfnico/vim-gradle'                  " Gradle syntax highlighting

" Haskell
Plugin 'dag/vim2hs'
" {{{ vim2hs settings
  let g:haskell_conceal_wide = 1
  let g:rct_completion_use_fri = 1
" }}}
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'

" Javascript
Plugin 'pangloss/vim-javascript'

" Latex
Plugin 'Latex-Box-Team/Latex-Box'           " Latex compiling shit
" {{{ latex-box settings
  let g:Tex_DefaultTargetFormat = "pdf"
  let g:Tex_ViewRule_pdf = "kpdf"
" }}}

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Obj-c
Plugin 'b4winckler/vim-objc'                " Syntax highlighting

" Python
Plugin 'nvie/vim-flake8'                    " Python style checker
Plugin 'tmhedberg/SimpylFold'               " Auto fold function defs, class defs, etc
" {{{ simplyfold settings
  let g:SimpylFold_docstring_preview=1
" }}}
Plugin 'vim-scripts/indentpython.vim'       " Auto indentation
Plugin 'deoplete-plugins/deoplete-jedi'     " Completion

" Racket
Plugin 'wlangstroth/vim-racket'             " Racket syntax highlighting

" Scala
Plugin 'derekwyatt/vim-scala'

" End vundle
call vundle#end()
filetype plugin indent on

" }}}

"{{{ Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"}}}

"{{{ Misc Settings

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Copy indent from current line to next line
set autoindent

" Replace tabs with spaces
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Set the compiler to gcc
compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Make backspace work
set backspace=2

" Add line numbers to files
set number

" Ignore case unless string contains uppercase letters
set ignorecase
set smartcase

inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Use + register for copy/paste
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4

" }}}

" {{{ Look and Feel

" Use zenburn

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Status line
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"{{{ Todo List Mode

function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction

"}}}

"}}}

" {{{ Mappings

" For navigating buffers
nnoremap <silent> gn :bn<CR>

" Next Tab
nnoremap <silent> <C-h> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-l> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" C code completion
let g:completekey = "<tab>"

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Testing
set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" }}}


filetype plugin indent on
syntax on
