" スワップファイル無効化
set noswapfile
" カーソルの行列表示
set ruler
" 検索結果のハイライト表示
set hlsearch
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

" deinの定義
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin('~/.vim/dein')

call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/unite.vim')

call dein#end()

filetype plugin indent on
