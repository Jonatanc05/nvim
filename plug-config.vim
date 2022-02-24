" Startify
let g:startify_custom_header = startify#fortune#boxed()
let g:startify_lists = [
	\ { 'type': 'sessions',  'header': ['	Sessoes Salvas'] },
	\ { 'type': 'files', 	 'header': ['	Arquivos Recentes'] },
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]
let g:startify_bookmarks = [
	\ { 'i': '~/AppData/Local/nvim/init.lua' },
	\ { 'k': '~/AppData/Local/nvim/keymap.vim' },
	\ { 'p': '~/AppData/Local/nvim/plug-config.vim' },
\ ]
let g:startify_session_delete_buffers = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

" Signify
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" F-Switch
au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
au BufEnter *.cc let b:fswitchdst = "h,hpp"
nnoremap <silent> <A-o> :FSHere<cr>
nnoremap <silent> <A-O> :FSSplitLeft<cr>

