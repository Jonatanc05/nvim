" I use spacebar as my leader key
let mapleader=" "

" Set <leader>h to remove any highlights (e. g. search highlight)
" Won't remove end of line highlights
nmap <Space>h :noh<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>
tnoremap jk <Esc>
tnoremap kj <Esc>

" Set CTRL+g to replace word
inoremap <c-g> <ESC>viwc
nnoremap <c-g> viwc
" Set CTRL+9 to replace parentesis inner content
inoremap <c-9> <ESC>vi(c
nnoremap <c-9> vi(c

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Move selected block of text in visual mode
" shift + k to move up
" shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Alternate way to save
nnoremap <silent> <C-s> :w<CR>
" Alternate way to quit
nnoremap <silent> <C-q> :q<CR>
nnoremap <silent> <C-Q> :q!<CR>
" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <C-Up>    :resize -2<CR>
nnoremap <silent> <C-Down>  :resize +2<CR>
nnoremap <silent> <C-Left>  :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" Highlight blank space at line end
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Allow to delete current buffer without closing window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Use ç/Ç to search ahead/behind
nnoremap ç /
nnoremap Ç ?

" Use <leader>j to repeat action (standard is ';')
nnoremap <leader>j ;
