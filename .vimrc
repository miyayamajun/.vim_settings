set nocompatible

" bundleというフォルダをvimのruntimepathに追加する。
for path in split(glob('~/.vim_settings/bundle/*'), '\n')
   if isdirectory(path) | let &runtimepath = &runtimepath.','.path | end
endfor

"neobundle.vimの設定
"neobundle.vimをruntimepathに追加。
filetype plugin indent off
set runtimepath+='~/.vim_settings/bundle/neobundle.vim'

" 読み込むプラグインの指定
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'git://github.com/Shougo/neobundle.vim'
call neobundle#end()

" コード補完プラグイン
NeoBundle 'git://github.com/Shougo/neocomplcache.vim'
NeoBundle 'git://github.com/Shougo/neosnippet-snippets'
NeoBundle 'git://github.com/Shougo/neosnippet'

" 補完用言語別辞書
NeoBundle 'git://github.com/nishigori/vim-php-dictionary'

" 任意の文字で選択範囲を囲うプラグイン
NeoBundle 'git://github.com/tpope/vim-surround'

" HTML,CSS入力支援プラグイン
NeoBundle 'git://github.com/mattn/emmet-vim'

" シンタックスハイライト用
NeoBundle 'git://github.com/othree/html5.vim.git'
NeoBundle 'git://github.com/hail2u/vim-css3-syntax'
NeoBundle 'git://github.com/cakebaker/scss-syntax.vim'

" プロジェクト表示
NeoBundle 'git://github.com/vimplugin/project.vim'

" シンタックスエラーチェック
NeoBundle 'git://github.com/scrooloose/syntastic.git'

" エスケープ
NeoBundle 'git://github.com/idbrii/textconv.vim'

" ag.vim
NeoBundle 'git://github.com/rking/ag.vim'

" NERDTree
NeoBundle 'scrooloose/nerdtree'

filetype plugin indent on

colorscheme slate
syntax on
set noswapfile
set nobackup
set number
set backspace=2
set tabstop=4
set expandtab
set shiftwidth=4
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ascii,sjis,euc-jp,utf-8
set clipboard+=unnamed
set autoindent
set smartindent

" 連続インデント
vnoremap < <gv
vnoremap > >gv

if has('persistent_undo')
    set undodir=~/.vimundo
    augroup vimrc-undofile
        autocmd!
        autocmd BufReadPre ~/* setlocal undofile
    augroup END
endif

"set guifont=Consolas:h12:cSHIFTJIS
set ambiwidth=double

set dictionary=~/.vim_settings/bundle/vim-php-dictionary/dict/PHP.dict
autocmd FileType php,tpl :set dictionary=~/.vim_settings/bundle/vim-php-dictionary/dict/PHP.dict

" neocomplcache
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
	    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"

" for textconv
vmap te :ConvertToEntities<Return>
vmap fe :ConvertFromEntities<Return>
vmap tu :ConvertToUrlEncoding<Return>
vmap fu :ConvertFromUrlEncoding<Return>
vmap th :ConvertToHtmlEntities<Return>
vmap fh :ConvertFromHtmlEntities<Return>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" タグ記号とか&をエスケープする
function! ConvertToHtmlEntities()
    silent s/&\(\w\+;\)\@!/\&amp;/ge
    silent s/>/\&gt;/ge
    silent s/</\&lt;/ge
    silent s/\%V"/\&quot;/ge
    silent s/\%V'/\&#039;/ge
endfunction

function! ConvertFromHtmlEntities()
    silent s/&#039;/'/ge
    silent s/&quot;/"/ge
    silent s/&lt;/</ge
    silent s/&gt;/>/ge
    silent s/&amp;/\&/ge
endfunction

command! -range ConvertToHtmlEntities :<line1>,<line2> call ConvertToHtmlEntities()
command! -range ConvertFromHtmlEntities :<line1>,<line2> call ConvertFromHtmlEntities()

" NERDTree settings
nnoremap <silent><C-e> :NERDTreeToggle<CR>
