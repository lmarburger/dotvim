set nocompatible                " screw vi-compatible features
set encoding=utf-8              " utf-8 is fun
set nowrap

call pathogen#infect()          " pathogen
source ~/.vim/filetypes         " load awesome filetypes
runtime macros/matchit.vim      " load matchit (included with vim)

set exrc                        " enable per-directory .vimrc files
set secure                      " disable unsafe commands in local .vimrc files

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
set cmdheight=1                 " 1-line command window
set textwidth=80                " break long lines at 80 characters

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

set timeoutlen=1000             " Esc key is recognized immediately. See:
set ttimeoutlen=0               "   https://www.johnhawthorn.com/2012/09/vi-escape-delays/

set lazyredraw                  " Scrolling is laggy. Enabling this setting
                                " seems to reduce the lag but am unsure of the
                                " side effects.

""" Tab completion
set wildmenu
set wildmode=list:full,full
set wildignore+=tmp/**,vendor/**,exec/**,gemfiles/**

" """ Show invisible characters
" set listchars=""                " reset the listchars
" set listchars+=tab:\ \          " show tab as two spaces
" set listchars+=trail:.          " show trailing whitespace as .
" set listchars+=extends:>        " the character to show in the last column when
"                                 " wrap is off and line is too long.
" set listchars+=precedes:<       " the character to show in the first column when
"                                 " wrap is off and line is too long.

""" Visual
syntax on                   " highlight my syntax plz
set cursorline              " highlight cursor line
set colorcolumn=-1,-0       " highlight the 79th and 80th columns
set t_Co=256                " more than 8 colors, kthx
" set macligatures
set guifont=Fira\ Code:h18  " Menlo & Source Code Pro are other great fonts
set fillchars=              " don't need characters when we have colors
set background=dark
colorscheme base16-default-dark
" colorscheme larry

""" Color tweaks
highlight ColorColumn ctermbg=233
highlight TabLine     ctermbg=0
highlight TabLineSel  ctermbg=0
highlight TabLineFill ctermbg=0


" """ Presentation
" """
" """   Use base16-google.light iTerm color scheme
" set scrolloff=1
" set background=light

""" Status bar
set laststatus=2
set statusline=\ %f%(\ [%M%R%W%H]%)       " filename
set statusline+=%=                        " right align
set statusline+=%-14.(%l/%L,%v%)\ %<%P\   " offset

""" Set window/terminal title
set title
set titlestring=%F                        " /path/to/file.txt (Vim)

""" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

function! FindCabalSandboxRoot()
    return finddir('.cabal-sandbox', './;')
endfunction

function! FindCabalSandboxRootPackageConf()
    return glob(FindCabalSandboxRoot().'/*-packages.conf.d')
endfunction

" let g:syntastic_haskell_hdevtools_args = '-g-ilib -g-isrc -g-i. -g-idist/build/autogen -g-Wall -g-package-conf='.FindCabalSandboxRootPackageConf()

""" Plugin Configuration
let g:ftplugin_sql_omni_key = '<C-X>' " use C-X instead of C-C in sql.vim
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=4
let g:netrw_liststyle=4

let g:ackprg = 'ag --vimgrep --smart-case'

""" Mappings
let mapleader = ","

" I like comma for a leader, but I'd still like to use the original Normal
" mode comma command. Double comma should suffice.
nmap <leader><leader> ,<ESC>
nmap <leader>s :w<enter>

" Can't be bothered to understand ESC vs <c-c> in insert mode
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc#L117-118
imap <c-c> <esc>

command! W :w " alias :w as :W to fight accidental typos

" Easy expansion of the active file directory. Cite: Practical Vim pg 94.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" delete the active buffer keeping the split open
map <leader>x :bprevious<cr>:bdelete #<cr>
map <leader>X :bdelete<cr>

nmap <leader><cr> :nohlsearch<CR>
nmap <leader>a :Ack!<space>
nmap <leader>A :Ack<space>
nmap <leader>w :Ack!<space><C-r><C-w><cr>
nmap <leader>W :Ack<space><C-r><C-w><cr>

" yank until the end of the line
nmap Y y$

" split and tab management and navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-S-l> <C-w>l
nmap <leader>t :tabnext<cr>
nmap <leader>T :tabprevious<cr>

""" Arrows
imap <C-l> <Space>=><Space>
imap <C-f> <Space>-><Space>
imap <C-k> <Space>-><Space>
imap <C-d> <Space><-<Space>

""" Tabularize
nmap <leader>j vip:Tabularize json<CR>
vmap <leader>j :Tabularize json<CR>
vmap <leader>: :Tabularize first_colon<CR>
vmap <leader>l :Tabularize hash_rocket<CR>
vmap <leader>k :Tabularize function_arrow<CR>
vmap <leader>d :Tabularize draw_from<CR>
vmap <leader>= :Tabularize first_equals<CR>
vmap <leader>' :Tabularize first_single_quote<CR>
vmap <leader>" :Tabularize first_double_quote<CR>
vmap <leader>{ :Tabularize first_left_stash<CR>
vmap <leader>} :Tabularize first_right_stash<CR>
vmap <leader>\| :Tabularize bar<CR>

""" Markdown: **Embolden** selection
nmap <leader>* viWS*gvS*
vmap <leader>* S*gvS*

""" Open file in Marked
map <leader>m :silent !open "%" -a /Applications/Marked.app<cr>:redraw!<cr>

""" Select the last pasted text
nmap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'


augroup Config
  autocmd!

  " Reload vimrc after save.
  autocmd BufWritePost ~/.vim/vimrc source ~/.vim/vimrc
  autocmd BufWritePost ~/.vimrc     source ~/.vim/vimrc

  " autocmd BufWritePost ~/.vim/colors/larry.vim colorscheme larry

  " Reload tmux.conf after save.
  autocmd BufWritePost ~/Code/dotfiles/.tmux.conf call system('tmux source-file ~/.tmux.conf')

  " Create the directory if it doesn't exist.
  autocmd BufNewFile * silent !mkdir -p $(dirname %)

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType markdown setlocal syn=off

  " Add Idris support to commentary.vim
  autocmd FileType idris set commentstring=--\ %s
augroup END

augroup SizeWindow
  autocmd!
  autocmd WinEnter * call SizeWindow()
augroup END

function! SizeWindow()
  if winwidth(winnr()) < 81
    exec "vertical resize 81"
  end
endfunction

" Pipe the selection to the CoffeeScript compile and print the result.
function! CompileCoffee() range
  let code = shellescape(join(getline(a:firstline, a:lastline), "\n"))

  " shellescape() escapes newlines and encloses in single quotes. Code needs
  " to be wrapped in double quotes and use real newlines in order to be
  " processed correctly.
  let code = substitute(code, "\\\\\n", "\n", "g")

  echo system("echo " . code . "| coffee -scb")
endfunction

vmap <leader>c :call CompileCoffee()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
" Shamelessly ripped from Gary Bernhardt's vimrc
"   https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! RunRuby()
  " Write the file and run tests for the given filename
  write
  silent !echo;echo;echo;echo;echo
  exec ":!ruby " . expand("%")
endfunction

function! RunTestFile()
  write

  if exists('g:grb_test_rerun_last_command')
    call RerunLastCommand()
    return
  end

  let in_spec_file = match(expand('%:t'), '_spec.rb$') != -1
  let in_test_file = match(expand('%:t'), '_test.rb$\|/test_') != -1 && expand('%:t') != 'test_helper.rb'
  let in_clj_file  = expand('%:e') == 'clj'
  let in_erl_file = match(expand('%:t'), '_test_\?.erl$') != -1

  if in_spec_file || in_test_file || in_clj_file || in_erl_file
    let g:grb_test_file=@%
    if in_spec_file && executable('rspec')
      let g:grb_test_runner='spec'
    elseif in_test_file || in_spec_file
      let g:grb_test_runner='test'
    elseif in_clj_file
      let g:grb_test_runner='clj'
    elseif in_erl_file
      let g:grb_test_runner='erl'
    end
  end

  if !exists('g:grb_test_file') || !exists('g:grb_test_runner')
    echo 'No test file to run.'
    return
  end

  silent !echo;echo;echo;echo;echo

  if g:grb_test_runner == 'spec'
    echo 'spec'
    call RunSpecs(g:grb_test_file)
  elseif g:grb_test_runner == 'test'
    echo 'test'
    call RunTests(g:grb_test_file)
  elseif g:grb_test_runner == 'clj'
    echo 'clj'
    call RunLein(g:grb_test_file)
  elseif g:grb_test_runner == 'erl'
    echo 'erl'
    call RunEUnit(g:grb_test_file)
  endif
endfunction

function! RunSpecs(filename)
  " exec ":!ruby -Ilib -Ispec " . a:filename
  silent exec ":!echo rspec " . a:filename
  exec ":!time rspec " . a:filename
endfunction

function! RunTests(filename)
  silent exec ":!echo ruby -Ivendor/bundle -Itest -Ispec -Ilib -rbundler/setup " . a:filename
  exec ":!time ruby -Ivendor/bundle -Itest -Ispec -Ilib -rbundler/setup " . a:filename
endfunction

function! RunLein(filename)
  silent exec ":!echo lein test"
  exec ":!time lein test"
endfunction

function! RunEUnit(filename)
  silent exec ":!echo rebar3 eunit"
  exec ":!time rebar3 eunit"
endfunction

function! RerunLastCommand()
  echo 'Rerunning last command'
  exec ":!!!"
endfunction

function! ToggleRerunLastCommand()
  if exists('g:grb_test_rerun_last_command')
    echo 'Running test'
    unlet g:grb_test_rerun_last_command
  else
    echo 'Rerunning last command'
    let g:grb_test_rerun_last_command = 1
  end
endfunction

nmap <leader>. :call RunTestFile()<CR>
nmap <leader>> :silent !clear<cr>:w<cr>:!ruby -Ivendor/bundle -Itest -Ispec -Ilib -rbundler/setup %<cr>
nmap <leader>! :call ToggleRerunLastCommand()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Selecta Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:selecta_git_ls_files_command = 'git ls-files --cached --other --exclude-standard'
let g:selecta_ls_files_command     = 'find * -type f'
" let g:selecta_ls_file_command      = g:selecta_ls_files_command
let g:selecta_ls_file_command      = g:selecta_git_ls_files_command

function! TestSelecta()
  echo "(cat .vs-last 2>/dev/null; " . g:selecta_ls_file_command . ") | selecta"
endfunction

function! SetSelectaCommand(command)
  if a:command == 'ls'
    let g:selecta_ls_file_command = g:selecta_ls_files_command
  else
    let g:selecta_ls_file_command = g:selecta_git_ls_files_command
  endif
endfunction

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(vim_command)
  try
    let command = "(cat .vs-last 2>/dev/null; " . g:selecta_ls_file_command . ") | selecta"
    let selection = system(command)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand(":edit")<cr>
nnoremap <leader>F :call SelectaCommand(":tabedit")<cr>
nnoremap <leader>V :call SelectaCommand(":vsplit")<cr>
nnoremap <leader>S :call SelectaCommand(":split")<cr>
nnoremap <leader>l :call SetSelectaCommand("ls")<cr>
nnoremap <leader>g :call SetSelectaCommand("git")<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-p>
