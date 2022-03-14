" Highlight whitespaces at end of line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Configure timoutlen for jk in non-normal modes
au InsertEnter * set timeoutlen=170
au InsertLeave * set timeoutlen=1000
nnoremap <silent> <script> v :set timeoutlen=100<CR>v
nnoremap <silent> <script> V :set timeoutlen=100<CR>V
nnoremap <silent> <script> <C-v> :set timeoutlen=100<CR><C-v>
nnoremap <silent> <C-g> :set timeoutlen=1000<CR>

" Use matchit plugin to fold #region statements
packadd! matchit
au BufWinEnter * let b:match_words = '\s*#\s*region.*$:\s*#\s*endregion'

let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

nnoremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
nnoremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
