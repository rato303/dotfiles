#!/bin/bash

# dotfiles インストールスクリプト
# このスクリプトは既存の設定ファイルを壊さずに dotfiles の設定を追加します
# 対象: .bashrc, .gitconfig, .vimrc
# 何度実行しても安全です（冪等性）

set -e

# 出力用の色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 色なし

# dotfilesディレクトリの絶対パスを取得
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_BASHRC="$DOTFILES_DIR/.bashrc"
DOTFILES_GITCONFIG="$DOTFILES_DIR/.gitconfig"
DOTFILES_VIMRC="$DOTFILES_DIR/.vimrc"
HOME_BASHRC="$HOME/.bashrc"
HOME_GITCONFIG="$HOME/.gitconfig"
HOME_VIMRC="$HOME/.vimrc"

printf "${BLUE}==================================${NC}\n"
printf "${BLUE}Dotfiles インストールスクリプト${NC}\n"
printf "${BLUE}==================================${NC}\n"
printf "\n"
printf "Dotfilesディレクトリ: ${GREEN}%s${NC}\n" "$DOTFILES_DIR"
printf "\n"

# dotfiles/.bashrc の存在確認
if [ ! -f "$DOTFILES_BASHRC" ]; then
    printf "${RED}エラー: %s が見つかりません${NC}\n" "$DOTFILES_BASHRC"
    exit 1
fi

# ~/.bashrc が存在しない場合は作成
if [ ! -f "$HOME_BASHRC" ]; then
    printf "${YELLOW}~/.bashrc が存在しません。新規作成します...${NC}\n"
    touch "$HOME_BASHRC"
    printf "${GREEN}~/.bashrc を作成しました${NC}\n"
fi

# 読み込み設定が既に追加されているか確認
SOURCE_CHECK_PATTERN="\. .*$DOTFILES_DIR/\.bashrc"

if grep -qE "$SOURCE_CHECK_PATTERN" "$HOME_BASHRC" 2>/dev/null; then
    printf "${YELLOW}dotfiles/.bashrc は既に ~/.bashrc で読み込まれています${NC}\n"
    printf "${GREEN}✓ 変更は不要です（冪等性）${NC}\n"
else
    printf "${BLUE}~/.bashrc に dotfiles 設定を追加しています...${NC}\n"

    # 既存の .bashrc をバックアップ
    BACKUP_FILE="$HOME_BASHRC.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$HOME_BASHRC" "$BACKUP_FILE"
    printf "${GREEN}バックアップを作成しました: %s${NC}\n" "$BACKUP_FILE"

    # 読み込み設定を追加
    cat >> "$HOME_BASHRC" << EOF

# =====================================
# Dotfiles 設定
# =====================================
# dotfiles/install.sh により $(date) に追加
if [ -f "$DOTFILES_BASHRC" ]; then
    . "$DOTFILES_BASHRC"
fi
EOF

    printf "${GREEN}✓ ~/.bashrc に dotfiles 設定を追加しました${NC}\n"
fi

printf "\n"

# =====================================
# .gitconfig のセットアップ
# =====================================

printf "${BLUE}--- .gitconfig の設定 ---${NC}\n"

# dotfiles/.gitconfig の存在確認
if [ ! -f "$DOTFILES_GITCONFIG" ]; then
    printf "${YELLOW}警告: %s が見つかりません（スキップ）${NC}\n" "$DOTFILES_GITCONFIG"
else
    # ~/.gitconfig が存在しない場合は作成
    if [ ! -f "$HOME_GITCONFIG" ]; then
        printf "${YELLOW}~/.gitconfig が存在しません。新規作成します...${NC}\n"
        touch "$HOME_GITCONFIG"
        printf "${GREEN}~/.gitconfig を作成しました${NC}\n"
    fi

    # include 設定が既に追加されているか確認
    GITCONFIG_CHECK_PATTERN="path.*=.*$DOTFILES_DIR/\.gitconfig"

    if grep -qE "$GITCONFIG_CHECK_PATTERN" "$HOME_GITCONFIG" 2>/dev/null; then
        printf "${YELLOW}dotfiles/.gitconfig は既に ~/.gitconfig で読み込まれています${NC}\n"
        printf "${GREEN}✓ 変更は不要です（冪等性）${NC}\n"
    else
        printf "${BLUE}~/.gitconfig に dotfiles 設定を追加しています...${NC}\n"

        # 既存の .gitconfig をバックアップ
        BACKUP_FILE="$HOME_GITCONFIG.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$HOME_GITCONFIG" "$BACKUP_FILE"
        printf "${GREEN}バックアップを作成しました: %s${NC}\n" "$BACKUP_FILE"

        # include 設定を追加
        cat >> "$HOME_GITCONFIG" << EOF

# =====================================
# Dotfiles 設定
# =====================================
# dotfiles/install.sh により $(date) に追加
[include]
	path = $DOTFILES_GITCONFIG
EOF

        printf "${GREEN}✓ ~/.gitconfig に dotfiles 設定を追加しました${NC}\n"
    fi
fi

printf "\n"

# =====================================
# .vimrc のセットアップ
# =====================================

printf "${BLUE}--- .vimrc の設定 ---${NC}\n"

# dotfiles/.vimrc の存在確認
if [ ! -f "$DOTFILES_VIMRC" ]; then
    printf "${YELLOW}警告: %s が見つかりません（スキップ）${NC}\n" "$DOTFILES_VIMRC"
else
    # シンボリックリンクが既に存在し、正しいターゲットを指している場合
    if [ -L "$HOME_VIMRC" ] && [ "$(readlink "$HOME_VIMRC")" = "$DOTFILES_VIMRC" ]; then
        printf "${YELLOW}~/.vimrc は既に dotfiles/.vimrc へのシンボリックリンクです${NC}\n"
        printf "${GREEN}✓ 変更は不要です（冪等性）${NC}\n"
    else
        # 既存のファイルまたはリンクが存在する場合はバックアップ
        if [ -e "$HOME_VIMRC" ] || [ -L "$HOME_VIMRC" ]; then
            BACKUP_FILE="$HOME_VIMRC.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$HOME_VIMRC" "$BACKUP_FILE"
            printf "${GREEN}既存のファイルをバックアップしました: %s${NC}\n" "$BACKUP_FILE"
        fi

        # シンボリックリンクを作成
        ln -s "$DOTFILES_VIMRC" "$HOME_VIMRC"
        printf "${GREEN}✓ ~/.vimrc へのシンボリックリンクを作成しました${NC}\n"
    fi
fi

printf "\n"
printf "${BLUE}==================================${NC}\n"
printf "${GREEN}インストール完了！${NC}\n"
printf "${BLUE}==================================${NC}\n"
printf "\n"
printf "変更を反映するには: ${YELLOW}. ~/.bashrc${NC}\n"
printf "または新しいターミナルを開いてください。\n"
printf "\n"
