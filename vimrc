" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'c9s/perlomni.vim' " Requires compilation
NeoBundle 'python-syntax'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'linux' : 'make',
			\    },
			\ }
NeoBundle 'scrooloose/syntastic'
NeoBundle 'dbakker/vim-projectroot'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'fatih/vim-go'
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'rust-lang/rust.vim'

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

autocmd FileType go setlocal expandtab softtabstop=0
autocmd FileType python setlocal expandtab softtabstop=0

"""
" Python venv support
"""
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	site_packages = os.path.join(project_base_dir, 'lib', 'python%s' % sys.version[:3], 'site-packages')
	prev_sys_path = set(sys.path)
	#import site
	#site.addsitedir(site_packages)
	sys.real_prefix = sys.prefix
	sys.prefix = project_base_dir
	# Move the added items to the front of the path:
	new_sys_path = prev_sys_path - set(sys.path)
	for i in new_sys_path:
		sys.path.insert(0, i)
	sys.path.insert(0, project_base_dir)
EOF

"""
" base16-vim
"""
let base16colorspace=256
colorscheme base16-default
set background=dark

"""
" vim-airline
"""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"

"""
" neocomplete.vim
"""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	"return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"

" disable buffer completion
"call neocomplete#custom#source('buffer', 'disabled', 1)
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplete#enable_auto_select = 1
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

"""
" jedi-vim
"""
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

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
" syntastic
"""
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"""
" vim-javacomplete2
"""
autocmd FileType java setlocal omnifunc=javacomplete#Complete
