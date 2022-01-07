let g:startify_session_dir = 'C:\Users\Jonat\Documents\nvim-sessions'

"let g:startify_custom_header = [
"	\ '  *    .  *       .             *    *    .  *       .           .',
"	\ '                         *                   .           *',
"	\ ' *   .        *       .       .       *            *',
"	\ '   .     *                                  .                    *',
"	\ '           .     .  *        *                         .',
"	\ '       .                .        .              *            .',
"	\ '.  *           *                     *                  .',
"	\ '                             .                            *',
"	\ '         *          .   *         .          *      .           .'
"\ ]

"let g:startify_custom_header = [
"	\ '                                          ..',
"	\ '                                         dP/$.',
"	\ '                                         $4$$%',
"	\ '                                       .ee$$ee.',
"	\ '                                    .eF3??????$C$r.        .d$$$$$$$$$$$e.',
"	\ ' .zeez$$$$$be..                    JP3F$5´$5K$?K?Je$.     d$$$FCLze.CC?$$$e',
"	\ '     `""??$$$$$$$$ee..         .e$$$e$CC$???$$CC3e$$$$.  $$$/$$$$$$$$$.$$$$',
"	\ '            `"?$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$b $$"$$$$P?CCe$$$$$F',
"	\ '                 `?$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$b$$J?bd$$$$$$$$$F"',
"	\ '                     `$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$d$$F"',
"	\ '                        `?$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"...',
"	\ '                            `?$$$$$$$$$$$$$$$$$$$$$$$$$F "$$`$$$$b',
"	\ '                                `?$$$$$$$$$$$$$$$$$$F"     ?$$$$$F',
"	\ '                                     `"????????C"',
"	\ '                                     e$$$$$$$$$$$$.',
"	\ '                                   .$b CC$????$$F3eF',
"	\ '                                 4$bC/%$bdd$b@$Pd??Jbbr',
"	\ '                                   `"?$$$$eeee$$$$F?"',
"\ ]

 let g:startify_custom_header = [
	\ '            ^^                   @@@@@@@@@',
	\ '       ^^       ^^            @@@@@@@@@@@@@@@',
	\ '                            @@@@@@@@@@@@@@@@@@',
	\ '                           @@@@@@@@@@@@@@@@@@@@',
	\ ' ~~~~ ~~ ~~~~~ ~~~~~~~~ ~~ &&&&&&&&&&&&&&&&&&&& ~~~~~~~ ~~~~~~~~~~~ ~~~',
	\ ' ~         ~~   ~  ~       ~~~~~~~~~~~~~~~~~~~~ ~       ~~     ~~ ~',
	\ '   ~      ~~      ~~ ~~ ~~  ~~~~~~~~~~~~~ ~~~~  ~     ~~~    ~ ~~~  ~ ~~',
	\ '   ~  ~~     ~         ~      ~~~~~~  ~~ ~~~       ~~ ~ ~~  ~~ ~',
	\ ' ~  ~       ~ ~      ~           ~~ ~~~~~~  ~      ~~  ~             ~~',
	\ '       ~             ~        ~      ~      ~~   ~             ~',
\ ]

let g:startify_lists = [
	\ { 'type': 'sessions',  'header': ['	Sessoes Salvas'] },
	\ { 'type': 'files', 	 'header': ['	Arquivos Recentes'] },
	\ { 'type': 'bookmarks', 'header': ['	Bookmarks'] }
\ ]

let g:startify_bookmarks = [
	\ { 'i': '~/AppData/Local/nvim/init.vim' },
	\ { 's': '~/AppData/Local/nvim/plug-config/start-screen.vim' },
	\ { 'k': '~/AppData/Local/nvim/keymap.vim' },
	\ { 'p': '~/AppData/Local/nvim/plugins.vim' },
\ ]

let g:startify_session_delete_buffers = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
" let g:startify_enable_special = 0

" Use CTRL + s to open startify screen
nnoremap <C-s> :Startify<CR>
