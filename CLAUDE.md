# CLAUDE.md

このファイルは、AI アシスタントがこのプロジェクトを理解し、適切に作業するためのコンテキストとガイドラインを提供します。

## プロジェクト概要

個人用 dotfiles 設定管理リポジトリ。bash や Git などの設定ファイルを、既存の環境を壊さずに安全に管理する仕組みを提供します。

## 技術仕様

- **対象OS**: Ubuntu
- **シェル**: `/bin/bash`
- **互換性**: POSIX準拠に近い形式（可能な限り移植性を重視）
- **文字コード**: UTF-8

## 設計方針

### 管理方式

**ソーシング方式**を採用:
- 既存の `~/.bashrc` に dotfiles の設定ファイルを読み込む行を追加
- 既存設定を完全に保持しつつ、追加で dotfiles の設定を適用
- シンボリックリンク方式ではなく、ソーシング方式を選択した理由:
  - 既存設定を壊さない
  - 既存設定と dotfiles 設定の両方が適用される
  - より安全で予測可能な動作

### 冪等性の保証

- `install.sh` は何度実行しても安全に動作
- 既に設定が追加されている場合はスキップ
- エラーからの復旧が容易

### 安全性

- 変更前に必ずバックアップを作成
- 既存ファイルの内容は一切削除・上書きしない
- エラーハンドリングを適切に実装（`set -e` の使用）

## コーディング規約

### 1. コメントとドキュメント

**必須**: すべてのコメントは日本語で記載すること

```bash
# 良い例
# ヒストリーサイズを拡大
export HISTSIZE=10000

# 悪い例
# Increase history size
export HISTSIZE=10000
```

### 2. POSIX準拠

可能な限り POSIX準拠の記法を使用すること:

#### echo -e → printf

```bash
# 良い例
printf "${GREEN}成功しました${NC}\n"

# 悪い例
echo -e "${GREEN}成功しました${NC}"
```

#### source → . (ドット)

```bash
# 良い例
. "$HOME/.bashrc"

# 悪い例
source "$HOME/.bashrc"
```

#### ${BASH_SOURCE[0]} → $0

```bash
# 良い例
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 悪い例
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

### 3. 変数の引用

常に変数を二重引用符で囲むこと:

```bash
# 良い例
if [ -f "$HOME_BASHRC" ]; then
    cp "$HOME_BASHRC" "$BACKUP_FILE"
fi

# 悪い例
if [ -f $HOME_BASHRC ]; then
    cp $HOME_BASHRC $BACKUP_FILE
fi
```

### 4. エラーハンドリング

- スクリプトの冒頭で `set -e` を使用
- 重要な処理の前に存在確認を実施
- ユーザーへのフィードバックは明確に

## ファイル構成

```
dotfiles/
├── .bashrc           # カスタム bash 設定
├── .gitconfig        # Git 設定（エイリアス、カラー設定など）
├── .vimrc            # Vim 設定（基本設定、キーマッピングなど）
├── install.sh        # インストールスクリプト（冪等性あり）
├── README.md         # プロジェクトドキュメント（日本語）
└── CLAUDE.md         # このファイル
```

## 拡張性

### 現在管理している設定ファイル

- `.bashrc` - bash 設定（ソーシング方式）
- `.gitconfig` - Git 設定（include 方式）
- `.vimrc` - Vim 設定（シンボリックリンク方式）

### 将来の追加予定

このリポジトリは将来的に以下のファイルも管理する予定:
- `.tmux.conf` - tmux 設定
- `.zshrc` - zsh 設定
- その他の設定ファイル

### 拡張時のガイドライン

新しい dotfile を追加する際は:
1. リポジトリに設定ファイルを追加
2. `install.sh` に処理を追加
3. 適切な管理方式を選択:
   - **ソーシング方式**: `.bashrc` のように `. (ドット)` で読み込む
   - **Include 方式**: `.gitconfig` のように専用の include 機能を使用
   - **シンボリックリンク方式**: 完全に置き換える場合
4. 冪等性を保つ（既に設定済みなら何もしない）
5. バックアップを作成してから変更
6. README.md と CLAUDE.md を更新

## install.sh の動作フロー

### .bashrc のセットアップ

1. dotfiles ディレクトリの絶対パスを取得
2. `dotfiles/.bashrc` の存在確認
3. `~/.bashrc` が存在しない場合は作成
4. 既に設定が追加されているかチェック
   - 追加済み → 何もせず（冪等性）
   - 未追加 → 次のステップへ
5. `~/.bashrc` のバックアップを作成
6. `~/.bashrc` に `. (ドット)` による読み込み設定を追記
7. 完了メッセージを表示

### .gitconfig のセットアップ

1. `dotfiles/.gitconfig` の存在確認（なければスキップ）
2. `~/.gitconfig` が存在しない場合は作成
3. 既に include 設定が追加されているかチェック
   - 追加済み → 何もせず（冪等性）
   - 未追加 → 次のステップへ
4. `~/.gitconfig` のバックアップを作成
5. `~/.gitconfig` に `[include]` セクションを追記
6. 完了メッセージを表示

### .vimrc のセットアップ

1. `dotfiles/.vimrc` の存在確認（なければスキップ）
2. シンボリックリンクが既に存在し、正しいターゲットを指しているかチェック
   - 正しいリンクあり → 何もせず（冪等性）
   - なしまたは異なるリンク → 次のステップへ
3. 既存のファイルまたはリンクがあればバックアップを作成
4. `dotfiles/.vimrc` への新しいシンボリックリンクを作成
5. 完了メッセージを表示

## 実装時の注意点

### grep のパターンマッチング

#### .bashrc の場合

`. (ドット)` によるソーシングを検出:

```bash
SOURCE_CHECK_PATTERN="\. .*$DOTFILES_DIR/\.bashrc"
```

#### .gitconfig の場合

`[include]` セクションの path を検出:

```bash
GITCONFIG_CHECK_PATTERN="path.*=.*$DOTFILES_DIR/\.gitconfig"
```

#### .vimrc の場合

シンボリックリンクの存在と正しさを確認:

```bash
# シンボリックリンクかつ正しいターゲットを指している
if [ -L "$HOME_VIMRC" ] && [ "$(readlink "$HOME_VIMRC")" = "$DOTFILES_VIMRC" ]; then
    # 冪等性: 何もしない
fi
```

### heredoc の使用

heredoc を使って複数行を追加する際の形式:

#### .bashrc への追加

```bash
cat >> "$HOME_BASHRC" << EOF

# =====================================
# Dotfiles 設定
# =====================================
# dotfiles/install.sh により $(date) に追加
if [ -f "$DOTFILES_BASHRC" ]; then
    . "$DOTFILES_BASHRC"
fi
EOF
```

#### .gitconfig への追加

```bash
cat >> "$HOME_GITCONFIG" << EOF

# =====================================
# Dotfiles 設定
# =====================================
# dotfiles/install.sh により $(date) に追加
[include]
	path = $DOTFILES_GITCONFIG
EOF
```

## .bashrc の構成

設定は以下のセクションに分類:

1. **エイリアス**: シェル関連のエイリアス（ls, rm, cp, mv など）
   - **注意**: Git エイリアスは `.gitconfig` で管理
2. **環境変数**: PATH などの環境設定
3. **プロンプトのカスタマイズ**: PS1 の設定、git ブランチ表示
4. **関数**: 便利な関数定義（mkcd, extract など）
5. **ヒストリー設定**: コマンド履歴の管理
6. **カスタム設定**: ユーザー独自の設定エリア

## .gitconfig の構成

設定は以下のセクションに分類:

1. **[alias]**: Git コマンドの短縮形（s, a, c, pp, l など）
2. **[color]**: カラー出力設定（ブランチ、差分、ステータス）
3. **[core]**: コア設定（エディタ、改行コード処理など）
4. **[pull]**: pull 時の動作設定
5. **[init]**: デフォルトブランチ名

**重要**: ユーザー情報（name, email）は `~/.gitconfig` で個別に設定する

## .vimrc の構成

設定は以下のセクションに分類:

1. **基本設定**: Vi 互換モード無効化、ファイルタイプ検出、シンタックスハイライト
2. **表示設定**: 行番号、カーソル行ハイライト、ステータスライン、括弧マッチング
3. **インデント設定**: 自動インデント、タブ幅、スペース展開
4. **検索設定**: 大文字小文字の扱い、インクリメンタルサーチ、ハイライト
5. **編集設定**: バックスペース動作、クリップボード共有、スワップファイル無効化
6. **キーマッピング**: Leader キー、jj で Esc、ウィンドウ操作、タブ操作
7. **ファイルタイプ別設定**: Python, JavaScript, HTML, YAML など

## ベストプラクティス

### シェルスクリプト

- ShellCheck でリントを実施することを推奨
- 可読性を重視したコード
- 適切なコメントで意図を明確に

### Git コミット

- わかりやすいコミットメッセージ（日本語可）
- 論理的な単位でコミット
- 大きな変更は複数のコミットに分割

## トラブルシューティング

### よくある問題

1. **スクリプトが実行できない**
   - `chmod +x install.sh` で実行権限を付与

2. **設定が反映されない**
   - `. ~/.bashrc` で再読み込み
   - または新しいターミナルセッションを開く

3. **バックアップから復元したい**
   ```bash
   # .bashrc の復元
   cp ~/.bashrc.backup.YYYYMMDD_HHMMSS ~/.bashrc
   . ~/.bashrc

   # .gitconfig の復元
   cp ~/.gitconfig.backup.YYYYMMDD_HHMMSS ~/.gitconfig

   # .vimrc の復元（シンボリックリンクを削除してから）
   rm ~/.vimrc
   cp ~/.vimrc.backup.YYYYMMDD_HHMMSS ~/.vimrc
   ```

## 参考リンク

- [POSIX Shell Command Language](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html)
- [ShellCheck](https://www.shellcheck.net/)
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [Vim Documentation](https://www.vim.org/docs.php)
- [Git Configuration](https://git-scm.com/docs/git-config)

## 更新履歴

このファイルはプロジェクトの進化に合わせて更新してください。
