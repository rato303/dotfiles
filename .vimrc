" Vim 設定
" このファイルは ~/.vimrc からシンボリックリンクされます

" =====================================
" 基本設定
" =====================================

" Vim の拡張機能を有効化（Vi 互換モードを無効化）
set nocompatible

" ファイルタイプ検出とプラグインを有効化
filetype plugin indent on

" シンタックスハイライトを有効化
syntax on

" 文字コード設定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis

" =====================================
" 表示設定
" =====================================

" 行番号を表示
set number

" 相対行番号を表示（現在行からの相対位置）
" set relativenumber

" カーソル行をハイライト
set cursorline

" コマンドを画面下部に表示
set showcmd

" 現在のモードを表示
set showmode

" ステータスラインを常に表示
set laststatus=2

" タイトルを表示
set title

" 対応する括弧をハイライト
set showmatch

" 長い行を折り返して表示
set wrap

" 行末の1文字先までカーソル移動を許可
set virtualedit=onemore

" ビープ音を無効化
set visualbell
set t_vb=

" =====================================
" インデント設定
" =====================================

" 自動インデント
set autoindent

" スマートインデント
set smartindent

" タブをスペースに展開
set expandtab

" タブ幅
set tabstop=4

" 自動インデント時の幅
set shiftwidth=4

" タブキー入力時の幅
set softtabstop=4

" =====================================
" 検索設定
" =====================================

" 検索時に大文字小文字を区別しない
set ignorecase

" 検索文字列に大文字が含まれる場合は区別する
set smartcase

" インクリメンタルサーチを有効化
set incsearch

" 検索結果をハイライト
set hlsearch

" 検索が末尾まで進んだら先頭から再検索
set wrapscan

" =====================================
" 編集設定
" =====================================

" バックスペースでインデント、改行、挿入開始位置前の文字を削除可能に
set backspace=indent,eol,start

" クリップボードを共有
set clipboard=unnamed,unnamedplus

" スワップファイルを作成しない
set noswapfile

" バックアップファイルを作成しない
set nobackup

" アンドゥファイルを作成しない
set noundofile

" 自動保存
" set autowrite

" =====================================
" キーマッピング
" =====================================

" Leader キーを設定
let mapleader = "\<Space>"

" jj で Esc
inoremap jj <Esc>

" 検索ハイライトを Esc で消去
nnoremap <Esc><Esc> :nohlsearch<CR>

" Y を行末までヤンクに変更（yy との一貫性）
nnoremap Y y$

" 折り返し行での移動を自然に
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" ウィンドウ分割
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>s :split<CR>

" ウィンドウ間移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" タブ操作
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>n :tabnext<CR>
nnoremap <Leader>p :tabprevious<CR>

" =====================================
" ファイルタイプ別設定
" =====================================

" Python
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4

" JavaScript / TypeScript
autocmd FileType javascript,typescript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" HTML / CSS
autocmd FileType html,css setlocal tabstop=2 shiftwidth=2 softtabstop=2

" YAML
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Makefile（タブを保持）
autocmd FileType make setlocal noexpandtab

" =====================================
" カスタム設定
" =====================================

" この行の下に独自の設定を追加してください
