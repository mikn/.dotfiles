" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'linux' : 'make', }, }
NeoBundle 'dbakker/vim-projectroot'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'w0rp/ale'
" File type addons
NeoBundle 'saltstack/salt-vim'
NeoBundle 'pearofducks/ansible-vim'
NeoBundle 'hashivim/vim-vagrant'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'vim-perl/vim-perl'
" Rust
"NeoBundle 'racer-rust/vim-racer'
NeoBundle 'sebastianmarkow/deoplete-rust'
" Python
NeoBundle 'Vimjas/vim-python-pep8-indent'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'zchee/deoplete-jedi'

call neobundle#end()

filetype plugin indent on
NeoBundleCheck

"""
" Basic settings
"""
syntax on
set nu
set go=
set guifont=Knack\ 9
set tabstop=4
set shiftwidth=4
set smarttab

let g:python_host_prog = '/home/mikaelk/venvs/neovim2/bin/python'
let g:python3_host_prog = '/home/mikaelk/venvs/neovim3/bin/python'

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"""
" base16-vim
"""
let base16colorspace=256
colorscheme base16-mexico-light
set background=light

"""
" vim-airline
"""
let g:airline_theme = "base16"
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"

"""
" deoplete.vim
"""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	"return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"

" disable buffer completion
"call deoplete#custom#source('buffer', 'disabled', 1)
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 2
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
let g:deoplete#enable_auto_select = 1
let g:deoplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:deoplete#keyword_patterns')
	let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:deoplete#sources#omni#input_patterns')
	let g:deoplete#sources#omni#input_patterns = {}
endif
let g:deoplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:deoplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:deoplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
if !exists('g:deoplete#force_omni_input_patterns')
	let g:deoplete#force_omni_input_patterns = {}
endif
let g:deoplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
if !exists('g:deoplete#sources')
	let g:deoplete#sources = {}
endif
let g:deoplete#sources._ = []

"""
" jedi-vim
"""
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

"""
" deoplete-jedi
"""
let g:deoplete#sources.python = ['jedi']
let g:deoplete#sources#jedi#show_docstring = 1

"""
" deoplete-rust
"""
let g:deoplete#sources#rust#racer_binary='/home/mikaelk/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/mikaelk/devel/rust/src'

"""
" python-syntax
"""
let python_highlight_all = 1

"""
" unite.vim
"""
" Unite
function! Unite_ctrlp()
	execute ':Unite  -buffer-name=files -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
endfunction
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :call Unite_ctrlp()<cr>
nnoremap <C-c> :<C-u>Unite -no-split -buffer-name=explorer -start-insert file<cr>
nnoremap <C-k> :<C-u>Unite -no-split -buffer-name=bookmark -start-insert bookmark<cr>
nnoremap <C-o> :<C-u>Unite -vertical -buffer-name=outline -start-insert outline<cr>
nnoremap <C-b> :<C-u>Unite -horizontal -buffer-name=buffer  buffer<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>

let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup',  '--hidden', '-g', '']

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
	" Play nice with supertab
	let b:SuperTabDisabled=1
	" Enable navigation with control-j and control-k in insert mode
	imap <silent><buffer><expr> <C-s> unite#do_action('split')
	imap <buffer> <C-j>   <Plug>(unite_select_next_line)
	imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
function! s:unite_my_settings()
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
  nmap <buffer> x     <Plug>(unite_quick_match_jump)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(empty(unite#mappings#get_current_filters()) ?  ['sorter_reverse'] : [])

  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  imap <silent><buffer><expr> <C-f>	unite#do_action('file_rec/async')
endfunction

"""
" vim-projectroot
"""
function! <SID>AutoProjectRootCD()
	try
		if &ft != 'help'
			ProjectRootCD
		endif
	catch
		" Silently ignore invalid buffers
	endtry
endfunction

autocmd BufEnter * call <SID>AutoProjectRootCD()

let g:rootmarkers = ['setup.py','.projectroot','.git','.hg','.svn','.bzr','_darcs','build.xml']

"""
" vimfiler.vim
"""
let g:vimfiler_as_default_explorer = 1
"let g:loaded_netrwPlugin = 1

"""
" Python things
"""
" Enhanced python highlighting
hi pythonLambdaExpr      ctermfg=105 guifg=#8787ff
hi pythonInclude         ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
hi pythonClass           ctermfg=167 guifg=#FF62B0 cterm=bold gui=bold
hi pythonParameters      ctermfg=147 guifg=#AAAAFF
hi pythonParam           ctermfg=175 guifg=#E37795
hi pythonBrackets        ctermfg=183 guifg=#d7afff
hi pythonClassParameters ctermfg=111 guifg=#FF5353
hi pythonSelf            ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
hi pythonDottedName      ctermfg=74  guifg=#5fafd7
hi pythonError           ctermfg=196 guifg=#ff0000
hi pythonIndentError     ctermfg=197 guifg=#ff005f
hi pythonSpaceError      ctermfg=198 guifg=#ff0087
hi pythonBuiltinType     ctermfg=74  guifg=#9191FF
hi pythonBuiltinObj      ctermfg=71  guifg=#5faf5f
hi pythonBuiltinFunc     ctermfg=169 guifg=#d75faf cterm=bold gui=bold
hi pythonException       ctermfg=207 guifg=#CC3366 cterm=bold gui=bold

autocmd FileType python setlocal
	\   tabstop=4
	\   shiftwidth=4
	\   softtabstop=4
	\   textwidth=79
	\   expandtab
	\   autoindent
	\   fileformat=unix

"""
" rust
"""
let g:rustfmt_autosave = 1

"""
" vim-racer
"""
"let g:racer_experimental_completer = 1
