let t_Co=256

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'jgdavey/vim-turbux'
Plugin 'scrooloose/syntastic'
Plugin 'othree/xml.vim'
Plugin 'edsono/vim-matchit'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'tpope/vim-haml'
Plugin 'tomtom/tcomment_vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mxw/vim-jsx'
Plugin 'groenewege/vim-less'
" Plugin 'flowtype/vim-flow'
Plugin 'pearofducks/ansible-vim'

call vundle#end()
syntax enable

filetype on
filetype plugin on
filetype plugin indent on

" Solarized stuff
set background=dark
colorscheme solarized

set backup                         " enable backup
set undofile                       " enable persistent undo
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/undo
set showcmd                        " show current command in status bar
set showmatch                      " show matching braces
set ruler                          " always show the line info
set hlsearch                       " highlight search results
set incsearch                      " search as the expression is being typed
" set ignorecase                     " ignore case when searching and autocompleting
set number                         " show line numbers
set noerrorbells                   " beeps = no
set visualbell                     " visual bellz
set tabstop=2                      " 1 tab = 2 spaces
set shiftwidth=2                   " indenting
set shiftround                     " when at 3 spaces and I hit >>, go to 4, not 5.
set autoindent                     " it does what it says
set shell=/bin/sh                  " zshell as shell
set nofoldenable                   " who uses this anyway?
set clipboard=unnamed              " yank to clipboard
set nowrap                         " don't wrap lines
set expandtab                      " use spaces, not tabs
set backspace=indent,eol,start     " backspace through everything in insert mode
set laststatus=2                   " always show the status window
set linespace=0                    " set linespace to 0 so it looks pleasing
set nocursorline                   " do not highlight current line
set lazyredraw                     " redraw faster
set synmaxcol=1024                 " don't highlight long lines
set switchbuf=useopen              " switch focus to buffer instead of opening a new split
set splitbelow                     " more natural splits
set splitright                     " more natural splits
set equalalways                    " always equal splits
set mouse=a                        " enables mouse support in all modes
set wildmenu                       " show autocomplete options in status bar
set scrolloff=5                    " keep some distance to the bottom"
set wildmode=longest,list,full     " better command line autocomplete
set nohidden                       " remove buffer when closed
set ttyfast                        " we have a fast terminal
set colorcolumn=115                " 115 is the Github width
set autoread                       " reload files only changed outside vim from disk

" change cursor when in insert mode (also works in tmux)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" configure ruby indent
let g:ruby_indent_access_modifier_style = 'outdent'

" configure switch.vim
let g:switch_mapping = '-'
let g:switch_custom_definitions =
      \ [
      \   ['it', 'xit'],
      \   ['if', 'unless'],
      \   ['context', 'describe']
      \ ]

" config syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_ruby_exec='/usr/local/opt/rbenv/versions/2.2.2/bin/ruby'
let g:syntastic_ignore_files=['^/usr/include/', '\c\.scss$', '\c\.sass$', '\c\.html.erb$']
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['flow', 'eslint']

" configure ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp\|coverage\|app\/assets\/images\|public\/assets\|build$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_root_markers = ['.ctrlp']

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" make switching modes fast again
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" configure git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal colorcolumn=72

" do not write backup files for crontab
autocmd filetype crontab setlocal nobackup nowritebackup

" create temp/backup directories if they don't exist
silent execute '!mkdir -p ~/.vim/backup'
silent execute '!mkdir -p ~/.vim/tmp'
silent execute '!mkdir -p ~/.vim/undo'

" statusline configuration
set statusline=[%c,%l/%L]                       " show current position and line count as: [column,current/total]
set statusline+=%{&readonly?'\ [READ-ONLY]':''} " show readonly indicator
set statusline+=%{&readonly&&&modified?'\ ':''} " need to add an extra space for some reason, when both true
set statusline+=%{&modified?'\ ':''}            " show modified indicator
set statusline+=%#modified#
set statusline+=%{&modified?'\[MODIFIED]':''}   " show modified indicator
set statusline+=%*
set statusline+=\ %y                            " show file type
set statusline+=\ [%t]                          " show file name
set statusline+=\ %#warningmsg#                 " change the color to red
set statusline+=%{SyntasticStatuslineFlag()}    " show syntax errors
set statusline+=%*                              " reset color
" set statusline+=%=                              " align on the right
" set statusline+=\ [%b][0x%B]                    " ASCII and byte code under cursor
" set statusline+=\ %{fugitive#statusline()}      " show git status

let mapleader = " "

" custom functions
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" grep search
function! SearchInProject(...)
  if a:0 > 0
    let keyword = a:1
  else
    let keyword = input('Search for: ')
  endif

  if keyword != ""
    exec ':grep! "' . keyword . '" | cw'
    let @/ = keyword
    set hlsearch
    redraw!
  endif
endfunction

" paste toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! PasteOnOff()
  if g:paste_mode == 0
    exec ':echo "Paste mode enabled"'
    set paste
    let g:paste_mode = 1
  else
    exec ':echo "Paste mode disabled"'
    set nopaste
    let g:paste_mode = 0
  endif
  return
endfunc

augroup filetypedetect
  au BufNewFile,BufRead *.html.erb set filetype=eruby.html
  au BufNewFile,BufRead *.js.erb set filetype=eruby.javascript
  au BufNewFile,BufRead *.jsx.erb set filetype=eruby.javascript
  au BufNewFile,BufRead *.css.erb set filetype=eruby.css

  au BufNewFile,BufRead *.axlsx set filetype=ruby

  au BufNewFile,BufRead Snapfile set filetype=ruby
  au BufNewFile,BufRead Appfile set filetype=ruby
  au BufNewFile,BufRead Fastfile set filetype=ruby
  au BufNewFile,BufRead Deliverfile set filetype=ruby
augroup end

" set indent guides
let g:indent_guides_auto_colors = 0

func! SetCustomColors()
  " highlight useless spaces
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

  " define custom colors
  highlight WarningMsg term=bold cterm=bold ctermfg=7 ctermbg=9
  highlight Modified term=bold cterm=bold ctermfg=7 ctermbg=9

  syn keyword grapeKeyword desc params post get put delete options resource requires
  syn match Comment "^.*desc\s\".*\"$"

  highlight def link grapeKeyword Identifier
  highlight def link grapeDesc Comment

  if &g:background == 'dark'
    hi IndentGuidesOdd  ctermbg=8
    hi IndentGuidesEven ctermbg=0
  else
    hi IndentGuidesOdd  ctermbg=15
    hi IndentGuidesEven ctermbg=7
  endif
endfunc
call SetCustomColors()

augroup highlightstuff
  " highlight spaces on an empty line
  au BufEnter * match ExtraWhitespace /\s\+\%#\@!$/

  " set the custom colors when switching the colorscheme
  au ColorScheme * call SetCustomColors()
augroup end

" command to turn off slow features, so we can read large files easily
command! LargeFile set syntax=off | NoMatchParan

" <F7> toggles background mode
call togglebg#map("<F7>")

let NERDTreeIgnore=['\.git$', 'node_modules', '\.DS_Store$']
let NERDTreeShowHidden=1

" keymappings
"
" ,ss strip whitespace
noremap <Leader>ss :call StripWhitespace()<CR>
" ,n reveal in tree
noremap <Leader>n :NERDTreeFind<CR>
" ,m toggle tree
noremap <Leader>m :NERDTreeToggle<CR>
" ,r reload vimrc
noremap <Leader>r :so $MYVIMRC<CR>
" ,q close
noremap <Leader>q :q<CR>
" ,w write
noremap <Leader><Leader> :w<CR>
" ,h stop highlight
noremap <Leader>h :noh<CR>
" easier navigation between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" ,tt run all specs in tmux
noremap <Leader>tt :call VimuxRunCommand("rspec")<CR>
" send ctrl+c to tmux
noremap <C-c> :call VimuxRunCommand("\3")<CR>
" sudo save file
cmap w!! w !sudo tee > /dev/null %
" indent with > and < but keep the visual selection
vnoremap > >gv
vnoremap < <gv
" ,db runs migrate alias in tmux
noremap <Leader>db :call VimuxRunCommand("migrate")<CR>
" ,bi runs bundle install
noremap <Leader>bi :call VimuxRunCommand("bundle install")<CR>
" ,. go to last changed position
noremap <Leader>. `.zz
" ,gx opens gui git
noremap <Leader>gx :silent execute "!gittower . &>/dev/null &" <BAR> redraw!<CR>
" ,d remove line without registering it
noremap <Leader>dd "_dd
" ,l runs the last command in tmux
noremap <Leader>l :VimuxRunLastCommand<CR>
" ,z grow current split to max size
noremap <Leader>z <C-w><BAR><C-w>_
" ,Z make all splits the same size
noremap <Leader>Z <C-w>=
" resize panels with alt+hjkl, this is interesting as well:
" https://github.com/tomtom/tinykeymap_vim/
noremap ˙ <C-w>5>
noremap ∆ <C-W>5-
noremap ˚ <C-W>5+
noremap ¬ <C-w>5<
" ,o add empty line below without entering insert mode
noremap <Leader>o o<ESC>
" ,O add empty line below without entering insert mode
noremap <Leader>O O<ESC>
" ,j
noremap <Leader>j :%!python -m json.tool<CR>
" ,\
noremap <Leader>\ :TComment<CR>
" <F6> toggles paste mode
nnoremap <silent> <F6> :call PasteOnOff()<CR>
" <F5> redraws
nnoremap <silent> <F5> :redraw!<CR>
" ,f search in project
nnoremap <LEADER>f :call SearchInProject()<CR>
" ,F search for the current word in project
nnoremap <LEADER>F :call SearchInProject(expand('<cword>'))<CR>
" center search matches when jumping
noremap N Nzz
noremap n nzz
" reselect last pasted/edited text
nnoremap <expr> gs line("']")==line("'[") ? "`[v`]" : "'[V']"
xmap gs <ESC>gs
" Q runs the q macro
nnoremap Q @q
xnoremap Q @q
" <leader>a goes to alternative file and last edit position
nnoremap <Leader>a :A<CR>`.
nnoremap <Leader>rr :w<cr>:SyntasticCheck rubocop<cr>
nnoremap <leader>p p`[v`]=
" this mapping: change inside entire file, is annoyingly close to ciw
nnoremap cie ciw
