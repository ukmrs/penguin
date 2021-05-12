call plug#begin('~/.local/share/nvim/plugged')

	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'gruvbox-community/gruvbox'
	Plug 'sainnhe/everforest'
	Plug 'marko-cerovac/material.nvim'

	Plug 'w0rp/ale'
	Plug 'ap/vim-css-color'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'

	Plug 'fatih/vim-go'
	Plug 'vimwiki/vimwiki'

	Plug 'tpope/vim-commentary'  "gcc to  comment
	Plug 'tpope/vim-surround'

	Plug 'jiangmiao/auto-pairs'
	Plug 'janko/vim-test'
	
	Plug 'justinmk/vim-sneak'

	Plug 'romainl/vim-cool'  "stop highlighting after search
	Plug 'tpope/vim-fugitive'  "git integration
		Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
		Plug 'https://github.com/tpope/vim-rhubarb'

	Plug 'itchyny/lightline.vim'
	Plug 'https://github.com/cespare/vim-toml'

call plug#end()


" Set of basic vim options
set background=dark " use dark mode
" set background=light "use light mode


syntax on

" colorscheme gruvbox
" let g:material_style = 'palenight'
colorscheme gruvbox

" set termguicolors
hi Normal guibg=NONE ctermbg=NONE

" background like normal terminal
set number relativenumber
set autoindent
set smarttab
set ignorecase
set smartcase
set undofile
set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey
set foldlevel=99
set sidescrolloff=3
set scrolloff=3
set tabstop=4
set shiftwidth=4
"
" undecided => yeet the statusbar
" set noshowmode
" set noruler
" set laststatus=0
" set noshowcmd
" set cmdheight=1
" end of undecided

" vimwiki bs start
set nocompatible
filetype plugin on
let g:vimwiki_table_mappings = 0
" vimwiki bs end
" comment
autocmd FileType kivy setlocal commentstring=#\ %s
" local
autocmd Filetype rust setlocal colorcolumn=100

autocmd Filetype python setlocal colorcolumn=80

" 'wombat', 'solarized', 'darcula'
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Syntax highlighting
let g:python_highlight_all = 1

" Vim sneak
let g:sneak#label = 1

" tex
let g:tex_no_error=1

" close this deoplete bullshit at the top
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Complete with <TAB>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" i am afraid to use this
" if has('nvim') && !empty($CONDA_PREFIX)
"   let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
" endif

" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"ALE
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\   'html': ['html-beautify'],
\   'htmldjango': ['html-beautify'],
\   'css': ['prettier'],
\   'javascript': ['prettier'],
\   'python': ['yapf'],
\   'rust': ['rustfmt'],
\   'c': ['clang-format'],
\}

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:go_def_mapping_enabled = 0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "haskell" }, -- List of parsers to ignore installing
  highlight = {
    enable = false,              -- false will disable the whole extension
    disable = { "c" },  -- list of language that will be disabled
  },
}
EOF

"==============
" Key Bindings
"==============

" Leader key
let mapleader = ' '
" nmap <space>f :CocCommand explorer --preset floating<CR>
nmap <space>e :CocCommand explorer<CR>
nnoremap <leader>q :q<CR>

"ESC
imap jk <Esc>
imap kj <Esc>
" imap <C-j> <Esc>
" vmap <C-j> <Esc>

vmap <leader>y "+y
"save
nnoremap <leader>s :w<CR>

"window navigation
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>

"terminal navigation
tnoremap <Esc> <C-\><C-n>

"Undotree
nnoremap <leader>u :UndotreeShow<CR>

" GoTo code navigation.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> gd <Plug>(coc-definition)
	nnoremap <silent> <leader>ds :call CocAction('jumpDefinition', 'split')<CR>
	nnoremap <silent> <leader>dv :call CocAction('jumpDefinition', 'vsplit')<CR>
	nnoremap <silent> <leader>dt :call CocAction('jumpDefinition', 'tabe')<CR>

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" ALE - Asynchronous Lint Engine
map <silent> <leader>o :ALEFix<CR>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
" nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
