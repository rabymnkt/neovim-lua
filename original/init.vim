call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-endwise'
Plug 'w0ng/vim-hybrid'
Plug 'osyo-manga/vim-anzu'
Plug 'EdenEast/nightfox.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
" Plug 'SirVer/ultisnips'
Plug 'sheerun/vim-polyglot'

Plug 'cohama/lexima.vim'
Plug 'dense-analysis/ale'
Plug 'tomasr/molokai'
Plug 'sainnhe/gruvbox-material' 
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'yuki-yano/fern-preview.vim'

" latex
Plug 'lervag/vimtex'
" fuzzy
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"------------------------------------------------------------------------------------------------

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'for' : ['markdown'], 'do': 'cd app && yarn install' }

"------------------------------------------------------------------------------------------------

call plug#end()

"------------------------------------------------------------------------------------------------
" ***********************************************************************************
" colorscheme の設定前に全角スペースの強調表示の設定をしないとエラーが出る．
" 全角スペースの背景を赤に変更
" autocmd Colorscheme * highlight FullWidthSpace ctermbg=darkcyan
autocmd Colorscheme * highlight FullWidthSpace guibg=darkcyan
autocmd VimEnter * match FullWidthSpace /　/

" カラースキーム系の設定
"
syntax on
set t_Co=256
set background=dark
" set notermguicolors
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_transparent_background=1
colorscheme gruvbox-material
let g:airline_theme = 'gruvbox_material'
" colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1
" let g:airline_theme = 'simple'
if has('termguicolors')
  set termguicolors
endif
" ***********************************************************************************

" leader キーの変更
let mapleader = "\<Space>"
let maplocalleader = " "
" -----------------------------------------------------------------------------------
" fzf.vimの設定
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <silent> <leader>ff :call FzfOmniFiles()<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fh :History<CR>
nnoremap <silent> <leader>fr :Rg<CR>
" <leader>fk で文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <silent> <leader>fk :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap <silent> <leader>fs vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap <silent> <leader>fs y:Rg <C-R>"<CR>
" -----------------------------------------------------------------------------------

" latex の設定
let g:tex_flavor = "latex"
let g:coc_filetype_map = {'tex': 'latex'}
" Please add below in your vimrc
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
" let g:vimtex_compiler_latexmk = {
"       \ 'background': 1,
"       \ 'build_dir': '',
"       \ 'continuous': 1,
"       \ 'options': [
"       \    '-pdfdvi', 
"       \    '-verbose',
"       \    '-file-line-error',
"       \    '-synctex=1',
"       \    '-interaction=nonstopmode',
"       \],
"       \}

" let g:vimtex_view_general_viewer
"       \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '-r @line @pdf @tex'
" let g:vimtex_view_method = 'skim' # Choose which program to use to view PDF file 
" let g:vimtex_view_skim_sync = 1 # Value 1 allows forward search after every successful compilation
" let g:vimtex_view_skim_activate = 1 # Value 1 allows change focus to skim after command `:VimtexView` is given

" ultisnips の設定
" let g:UltiSnipsExpandTrigger="<Tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-k>"
" let g:UltiSnipsJumpBackwardTrigger="<c-j>"
" fugitiveの設定
nnoremap <silent> <leader>ds :Gdiffsplit<CR>

" git 操作(gitgutter)
"" git操作
" g]で前の変更箇所へ移動する
nnoremap <silent> <leader>gp :GitGutterPrevHunk<CR>
" g[で次の変更箇所へ移動する
nnoremap <silent> <leader>gn :GitGutterNextHunk<CR>
" ghでdiffをハイライトする
nnoremap <silent> <leader>gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap <silent> <leader>gd :GitGutterPreviewHunk<CR>
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
" 記号の色を変更する
" highlight GitGutterAdd ctermfg=green
" highlight GitGutterChange ctermfg=blue
" highlight GitGutterDelete ctermfg=red

highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=blue
highlight GitGutterDelete guifg=red
" 反映時間を短くする(デフォルトは4000ms)
" set updatetime=250
" vim の syntax の適用のタイムアウトを延ばす（デフォルトは2000ms）
" set redrawtime=3000

" rubyのパス
let g:ruby_host_prog = '/usr/local/bin/neovim-ruby-host'

" airlineの設定
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = 'wombat'
let g:airline_powerline_fonts = 1
let g:airline#extensions#default#layout = [[ 'a', 'b', 'c' ], ['x', 'y']] 
let g:airline_section_c = '%t %M'
" タブラインの表示を変更する
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_close_button = 0
" let g:airline_theme = 'deus'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '>'

" vim-anzuの設定
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Fern の設定
" Ctrl+dでファイルツリーを表示/非表示する
nnoremap <silent> <C-d> :Fern . -reveal=% -drawer -stay -toggle -width=25<CR>
" アイコンの表示を有効化
let g:fern#renderer = 'nerdfont'
" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
" 隠しファイルも表示
let g:fern#default_hidden=1
" 公式リポジトリを参考にキーマップを追加
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

let g:fern#renderer#nerdfont#indent_markers = 1

" バッファ移動のショートカットキー設定
set hidden
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-h> :bprev<CR>

" ターミナルモードから抜けるためのキーバインド
tnoremap <silent> <ESC> <C-\><C-n>
" 常にinsert modeでterminalを開く
autocmd TermOpen * startinsert

"vimgrepの使用時に自動的にquickfix-windowを開くようにする
autocmd QuickFixCmdPost *grep* cwindow

" ale 
" let g:ale_lint_on_text_changed = 0
" シンボルカラムを表示したままにする
let g:ale_sign_column_always = 1
" 保存時に整形してくれる
let g:ale_fix_on_save = 1
" 補完してくれる
let g:ale_completion_enabled = 1
" エラー行に表示するマーク
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_linters = {
    \   'c' : ['clangd'],
    \   'cpp' : ['clangd']
\}
" --------------------------------------------------------------------------------------
" coc.nvimの設定
" coc.nvim の補完メニューの洗濯中の色を変更
hi CocMenuSel guifg=#cccccc guibg=#2a3d75

" 参考 : https://qiita.com/totto2727/items/d0844c79f97ab601f13b
inoremap <silent><expr> <C-y>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" autocomplete
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#cancel() : "\<Enter>"

"Diagnosticsの、左横のアイコンの色設定
highlight CocErrorSign guifg=15 guibg=196
highlight CocWarningSign guifg=0 guibg=172

"以下ショートカット

"ノーマルモードで
"スペースhでHover
nmap <silent> <leader>h :<C-u>call CocAction('doHover')<cr>
"スペースdfでDefinition
nmap <silent> <leader>df <Plug>(coc-definition)
"スペースrfでReferences
nmap <silent> <leader>rf <Plug>(coc-references)
"スペースrnでRename
nmap <silent> <leader>rn <Plug>(coc-rename)
"スペースfmtでFormat
nmap <silent> <leader>fmt <Plug>(coc-format)

" 補完ウィンドウも閉じつつnormal mode へ移行するため
imap <silent> <Esc> <Esc><Esc>

cnoremap W<CR> w<CR>

" coc-snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" --------------------------------------------------------------------------------------

" 全角カッコペアの追加
" Vim には標準で対応する括弧をハイライトしてくれます。
" それを日本語にも適用できるよう拡張しておきます。
set matchpairs+=（:）,「:」,『:』,【:】,［:］,＜:＞

" クリップボード連携設定
set clipboard&
set clipboard^=unnamedplus

set hidden

set completeopt=menuone,noinsert,noselect

" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup
" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup
" undoファイル(.un~)を生成しない
set noundofile
" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
" 全角文字専用の設定(neovimでは有効にすると画面がおかしくなった)
"set ambiwidth=double
" wildmenuオプションを有効(vimバーからファイルを選択できる)
set wildmenu
" コマンドラインでTAB補完時に大文字・小文字を区別しない
set wildignorecase
"----------------------------------------
" 検索
"----------------------------------------
" 検索するときに大文字小文字を区別しない
set ignorecase
" 小文字で検索すると大文字と小文字を無視して検索
set smartcase
" 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set wrapscan
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch
" 文字列検索のハイライトオフ
nmap <slient> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>
" ハイライトされた文字の色と背景色を指定
" 設定できる具体的な色に関してはコマンドで
" :so $VIMRUNTIME/syntax/colortest.vim
" を実行して確認できる

" 検索のハイライト
hi Search guibg=lightgreen
hi Search guifg=black

" diffのハイライト
" hi DiffAdd guibg=darkgreen
" hi DiffAdd guifg=white
" hi DiffChange guibg=darkcyan
" hi DiffChange guifg=white

"----------------------------------------
" 表示設定
"----------------------------------------
"カーソルラインのハイライト
set cursorline
" ファイルを下に開く
set splitbelow
" ファイルを右に開く
set splitright
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" Windowsでパスの区切り文字をスラッシュで扱う
set shellslash
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの履歴を10000件保存する
set history=10000
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=4
" タブキー押下時に挿入される文字幅を指定
set softtabstop=4
" ファイル内にあるタブ文字の表示幅
set tabstop=4
" ツールバーを非表示にする
set guioptions-=T
" yでコピーした時にクリップボードに入る
set guioptions+=a
" メニューバーを非表示にする
set guioptions-=m
" 右スクロールバーを非表示
set guioptions-=R
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
"改行時に，ブロックに応じて自動でインデントを挿入する
"set autoindent
"改行時に，ブロックに応じて自動でインデントを挿入しない
"set noautoindent
" set nosmartindent
"set nocindent
" スワップファイルを作成しない
set noswapfile
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" タイトルを表示
set title
" 行番号, 相対行番号の表示
set number relativenumber
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" すべての数を10進数として扱う
set nrformats=
" Vim内部で使われる文字エンコーディングをutf-8にする

" python2 providerを無効化
let g:loaded_python_provider = 0
" let g:python_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/usr/bin/python3'
hi Comment guifg=gray

if has('mouse')
  set mouse=a
endif

" ---------------------------------------------MarkdownPreview Config---------------------------------------------

" C-p2回押すとpreviewを表示
nnoremap  <C-p><C-p> :MarkdownPreview<CR>

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'light'
" ------------------------------------------------------------------------------------------------------

" 補完のwindowの透明度を設定
" set pumblend=10
