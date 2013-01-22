set nocompatible                " screw vi-compatible features
set encoding=utf-8              " utf-8 is fun
set nowrap

call pathogen#infect()          " pathogen
source ~/.vim/filetypes         " load awesome filetypes
runtime macros/matchit.vim      " load matchit (included with vim)

set hidden                      " don't yell when hiding modified buffers
set history=1000                " lots o' history
set clipboard=unnamed           " link vim and the system's clipboards
set visualbell                  " no beeping!
set showmatch                   " flash matching brackets and parens
set scrolloff=3                 " keep a few lines visible above and below cursor
set backupdir=~/.vim/_backup//  " store backup files
set directory=~/.vim/_tmp//     " store swap files
set undodir=~/.vim/_undo        " store undo history
set undofile
set undolevels=1000
set undoreload=10000
set splitbelow                  " I like my splits opening below
set splitright                  " and my vsplits opening to the right

set showcmd                     " show partial commands below status line
set cmdheight=2                 " 2-line command window
set textwidth=78                " break long lines at 80 characters

""" Searching
set hlsearch                    " highlight search results
set incsearch                   " highlight matches while searching
set ignorecase                  " ignore case when searching.
set smartcase                   " override ignorecase if search contains upper case

""" Whitespace
set shiftwidth=2                " use 2 spaces for indentation
set tabstop=2                   " use 2 spaces when tabbinb
set expandtab                   " use spaces instead of tabs because tabs are evil
set smarttab                    " backspacing deletes space-expanded tabs
set nojoinspaces                " never use two spaces when joining lines
set backspace=indent,eol,start  " allow backspacing over autoindent,
                                " line breaks, and start of insert

""" Tab completion
set wildmenu
set wildmode=list:full,full
set wildignore+=tmp/**,vendor/**,exec/**

""" Show invisible characters
set listchars=""                " reset the listchars
set listchars+=tab:\ \          " show tab as two spaces
set listchars+=trail:.          " show trailing whitespace as .
set listchars+=extends:>        " the character to show in the last column when
                                " wrap is off and line is too long.
set listchars+=precedes:<       " the character to show in the first column when
                                " wrap is off and line is too long.

""" Visual
syntax on                       " highlight my syntax plz
set cursorline                  " highlight cursor line
set colorcolumn=-1,-0           " highlight the 79th and 80th columns
set t_Co=256                    " more than 8 colors, kthx
set gfn=Source\ Code\ Pro:h18   " Menlo is another great font
colorscheme base16-default
set background=dark             " light also available

""" Status bar
set laststatus=2
set statusline=\ %f%(\ [%M%R%W%H]%)       " filename
set statusline+=%=                        " right align
set statusline+=%-14.(%l/%L,%v%)\ %<%P\   " offset

" Set window/terminal title
set title
set titlestring=%F                        " /path/to/file.txt (Vim)

""" Plugin Configuration
let g:ftplugin_sql_omni_key = '<C-X>' " use C-X instead of C-C in sql.vim
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=4
let g:netrw_liststyle=4
let g:ackprg = 'ag --nogroup --nocolor --column'

""" Mappings
let mapleader = ","

" I like comma for a leader, but I'd still like to use the original Normal mode
" comma command. Double comma should suffice.
nmap <leader><leader> ,<ESC>

" Can't be bothered to understand ESC vs <c-c> in insert mode
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L117-118
imap <c-c> <esc>

command! W :w " alias :w as :W to fight accidental typos

" Easy expansion of the active file directory. Cite: Practical Vim pg 94.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" delete the active buffer keeping the split open
map <leader>x :bprevious<cr>:bdelete #<cr>
map <leader>X :bdelete<cr>

nmap <leader>u :GundoToggle<CR>
nmap <leader><cr> :nohlsearch<CR>
nmap <leader>S :set spell<CR>]s
nmap <leader>ns :set nospell<CR>
nmap <leader>a :Ack<space>
nmap <leader>A :Ack!<space>

" yank until the end of the line
nmap Y y$

" split and tab management and navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-S-l> <C-w>l
nmap <leader>t :tabnext<cr>
nmap <leader>T :tabprevious<cr>

" Browsing
map <C-t> :CommandTFlush<cr>\|:CommandT<cr>

""" Ruby
imap <C-l> <Space>=><Space>
nmap <leader>R i, record: :new_episodes<ESC>

""" Tabularize
nmap <leader>j vip:Tabularize json<CR>
vmap <leader>j :Tabularize json<CR>
vmap <leader>: :Tabularize first_colon<CR>
vmap <leader>l :Tabularize hash_rocket<CR>
vmap <leader>= :Tabularize first_equals<CR>
vmap <leader>' :Tabularize first_single_quote<CR>
vmap <leader>" :Tabularize first_double_quote<CR>
vmap <leader>{ :Tabularize first_left_stash<CR>
vmap <leader>} :Tabularize first_right_stash<CR>
vmap <leader>\| :Tabularize bar<CR>

""" **Embolden** selection
nmap <leader>* viwS*gvS*
vmap <leader>* S*gvS*

""" Open file in the browser
map <leader>H :!open '%' -a /Applications/Google\ Chrome.app/<CR>

augroup Vim
  autocmd!

  " Reload vimrc after save.
  autocmd BufWritePost ~/.vim/vimrc source ~/.vim/vimrc

  " Create the directory if it doesn't exist.
  autocmd BufNewFile * silent !mkdir -p $(dirname %)

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType markdown setlocal syn=off
augroup END

augroup CoffeeScript
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter *.coffee imap <C-l> <Space>->
  autocmd BufLeave *.coffee imap <C-l> <Space>=><Space>
augroup END

augroup PlantUML
  autocmd!
  autocmd BufNewFile,BufReadPost,BufEnter *.plantuml nmap <leader>. :w<CR>:!java -jar /Users/Larry/.bin/plantuml.jar %<CR>
  autocmd BufLeave *.plantuml nmap <leader>. :call RunTestFile()<CR>
augroup END

augroup SizeWindow
  autocmd!
  autocmd WinEnter * call SizeWindow()
augroup END

function! SizeWindow()
  if winwidth(winnr()) < 78
    exec "vertical resize 78"
  end
endfunction

" Shamelessly ripped from Gary Bernhardt's vimrc
"   https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! RunRuby()
  " Write the file and run tests for the given filename
  w
  silent !echo;echo;echo;echo;echo
  exec ":!ruby " . expand("%")
endfunction

function! RunTestFile()
  let in_spec_file    = match(expand("%"), '_spec.rb$') != -1
  let in_test_file    = match(expand("%"), '_test.rb$') != -1
  let in_feature_file = match(expand("%"), '.feature$') != -1

  if in_spec_file
    call SetTestFile()
  elseif in_test_file
    call SetTestFile()
  elseif in_feature_file
    call SetTestFile()
  elseif !exists("g:grb_test_file")
    return
  end

  call ChooseTestRunner(g:grb_test_file)
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let g:grb_test_file=@%
endfunction

function! ChooseTestRunner(filename)
  write
  silent !echo;echo;echo;echo;echo

  let run_specs   = match(a:filename, '_spec.rb$') != -1
  let run_tests   = match(a:filename, '_test.rb$') != -1
  let run_feature = match(a:filename, '.feature$') != -1

  if run_specs
    call RunSpecs(a:filename)
  elseif run_tests
    call RunTests(a:filename)
  elseif run_feature
    call RunFeature(a:filename)
  endif
endfunction

" \:<C-R>=line(".")
function! RunSpecs(filename)
  silent exec ":!echo rspec " . a:filename
  " exec ":!ruby -Ilib -Ispec " . a:filename
  exec ":!time rspec " . a:filename
endfunction

function! RunTests(filename)
  silent exec ":!echo ruby -Itest -Ilib " . a:filename
  exec ":!time bundle exec ruby -Itest -Ilib " . a:filename
endfunction

function! RunFeature(filename)
  silent exec ":!echo bundle exec cucumber -r features " . a:filename
  " exec ":!ruby -Ilib -Ispec " . a:filename
  exec ":!time bundle exec cucumber -r features " . a:filename
endfunction

nmap <leader>. :call RunTestFile()<CR>
nmap <leader>> :silent :!clear<cr>:w<cr>:!ruby -Ilib %<cr>
