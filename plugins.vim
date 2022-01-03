call plug#begin('~/vimfiles/autoload')

Plug 'mhinz/vim-startify'		" Initial screen
Plug 'derekwyatt/vim-fswitch'	" Switch header-source file (c++)
Plug 'embark-theme/vim'			" Colorscheme

" Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'airblade/vim-rooter'

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$MYVIMDIR.'/ulti-snippets']
let g:UltiSnipsEditSplit='vertical'

call plug#end()
