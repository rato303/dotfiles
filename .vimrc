" スワップファイル無効化
set noswapfile
" カーソルの行列表示
set ruler
" インクリメンタルサーチの有効化
set incsearch
" 検索結果のハイライト表示
set hlsearch
" ESCを2回押下でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ヤンクをクリップボードに自動的にコピー
set clipboard=unnamedplus

" 暗い背景色に合わせた配色
set background=dark

" タブ入力を空白入力に置き換える
set expandtab
" タブを挿入した時のスペース数
set tabstop=2
" 行番号を表示する
set number
" 自動インデントでずれる幅
set shiftwidth=2

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" ここの設定以降は右寄せ表示
set statusline+=%=
" ファイルエンコーディング
set statusline+=[ENC=%{&fileencoding}]
" ファイルフォーマット
set statusline+=[FORMAT=%{&fileformat}]
" BOM表示
" 0:BOMなし
" 1:BOMあり
set statusline+=[BOM=%{&bomb}]
" ステータスラインを常に表示
set laststatus=2

" 改行コード(LF)
set fileformat=unix
" ファイルエンコーディング
set encoding=utf-8

" 標準のsキーを打ち消す
nnoremap s <Nop>

" ウィンドウを分割する
" 水平分割
nnoremap ss <C-w>s
" 垂直分割
nnoremap sv <C-w>v

" 分割したウィンドウ間を移動する
" 左に移動
nnoremap sh <C-w>h
" 下に移動
nnoremap sj <C-w>j
" 上に移動
nnoremap sk <C-w>k
" 右に移動
nnoremap sl <C-w>l

" ウィンドウを移動する
" 左に移動
nnoremap sH <C-w>H
" 下に移動
nnoremap sJ <C-w>J
" 上に移動
nnoremap sK <C-w>K
" 右に移動
nnoremap sL <C-w>L
" 回転
nnoremap sr <C-w>r

" カレントウィンドウの大きさを変える
" 大きさを揃える
nnoremap s= <C-w>=
" 幅を増やす
nnoremap s> <C-w>>
" 幅を減らす
nnoremap s< <C-w><
" 高さを増やす
nnoremap s+ <C-w>+
" 高さを減らす
nnoremap s- <C-w>-

" ウィンドウを閉じる
nnoremap sq :<C-u>q<CR>

" タブ
set showtabline=2
" 新規タブ
nnoremap st :<C-u>tabnew<CR>
" 次のタブに切替
nnoremap sn gt
" 前のタブに切替
nnoremap sp gT

" deinの定義
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('~/.vim/dein')
let s:toml_dir = expand('~/.vim/dein/toml')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " Load TOML
  let s:toml = s:toml_dir . '/plugins.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  " finalize
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ファイルツリー表示用プラグイン
if dein#check_install(['vim-submode'])
else
  map <C-n> :NERDTreeToggle<CR>
endif
" ウィンドウリサイズを連続で行えるようにvim-submodeで制御
if dein#check_install(['vim-submode'])
else
  call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
  call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
  call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
  call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
  call submode#map('bufmove', 'n', '', '>', '<C-w>>')
  call submode#map('bufmove', 'n', '', '<', '<C-w><')
  call submode#map('bufmove', 'n', '', '+', '<C-w>+')
  call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endif

filetype plugin indent on
