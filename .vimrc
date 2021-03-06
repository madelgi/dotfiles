"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A ~*~Beautiful~*~ vimrc file
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" {{{ Vundle/Plugins

" Turn off compatibility with vi and filetype detection (temporarily)
set nocompatible

call plug#begin('~/.vim/plugged')

""" Plugins
" General plugins
Plug 'gmarik/Vundle.vim'                  " Plug manager
Plug 'Shougo/vimproc.vim'                 " TODO Async Utility. Potentially still needed, even w/ noevim.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jnurmine/Zenburn'                   " My color scheme
Plug 'altercation/vim-colors-solarized'   " vim colors
Plug 'tpope/vim-fugitive'                 " Git integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'                 " Snippets engine
" Plug 'SirVer/ultisnips'                   " Snippets engine

" Clojure
Plug 'tpope/vim-fireplace'                " REPL integration
Plug 'vim-scripts/paredit.vim'            " Code editing features - balanced parens, etc

" CSV
Plug 'chrisbra/csv.vim'

" Gradle
Plug 'tfnico/vim-gradle'                  " Gradle syntax highlighting

" GraphQL
Plug 'jparise/vim-graphql'

" Haskell syntax
Plug 'neovimhaskell/haskell-vim'

" Javascript/Typescript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
"Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Latex
Plug 'Latex-Box-Team/Latex-Box'           " Latex compiling stuff

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" nginx
Plug 'chr4/nginx.vim'

" Obj-c
Plug 'b4winckler/vim-objc'                " Syntax highlighting

" Python
Plug 'nvie/vim-flake8'                    " Python style checker
Plug 'tmhedberg/SimpylFold'               " Auto fold function defs, class defs, etc
Plug 'vim-scripts/indentpython.vim'       " Auto indentation
Plug 'tweekmonster/django-plus.vim'       " Django highlighting

" Racket
Plug 'wlangstroth/vim-racket'             " Racket syntax highlighting

" Scala
Plug 'derekwyatt/vim-scala'

" Toml
Plug 'cespare/vim-toml'

" Cypher
Plug 'neo4j-contrib/cypher-vim-syntax'

" Cloudformation
Plug 'NLKNguyen/cloudformation-syntax.vim'

" End vundle
call plug#end()

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

"}}}

"{{{ Misc Settings

" Mouse support
set mouse=a

" Display current command in bottom of screen
set showcmd

" Create folds w/ triple brace
set foldmethod=marker

" Syntax highlighting
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

" Tab completion for commands
set wildmenu
set wildmode=list:longest,full

" Enable backspace
set backspace=2

" Add line numbers to files
set number

" Ignore case unless string contains uppercase letters
set ignorecase
set smartcase

" Search as string is composed
set incsearch

" Highlight search results
set hlsearch

" Use + register for copy/paste
let g:clipbrdDefaultReg = '+'

" Remove buffer after closing tab
set nohidden

" Helps jedi find anaconda environments
" let $VIRTUAL_ENV = $CONDA_PREFIX

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

" Insetion mode completion
set completeopt=longest,menuone,preview

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

"}}}

" {{{ Mappings

" Remap double j to escape, quadruple J to no-op
inoremap jj <Esc>
nnoremap JJJJ <Nop>

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

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" }}}

" {{{ Fixes (should find actual reason why these commands are needed

" In python environments, css evaluates as python?
au BufRead,BufNewFile *.css set filetype=css
au BufRead,BufNewFile *.ejs set filetype=html
" Autocomplete issue with tsserver
" au BufNewFile,BufRead *.ts set filetype=javascript
" au BufNewFile,BufRead *.tsx set filetype=javascript

" }}}
