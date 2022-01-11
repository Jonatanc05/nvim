call plug#begin('~/vimfiles/autoload')

Plug 'mhinz/vim-startify'		" Initial screen
Plug 'derekwyatt/vim-fswitch'	" Switch header-source file (c++)
Plug 'embark-theme/vim'			" Colorscheme

" Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'airblade/vim-rooter'

" Git
Plug 'mhinz/vim-signify'		" Show signs in lines
Plug 'tpope/vim-fugitive'		" :Git commands
Plug 'tpope/vim-rhubarb'		" :GBrowser to github

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=[$MYVIMDIR.'/ulti-snippets']
let g:UltiSnipsEditSplit='vertical'

call plug#end()
