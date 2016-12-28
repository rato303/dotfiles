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

call dein#begin('~/.vim/dein')

call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/unite.vim')
call dein#add('MaxMEllon/vim-jsx-pretty')

call dein#add('scrooloose/nerdtree')
map <C-n> :NERDTreeToggle<CR>

call dein#add('Yggdroot/indentLine')

call dein#end()

filetype plugin indent on
