" Terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

" Debug
fun <sid>debug(group)
  exec "hi " . a:group . " ctermfg=none ctermbg=none cterm=reverse"
endfun

" Highlighting function
fun <sid>hi(group, ctermfg, ctermbg, attr)
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . s:cterm(a:ctermfg)
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . s:cterm(a:ctermbg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " cterm=" . a:attr
  endif
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:cterm00
    return s:cterm07
  elseif a:color == s:cterm01
    return s:cterm06
  elseif a:color == s:cterm02
    return s:cterm05
  elseif a:color == s:cterm03
    return s:cterm04
  elseif a:color == s:cterm04
    return s:cterm03
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm06
    return s:cterm01
  elseif a:color == s:cterm07
    return s:cterm00
  endif

  return a:color
endfun


" Theme setup
set background=dark
highlight clear
syntax reset
let g:colors_name = "larry"

" Borders
call <sid>hi("ColorColumn",  "none", s:cterm01, "none")
call <sid>hi("VertSplit",    s:cterm02, s:cterm02, "none")
call <sid>hi("StatusLine",   "none", s:cterm02, "bold")
call <sid>hi("StatusLineNC", s:cterm03, s:cterm02, "none")
call <sid>hi("WildMenu",     "none", "none", "reverse")
call <sid>hi("LineNr",       s:cterm00, s:cterm00, "none")

" Tabs
call <sid>hi("TabLine",     s:cterm03, s:cterm02, "none")
call <sid>hi("TabLineSel",  "none", s:cterm02, "bold")
call <sid>hi("TabLineFill", "none", s:cterm02, "none")
call <sid>hi("Title",       "none", "none", "none")

" Cursor
call <sid>hi("Visual",        "none", s:cterm03, "none")
call <sid>hi("CursorLine",    "none", s:cterm01, "none")
call <sid>hi("CursorColumn",  "none", s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:cterm00, s:cterm01, "none")

" Search
call <sid>hi("IncSearch",     "none", "none", "underline")
call <sid>hi("Search",        "none", "none", "reverse")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:cterm00, "underline")
call <sid>hi("SpellLocal",   "", s:cterm00, "underline")
call <sid>hi("SpellCap",     "", s:cterm00, "underline")
call <sid>hi("SpellRare",    "", s:cterm00, "underline")

" Popup menu
call <sid>hi("PMenu",    "none", s:cterm03, "none")
call <sid>hi("PMenuSel", "none", "none", "reverse")
call <sid>hi("PMenuSbar",    "none", s:cterm04, "none")
call <sid>hi("PMenuThumb",    "none", s:cterm02, "none")

" Other stuff
call <sid>hi("NonText", s:cterm00, "none", "none")
call <sid>hi("Normal", s:cterm07, "none", "none")
" call <sid>hi("MatchParen", "none", s:cterm03, "none")
call <sid>hi("MatchParen", "none", "none", "none")


" When are these used?
" call <sid>debug("Bold")
" call <sid>debug("Debug")
" call <sid>debug("Directory")
" call <sid>debug("ErrorMsg")
" call <sid>debug("Exception")
" call <sid>debug("FoldColumn")
" call <sid>debug("Folded")
" call <sid>debug("Italic")
" call <sid>debug("Macro")
" call <sid>debug("ModeMsg")
" call <sid>debug("MoreMsg")
" call <sid>debug("Question")
" call <sid>debug("SpecialKey")
" call <sid>debug("TooLong")
" call <sid>debug("Underlined")
" call <sid>debug("VisualNOS")
" call <sid>debug("WarningMsg")
" call <sid>debug("Conceal")
" call <sid>debug("Cursor")
" call <sid>debug("SignColumn")

" Remove functions
delf <sid>debug
delf <sid>hi
delf <sid>cterm

" Remove color variables
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
