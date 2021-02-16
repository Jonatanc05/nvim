au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
au BufEnter *.cc let b:fswitchdst = "h,hpp"

nnoremap <silent> <A-o> :FSHere<cr>
nnoremap <silent> <A-O> :FSSplitLeft<cr>
