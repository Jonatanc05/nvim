" Startify
let g:startify_custom_header = startify#fortune#boxed()
let g:startify_lists = [
	\ { 'type': 'sessions',  'header': ['	Sessoes Salvas'] },
	\ { 'type': 'files', 	 'header': ['	Arquivos Recentes'] },
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]
let g:startify_fortune_use_unicode = 1

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" F-Switch
au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
au BufEnter *.cc let b:fswitchdst = "h,hpp"
nnoremap <silent> <C-ç> :FSHere<cr>
nnoremap <silent> <C-Ç> :FSSplitLeft<cr>

