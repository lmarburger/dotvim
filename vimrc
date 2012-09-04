" Section: Pathogen

set nocompatible    " screw vi-compatible features
set encoding=utf-8  " utf-8 is fun

call pathogen#infect()

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

""" SEARCH
set hlsearch                    " highlight search results
set incsearch                   " highlight matches while searching
set ignorecase                  " ignore case when searching.
set smartcase                   " override ignorecase if search contains upper case

""" TABS
set shiftwidth=2                " use 2 spaces for indentation
set tabstop=2                   " use 2 spaces when tabbinb
set expandtab                   " use spaces instead of tabs because tabs are evil
set smarttab                    " backspacing deletes space-expanded tabs
set nojoinspaces                " never use two spaces when joining lines
set backspace=indent,eol,start  " allow backspacing over autoindent,
                                " line breaks, and start of insert

set wildmenu                    " tab completion for commands
set wildmode=list:full,full
set wildignore+=tmp/**

set listchars=""                " Reset the listchars
set listchars+=tab:\ \          " show tab as two spaces
set listchars+=trail:.          " show trailing whitespace as .
set listchars+=extends:>        " The character to show in the last column when
                                " wrap is off and line is too long.
set listchars+=precedes:<       " The character to show in the first column when
                                " wrap is off and line is too long.

""" VISUAL
syntax on                       " highlight my syntax plz
set t_Co=256                    " more than 8 colors, kthx
colorscheme solarized
set gfn=Menlo:h12

""" DARK
" set background=dark
" highlight CursorLine  cterm=none ctermbg=0
" highlight ColorColumn cterm=none ctermbg=0 guibg=#073642

""" LIGHT
set background=light

""" HIGHLIGHT
set cursorline        " highlight cursor line
set colorcolumn=+1,+2 " highlight the 81st and 82nd columns

set cmdheight=2  " 2-line command window
"set linebreak    " Wrap lines on word break
set textwidth=80 " break long lines at 80 characters

""" STATUSBAR
" statusbar stolen from someone somewhere
set laststatus=2
set statusline=\ %f\                       " filename
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}]            " file format
set statusline+=%h%m%r%w                   " flag
set statusline+=%=                         " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P      " offset

" set the window's title to: /path/to/file.txt
set title
set titlestring=%-25.55F\ %a%r%m titlelen=70


source ~/.vim/filetypes          " load awesome filetypes

""" PLUGIN CONFIG
let g:bufExplorerDefaultHelp=0        " hide bufexplorer's help
let NERDTreeQuitOnOpen=1              " hide nerd tree's help
let g:ftplugin_sql_omni_key = '<C-X>' " use C-X instead of C-C in sql.vim

let g:BufKillFunctionSelectingValidBuffersToDisplay = 'bufexisted'


command! W :w " alias :w as :W to fight accidental typos

" Easy expansion of the active file directory. Cite: Practical Vim pg 94.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

""" MAPPINGS
let mapleader = ","

" Can't be bothered to understand ESC vs <c-c> in insert mode
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L117-118
imap <c-c> <esc>

" delete the active buffer keeping the split open
map <leader>x :b#<CR>:bd #<CR>
map <leader>X :bd<CR>

nmap <silent> <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
nmap <leader>u :GundoToggle<CR>
nmap <leader><cr> :nohlsearch<CR>
nmap <leader>S :set spell<CR>]s
nmap <leader>ns :set nospell<CR>
nmap <leader>a :Ack<space>
nmap <leader>A :Ack!<space>

" yank until the end of the line
nmap Y y$

" split and tab management and navigation
nmap <leader>v :vsplit<CR><C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>
nmap <leader>w <C-w>p
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-S-l> <C-w>l
nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>

" Open a new tab with the current buffer. Need to use this :buffer trick because
" vim yells when running `:tabedit %` with a dirty buffer.
nmap <leader>t :tabedit<CR>:buffer #<CR>:bdelete #<CR>

" Command-T
map <C-t> :CommandTFlush<cr>\|:CommandT<cr>


""" RUBY
imap <C-l> <Space>=><Space>
nmap <leader>R i, record: :new_episodes<ESC>

""" TABULARIZE
nmap <leader>j vip:Tabularize json<CR>
vmap <leader>: :Tabularize first_colon<CR>
vmap <leader>l :Tabularize hash_rocket<CR>
vmap <leader>= :Tabularize first_equals<CR>
vmap <leader>' :Tabularize first_single_quote<CR>
vmap <leader>" :Tabularize first_double_quote<CR>
vmap <leader>{ :Tabularize first_left_stash<CR>
vmap <leader>} :Tabularize first_right_stash<CR>
vmap <leader>\| :Tabularize bar<CR>

""" MARKDOWN
vmap <leader>* S*gvS*

""" Open file in the browser
map <leader>H :!open '%' -a /Applications/Google\ Chrome.app/<CR>

" Execute the last command executed in screen.
" nmap <leader>l  :w<CR>:call Send_to_Screen("exec_last_feature_or_test\n")<CR>
" nmap <leader>L  :w<CR>:call Send_to_Screen("!!\n")<CR>
" nmap <C-t><C-c> :w<CR>:call Send_to_Screen("tc\n")<CR>


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
  let in_jasmine_spec_file = match(expand("%"), '_spec.coffee$') != -1

  if in_spec_file
    call SetTestFile()
  elseif in_test_file
    call SetTestFile()
  elseif in_feature_file
    call SetTestFile()
  elseif in_jasmine_spec_file
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
  let in_jasmine_spec_file = match(a:filename, '_spec.coffee$') != -1

  if run_specs
    call RunSpecs(a:filename)
  elseif run_tests
    call RunTests(a:filename)
  elseif run_feature
    call RunFeature(a:filename)
  elseif in_jasmine_spec_file
    call RunJasmineHeadlessFeature(a:filename)
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

function!  RunJasmineHeadlessFeature(filename)
  silent exec ":!echo jasmine-headless-webkit -c " . a:filename
  exec ":!time jasmine-headless-webkit -c " . a:filename
endfunction

" I like comma for a leader, but I'd still like to use the original Normal mode
" comma command. Double comma should suffice.
nmap <leader><leader> ,<ESC>
nmap <leader>. :call RunTestFile()<CR>
nmap <leader>> :silent :!clear<cr>:w<cr>:!ruby -Ilib %<cr>

augroup Vim
  autocmd!

  " Reload vimrc after save.
  autocmd BufWritePost ~/.vimrc so ~/.vimrc

  " Create the directory if it doesn't exist.
  autocmd BufNewFile * silent !mkdir -p $(dirname %)

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType markdown setlocal syn=off
augroup END

" Various useful Ruby command mode shortcuts
" augroup Ruby
"   autocmd!
"   autocmd BufRead,BufNewFile,BufEnter *.rb
"     \ :nmap <leader><leader> :call RunRuby()<CR>
"     "\ :nmap <leader><leader> :w<CR>:call Send_to_Screen("ruby " . expand("%") ."\n")<CR>|
"   utocmd BufRead,BufNewFile,BufEnter *_test.rb,test_*.rb
"    \ :nmap <leader><leader> :w<CR>:call Send_to_Screen("clear ; time ruby -Itest -Ilib " . expand("%") ."\n")<CR>|
"    \ :nmap <leader><leader> :w<CR>:call Send_to_Screen("bundle exec ruby -Itest -Ilib " . expand("%") ."\n")<CR>|
"   autocmd BufRead,BufNewFile,BufEnter *_spec.rb
"     \ :nmap <leader><leader> :call RunTestFile()<CR>
"     "\ :nmap <leader><leader> :w<CR>:call Send_to_Screen("ruby -Ispec -Ilib " . expand("%") . "\n")<CR>|
"     "\ :nmap <leader><leader> :w<CR>:call Send_to_Screen("bundle exec ruby -Ispec -Ilib " . expand("%") . "\n")<CR>|
" augroup END


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

" augroup Cucumber
"   autocmd!
"   autocmd BufNewFile,BufReadPost,BufEnter *.feature,*.story
"     \ :nmap <leader><leader> :w<CR>:call Send_to_Screen("clear ; time bundle exec cucumber -r features " . expand("%") . "\:<C-R>=line(".")<CR>" ."\n")<CR>|
"     \ :nmap <leader>R :w<CR>:call Send_to_Screen("clear ; time bundle exec cucumber -r features " . expand("%") ."\n")<CR>|
" augroup END
