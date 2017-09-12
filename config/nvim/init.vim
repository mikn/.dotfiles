set runtimepath+=~/.config/nvim/dein.vim

if dein#load_state('~/.local/share/dein')
    call dein#begin('~/.local/share/dein')

    call dein#add('~/.config/nvim/dein.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('chriskempson/base16-vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/unite-outline')
    call dein#add('Shougo/vimshell.vim')
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
    call dein#add('Shougo/echodoc.vim')
    call dein#add('Shougo/neopairs.vim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/neossh.vim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('Konfekt/FastFold')
    call dein#add('dbakker/vim-projectroot')
    call dein#add('tmhedberg/matchit')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('w0rp/ale')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('AndrewRadev/splitjoin.vim')
    call dein#add('autozimu/LanguageClient-neovim')
    call dein#add('roxma/python-support.nvim')
    " File type addons
    call dein#add('sheerun/vim-polyglot')
    call dein#add('saltstack/salt-vim')
    call dein#add('jez/vim-github-hub')
    " Rust
    call dein#add('racer-rust/vim-racer')
    call dein#add('sebastianmarkow/deoplete-rust')
    " Python
    call dein#add('alfredodeza/coveragepy.vim')

    call dein#end()
    call dein#save_state()
endif

"""
" Basic settings
"""
filetype plugin indent on
syntax on
set noshowmode
set hidden
set nu
set go=
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set fileformat=unix
au FocusLost * silent! wa

let mapleader = ","
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"""
" dein.vim
"""
if dein#check_install()
    call dein#install()
endif

"""
" python-support.nvim
"""
let deps = ['python-language-server', 'mistune', 'psutil', 'setproctitle']
let g:python_support_python2_requirements = get(g:,'python_support_python2_requirements',[]) + deps
let g:python_support_python3_requirements = get(g:,'python_support_python3_requirements',[]) + deps

"""
" base16-vim
"""
let base16colorspace=256
colorscheme base16-solar-flare
set background=dark

"""
" vim-airline
"""
let g:airline_theme = "base16"
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"

"""
" deoplete.vim
"""
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd CompleteDone * silent! pclose!

inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 2
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
let g:deoplete#enable_auto_select = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer']
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

"""
" deoplete-rust
"""
let g:deoplete#sources#rust#racer_binary='/home/mikael/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/mikael/devel/rust/src'

"""
" python-syntax
"""
let python_highlight_all = 1

"""
" denite.vim
"""
" Denite
function! Denite_ctrlp()
    execute ':Denite  -buffer-name=files buffer file_rec:'.ProjectRootGuess().'/'
endfunction
let g:denite_source_history_yank_enable = 1
"call denite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :call Denite_ctrlp()<cr>
nnoremap <C-c> :<C-u>Denite -buffer-name=explorer file<cr>
nnoremap <C-k> :<C-u>Denite -buffer-name=bookmark bookmark<cr>
nnoremap <C-o> :<C-u>Denite -buffer-name=outline documentSymbol<cr>
nnoremap <C-b> :<C-u>Denite -buffer-name=grep grep<cr>
nnoremap <leader>y :<C-u>Denite -no-split -buffer-name=yank history/yank<cr>

call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup',  '--hidden', '--ignore', '.git', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Custom mappings for the denite buffer
autocmd FileType denite call s:denite_settings()
function! s:denite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <silent><buffer><expr> <C-s> denite#do_action('split')
    imap <buffer> <C-j>   <Plug>(denite_select_next_line)
    imap <buffer> <C-k>   <Plug>(denite_select_previous_line)
endfunction
function! s:denite_my_settings()
  imap <buffer> jj      <Plug>(denite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(denite_delete_backward_path)

  imap <buffer><expr> j denite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(denite_select_next_line)
  imap <buffer> <C-w>     <Plug>(denite_delete_backward_path)
  imap <buffer> '     <Plug>(denite_quick_match_default_action)
  nmap <buffer> '     <Plug>(denite_quick_match_default_action)
  imap <buffer><expr> x denite#smart_map('x', "\<Plug>(denite_quick_match_jump)")
  nmap <buffer> x     <Plug>(denite_quick_match_jump)
  nmap <buffer> <C-z>     <Plug>(denite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(denite_toggle_transpose_window)
  nmap <buffer> <C-j>     <Plug>(denite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(denite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(denite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l denite#smart_map('l', denite#do_action('default'))

  let denite = denite#get_current_denite()
  if denite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     denite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     denite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     denite#do_action('lcd')
  nnoremap <buffer><expr> S      denite#mappings#set_current_filters(empty(denite#mappings#get_current_filters()) ?  ['sorter_reverse'] : [])

  imap <silent><buffer><expr> <C-s>     denite#do_action('split')
  imap <silent><buffer><expr> <C-f> denite#do_action('file_rec/async')
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
let g:loaded_netrwPlugin = 1

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

"""
" vim-ruby
"""
let g:ruby_indent_block_style = 'do'
autocmd FileType ruby setlocal
    \   expandtab
    \   tabstop=2
    \   shiftwidth=2
    \   softtabstop=2
    \   autoindent

if !exists( "*RubyEndToken" )
  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
      let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>"
      endif
    endfunction

endif
autocmd FileType ruby,eruby imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby compiler ruby

" Enable heavy omni completion.
let g:deoplete#sources#omni#input_patterns.ruby = '[^.[:digit:] *\t]\%(\.\|->\)'

"""
" vim-rspec
"""
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"""
" ale
"""
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
let g:ale_linters = {
            \ 'python': [],
            \}
let g:ale_python_mypy_executable = 'python3'
let g:ale_python_mypy_args = '-m mypy'

"""
" vim-polygot
"""
let python_highlight_all=1

"""
" LanguageClient-neovim
"""
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls', '--log-file', '/tmp/pyls.log'],
    \ }
"\ 'python': ['python3', '-c', 'import pyls.__main__; pyls.__main__.main()'],
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"""
" echodoc.vim
"""
let g:echodoc#enable_at_startup = 1
