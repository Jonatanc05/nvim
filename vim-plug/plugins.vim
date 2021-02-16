call plug#begin('~/vimfiles/autoload')
" Colorschemes
Plug 'embark-theme/vim'

" Arvore de arquivos
Plug 'scrooloose/NERDTree'
" 
" Plug 'davidhalter/jedi-vim'
" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Syntax highlight
Plug 'sheerun/vim-polyglot'
" C Sharp
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
" Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'airblade/vim-rooter'

" Initial screen
Plug 'mhinz/vim-startify'

" Switch header-source file (c++)
Plug 'derekwyatt/vim-fswitch'

call plug#end()
