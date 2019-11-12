set runtimepath+=~/.config/nvim/dein.vim

if dein#load_state('~/.local/share/dein')
    call dein#begin('~/.local/share/dein')

    call dein#add('~/.config/nvim/dein.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('chriskempson/base16-vim')
    call dein#add('Shougo/deoplete.nvim', {'hook_post_update': 'UpdateRemotePlugins' })
    call dein#add('Shougo/echodoc.vim')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('Shougo/context_filetype.vim')
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/defx.nvim')
    call dein#add('kristijanhusak/defx-git')
    call dein#add('Konfekt/FastFold')
    call dein#add('dbakker/vim-projectroot')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('AndrewRadev/splitjoin.vim')
    call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
    call dein#add('ncm2/float-preview.nvim')
    call dein#add('roxma/python-support.nvim', {'hook_post_update': join(['PythonSupportInitPython3', 'PythonSupportInitPython2'], '\n')})
    " File type addons
    call dein#add('sheerun/vim-polyglot')
    call dein#add('saltstack/salt-vim')
    call dein#add('jez/vim-github-hub')
    call dein#add('lervag/vimtex')
    "call dein#add('sebdah/vim-delve')

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
set signcolumn=yes
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set autowrite
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
nnoremap <C-h> <C-o>
nnoremap <C-l> <C-i>

autocmd InsertLeave * call AutoClosePreviewWindow()
autocmd CursorMovedI * call AutoClosePreviewWindow()

function! AutoClosePreviewWindow()
    if !&l:previewwindow
        pclose
    endif
endfunction

au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

"""
" dein.vim
"""
if dein#check_install()
    call dein#install()
endif

"""
" python-support.nvim
"""
let deps = ['pynvim', 'python-language-server', 'mistune', 'psutil', 'setproctitle']
let g:python_support_python2_requirements = get(g:,'python_support_python2_requirements',[]) + deps
let g:python_support_python3_requirements = get(g:,'python_support_python3_requirements',['pyls-mypy']) + deps

"""
" base16-vim
"""
let base16colorspace=256
"colorscheme base16-atelier-forest-light
"set background=light
colorscheme base16-summerfruit-dark
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
" autopairs
"""
"let g:neopairs#enable = 1
let g:AutoPairsMapCR=0


"""
" deoplete.vim
"""
set completeopt+=noselect
set completeopt-=preview
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd CompleteDone * silent! pclose!

inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()
"imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup()
endfunction
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>\<Space>" : "\<Space>"

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 1
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
"let g:deoplete#enable_auto_select = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']
call deoplete#custom#option({
\ 'auto_complete_delay': 1,
\ 'auto_refresh_delay': 1,
\ })
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
" neosnippet
"""
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_complete_done = 1
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)
autocmd InsertLeave * NeoSnippetClearMarkers
imap <expr><CR> pumvisible() ?  deoplete#insert_candidate(1) : "\<CR>\<Plug>AutoPairsReturn"
imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ?  deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"""
" LanguageClient-neovim
"""
set formatexpr=LanguageClient_textDocument_rangeFormatting_sync()
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'terraform': ['terraform-lsp'],
    \ 'go': ['gopls', '-logfile', '/home/mikn/tmp/gopls.log'],
    \ 'python': ['pyls', '--log-file', '/tmp/pyls.log'],
    \ 'java': ['java', '-Declipse.application=org.eclipse.jdt.ls.core.id1', '-Dosgi.bundles.defaultStartLevel=4', '-Declipse.product=org.eclipse.jdt.ls.core.product', '-Dlog.level=ALL', '-noverify', '-Xmx1G', '-jar', '/home/mikael/devel/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar', '-configuration', '/home/mikael/devel/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux', '-data', projectroot#guess(), '--add-modules=ALL-SYSTEM', '--add-opens', 'java.base/java.util=ALL-UNNAMED', '--add-opens', 'java.base/java.lang=ALL-UNNAMED'],
    \ }
"\ 'python': ['python3', '-c', 'import pyls.__main__; pyls.__main__.main()'],
"    \ 'go': ['bingo', '--format-style', 'goimports', '--diagnostics-style', 'instant', '--enhance-signature-help', '--logfile', '/home/mikn/tmp/bingo.log'],

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
    nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
    nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
    nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
    nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
    nnoremap <leader>lr :LanguageClientStop \| LanguageClientStart<CR>
    autocmd InsertLeave * call LanguageClient#textDocument_formatting()
  endif
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endfunction


augroup LSP
  autocmd!
  autocmd FileType * call LC_maps()
augroup END

"""
" denite.vim
"""
" Denite
function! Denite_ctrlp()
    execute ':Denite  -buffer-name=files buffer file/rec:'.ProjectRootGuess().'/'
endfunction
let g:denite_source_history_yank_enable = 1
"call denite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <silent> <C-p>  :<C-u>Denite -split=floating -post-action=quit -buffer-name=files file/rec<cr>
nnoremap <C-c> :<C-u>Denite -split=floating -post-action=quit -buffer-name=explorer file<cr>
nnoremap <C-k> :<C-u>Denite -split=floating -post-action=quit -buffer-name=bookmark bookmark<cr>
nnoremap <C-o> :<C-u>Denite -split=floating -post-action=quit -buffer-name=outline documentSymbol<cr>
nnoremap <C-s> :<C-u>Denite -split=floating -post-action=quit -buffer-name=outline workspaceSymbol<cr>
nnoremap <C-b> :<C-u>Denite -split=floating -post-action=quit -buffer-name=grep grep<cr>
nnoremap <leader>y :<C-u>Denite -split=floating -buffer-name=yank history/yank<cr>

"call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git'])
"call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'final_opts', [])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup',  '--hidden', '--ignore', '.git', '--ignore', '.terraform', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#option('_', 'statusline', v:false)
call denite#custom#option('_', 'max_dynamic_update_candidates', 100000)

" Custom mappings for the denite buffer

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  call denite#do_map('open_filter_buffer')
endfunction


autocmd FileType denite-filter call s:denite_filter_settings()
function! s:denite_filter_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  inoremap <silent><buffer> <C-j>
  \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>
  \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  imap <silent><buffer><expr> <C-s> denite#do_action('split')
  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  call deoplete#custom#buffer_option('auto_complete', v:false)
  inoremap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
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
" vim-polygot
"""
let python_highlight_all=1

"""
" echodoc.vim
"""
let g:echodoc#enable_at_startup = 1

"""
" defx.nvim
"""
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <silent><buffer><expr> c defx#do_action('copy')
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> l defx#do_action('drop')
  nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> d defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
endfunction

nnoremap <C-c> :Defx -split=horizontal -winheight=15 -direction=botright -toggle<cr>
