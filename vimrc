colorscheme codedark

call plug#begin("~/.vim/plugin")

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ' 

call plug#end()

set number
set title
set showmatch
set history=10000
set hlsearch
set incsearch
set smartcase
syntax on

let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#default#layout = [
  \ [ 'a', 'b', 'c' ],
  \ ['z']
  \ ]
let g:airline_section_c = '%t %M'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#hunks#non_zero_only = 1

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_autocompleteopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enalbed = 1

nnoremap tc :tabnew<CR>
nnoremap tp :tabp<CR>
nnoremap tn :tabn<CR>
nnoremap tx :tabclose<CR> 
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

augroup my-glyph-palette
	autocmd! *
	autocmd FileType fern call glyph_palette#apply()
augroup END

augroup MyLsp
	autocmd!
	if executable('pyls')
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': {servier_info -> ['pyls']},
					\ 'whitelist': ['python'],
					\ 'workspace_config': {
					\	'pyls': {
					\		'plugins': {
					\			'jedi_definition': {
					\				'follow_imports': v:true,
					\				'follow_builtin_imports': v:true,
					\			},
					\			'pyls_mypy': {
					\				'enabled': 1,
					\			}
					\		}
					\	}
					\ }
					\ })
		autocmd FileType python call s:configure_lsp()
	endif
augroup END

function! s:configure_lsp() abort
	setlocal omnifunc=lsp#complete
	nnoremap <buffer> gd :<C-u>LspDefinition<CR>
	nnoremap <buffer> gD :<C-u>LspReference<CR>
	nnoremap <buffer> K  :<C-u>LspHover<CR>
endfunction

let g:lsp_diagnostics_enabled = 0
