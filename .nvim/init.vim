" let some plugins know where python is (dependent plugins: vim-autoformat)
let g:python3_host_prog='/usr/bin/python3'

" get VimPlug from https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugge')

" sensible defaults
Plug 'tpope/vim-sensible'
" language client - detects errors while typing, integrates with automcomplete
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
			\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
			\ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
			\ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
			\ 'python': ['/usr/local/bin/pyls'],
			\ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
			\ }

" autocompletion with ncm2
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufNewfile,BufRead *.rs LanguageClientStart

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" TODO: This stuff does not seem to make a difference. Gotta work on that in
" the future..
"
" language support for rust
" Plug 'ncm2/ncm2-racer'
" snippets!
" Plug 'ncm2/ncm2-ultisnips'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" snippets attempt #2!
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" TODO: This might not be necessary, because language server has this
" functionality as well.
Plug 'Chiel92/vim-autoformat'
autocmd BufWrite * :Autoformat

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" various hotkeys
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" line numbers
set number
set relativenumber
