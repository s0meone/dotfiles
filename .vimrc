let mapleader = " "

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Core
Plugin 'VundleVim/Vundle.vim'              " Plugin manager

" Languages
Plugin 'tpope/vim-haml'                    " HAML, SASS, SCSS highlighting
Plugin 'vim-ruby/vim-ruby'                 " Ruby highlighting
Plugin 'hail2u/vim-css3-syntax'            " CSS3 highlighting
Plugin 'pangloss/vim-javascript'           " JavaScript highlighting
Plugin 'HerringtonDarkholme/yats.vim'      " TypeScript highlighting
Plugin 'mxw/vim-jsx'                       " JSX highlighting
Plugin 'fleischie/vim-styled-components'   " StyledComponents highlighting
Plugin 'pearofducks/ansible-vim'           " Ansible highlighting
Plugin 'tpope/vim-rails'                   " Rails helpers
Plugin 'Keithbsmiley/rspec.vim'            " RSpec helpers
Plugin 'lmeijvogel/vim-yaml-helper'        " YAML helpers
Plugin 'fatih/vim-go'                      " Golang highlighting and helpers

" Features
Plugin 'lifepillar/vim-solarized8'         " Colorscheme
Plugin 'scrooloose/nerdtree'               " Project drawer
Plugin 'tpope/vim-projectionist'           " Add switching to alternative files easier
Plugin 'tpope/vim-endwise'                 " Add smart end to Ruby methods
Plugin 'tpope/vim-repeat'                  " Add smart repeat
Plugin 'tpope/vim-surround'                " Add/replace/remove surrounding quotes etc
Plugin 'tpope/vim-fugitive'                " Add git integration
Plugin 'tpope/vim-abolish'                 " Add smart search/replace
Plugin 'junegunn/fzf.vim'
Plugin 'christoomey/vim-tmux-navigator'    " Navigate in and out tmux panels and vim buffers
Plugin 'benmills/vimux'                    " Run commands in tmux
Plugin 'jgdavey/vim-turbux'                " Run spec in tmux
Plugin 'w0rp/ale'                          " Lint/Syntax/Error checker
Plugin 'geoffharcourt/vim-matchit'         " Extend % to match more
Plugin 'kana/vim-textobj-user'             " Basis for creating textobjects
Plugin 'kana/vim-textobj-entire'           " Text object for entire file
Plugin 'nelstrom/vim-textobj-rubyblock'    " Text objects for Ruby methods
Plugin 'nathanaelkane/vim-indent-guides'   " Indent guides
Plugin 'tomtom/tcomment_vim'               " Smart code comments
Plugin 'AndrewRadev/switch.vim'            " Switch text
Plugin 'yssl/QFEnter'                      " Allow key mappings in Quicklist and Location list
Plugin 'chrisbra/Colorizer'                " Show color codes as colors inline

call vundle#end()

syntax enable
filetype plugin indent on

" Styling stuff
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set fillchars+=vert:│
set background=dark
colorscheme solarized8

" <F7> toggles background mode
noremap <F7> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

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
set nolazyredraw                   " redraw faster
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
set colorcolumn=115                " 115 is the GitHub width
set autoread                       " reload files only changed outside vim from disk

" change cursor when in insert mode (also works in tmux)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" fix mouse after column 223
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" configure ruby indent
" let g:ruby_indent_access_modifier_style = 'outdent'

" configure switch.vim
let g:switch_mapping = '-'
let g:switch_custom_definitions =
      \ [
      \   ['it', 'xit'],
      \   ['if', 'unless'],
      \   ['context', 'describe'],
      \   {
      \     '"\(.\{-}\)"': '`\1`',
      \     '`\(.\{-}\)`': '{`\1`}',
      \     '{`\(.\{-}\)`}': '"\1"',
      \   }
      \ ]

" configure qfenter
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" configure fzf
set rtp+=/usr/local/opt/fzf
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

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
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType gitcommit setlocal colorcolumn=72

" do not write backup files for crontab
autocmd FileType crontab setlocal nobackup nowritebackup

" create temp/backup directories if they don't exist
silent execute '!mkdir -p ~/.vim/backup'
silent execute '!mkdir -p ~/.vim/tmp'
silent execute '!mkdir -p ~/.vim/undo'

" configure ale
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  return l:counts.total == 0 ? '' : printf(
        \   '[%d %s]',
        \   counts.total,
        \   l:counts.total == 1 ? 'error' : 'errors'
        \)
endfunction

let g:ale_fixers = {
      \  'javascript': ['prettier'],
      \  'typescript': ['prettier'],
      \  'css': ['prettier'],
      \  'ruby': ['prettier']
      \}

let g:ale_linters = {
      \  'go': ['gofmt', 'govet']
      \}

let g:ale_sign_error = '»'
let g:ale_sign_warning = '»'
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1

augroup loclistwrap
  autocmd!
  autocmd FileType qf setlocal wrap linebreak
augroup END

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
set statusline+=\ %#modified#                   " change the color to red
set statusline+=%{LinterStatus()}               " show syntax errors
set statusline+=%*                              " reset color

" custom functions
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
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
  highlight clear SignColumn
  highlight clear ALEErrorSign
  highlight clear ALEWarningSign
  highlight clear VertSplit

  highlight ExtraWhitespace ctermbg=2 guibg=#859901
  highlight Modified ctermfg=7 ctermbg=9 guifg=#fdf6e3 guibg=#cb4b16

  if &g:background == 'dark'
    highlight IndentGuidesOdd ctermbg=8 guibg=#002b36
    highlight IndentGuidesEven ctermbg=0 guibg=#073642
    highlight SignColumn ctermbg=0 guibg=#073642
    highlight ALEErrorSign ctermfg=9 ctermbg=0 guifg=#cb4b16 guibg=#073642
    highlight ALEWarningSign ctermfg=9 ctermbg=0 guifg=#cb4b16 guibg=#073642
    highlight VertSplit guibg=#073642 guifg=#586e75
    highlight EndOfBuffer ctermfg=8 ctermbg=8 guifg=#002b36 guibg=#002b36
  else
    highlight IndentGuidesOdd ctermbg=15 guibg=#fdf6e3
    highlight IndentGuidesEven ctermbg=7 guibg=#eee8d5
    highlight SignColumn ctermbg=7 guibg=#eee8d5
    highlight ALEErrorSign ctermfg=9 ctermbg=7 guifg=#cb4b16 guibg=#eee8d5
    highlight ALEWarningSign ctermfg=9 ctermbg=7 guifg=#cb4b16 guibg=#eee8d5
    highlight VertSplit guibg=#eee8d5 guifg=#586e75
    highlight EndOfBuffer ctermfg=15 ctermbg=15 guifg=#fdf6e3 guibg=#fdf6e3
  endif
endfunc
call SetCustomColors()

augroup highlightstuff
  " highlight extra white space
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhitespace /\s\+$/

  " set the custom colors when switching the colorscheme
  au ColorScheme * call SetCustomColors()
augroup end

let NERDTreeIgnore=['\.git$', 'node_modules', '\.DS_Store$']
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeMapOpenSplit="<C-x>"
let NERDTreeMapOpenVSplit="<C-v>"
let NERDTreeStatusline = ' '

" enable flow in javascript
let g:javascript_plugin_flow = 1

let g:loclist_is_open = 0
function! ListToggle()
  if g:loclist_is_open == 1
    lclose
    let g:loclist_is_open = 0
  else
    lopen
    let g:loclist_is_open = 1
  endif
endfunction

" auto color
let g:colorizer_auto_filetype='css,html,sass,scss,jsx'
let g:colorizer_auto_map = 1

" keymappings
"
" ,ss strip whitespace
nnoremap <Leader>ss :call StripWhitespace()<CR>
" ,n reveal in tree
noremap <Leader>n :NERDTreeFind<CR>
" ,m toggle tree
noremap <Leader>m :NERDTreeToggle<CR>
" " ,r reload vimrc
" noremap <Leader>r :so $MYVIMRC<CR>
" ,q close
noremap <Leader>q :q<CR>
" ,w write
nnoremap <Leader><Leader> :w<CR>
" ,h stop highlight
nnoremap <Leader>h :noh<CR>
" easier navigation between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" ,tt run all specs in tmux
nnoremap <Leader>tt :call VimuxRunCommand("rspec")<CR>
" send ctrl+c to tmux
nnoremap <C-c> :call VimuxRunCommand("\3")<CR>
" indent with > and < but keep the visual selection
vnoremap > >gv
vnoremap < <gv
" ,db runs migrate alias in tmux
nnoremap <Leader>db :call VimuxRunCommand("migrate")<CR>
" ,bi runs bundle install
nnoremap <Leader>bi :call VimuxRunCommand("bundle install")<CR>
" ,. go to last changed position
noremap <Leader>. `.zz
" ,gx opens gui git
nnoremap <Leader>gx :silent execute "!gittower . &>/dev/null &" <BAR> redraw!<CR>
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
nnoremap <Leader>o o<ESC>
" ,O add empty line below without entering insert mode
nnoremap <Leader>O O<ESC>
" ,j
nnoremap <Leader>j :%!python -m json.tool<CR>
" ,\
noremap <Leader>\ :TComment<CR>
" <F6> toggles paste mode
nnoremap <silent> <F6> :call PasteOnOff()<CR>
" <F5> redraws
nnoremap <silent> <F5> :redraw!<CR>
" center search matches when jumping
noremap N Nzz
noremap n nzz
" reselect last pasted/edited text
nnoremap <expr> gs line("']")==line("'[") ? "`[v`]" : "'[V']"
xmap gs <ESC>gs
" <leader>a goes to alternative file and last edit position
nnoremap <Leader>a :A<CR>`.
" paste without replacing the register
nnoremap <leader>p p`[v`]=
" this mapping: change inside entire file, is annoyingly close to ciw
nnoremap cie ciw
" replace text without overwriting register
vnoremap <leader>p "_dP
" sort
vnoremap <leader>s :sort<cr>
" <leader>w saves all files
nnoremap <leader>w :wa<cr>
" <leader>= reformats whole file
nnoremap <leader>= gg=G<C-o><C-o>
" exit now
nnoremap <C-d> :q<cr>
" do not include trailing/leading whitespace when selecting quoted strings
nnoremap va" v2i"
" get info
nnoremap <leader>? :ALEHover<cr>
" get details
nnoremap <leader>d :ALEDetail<cr>
" goto def
nnoremap <leader>g :ALEGoToDefinition<cr>
" goto first error
nnoremap <leader>/ :ALEFirst<CR>
" toggle loc list
nnoremap <leader>l <ESC>:call ListToggle()<CR>
" ,l runs the last command in tmux
nnoremap <Leader>r :VimuxRunLastCommand<CR>

nnoremap <leader>f :Ag<CR>
nnoremap <leader>F :exe ":Ag " . expand("<cword>")<CR>
nnoremap <C-p> :FZF<CR>
nnoremap <ESC>[80;5u :exe ":FZF --query=" . expand("<cword>")<CR>
