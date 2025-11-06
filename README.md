# dotfiles

個人用 dotfiles 設定管理リポジトリ

## 特徴

- **安全なインストール**: 既存の設定を保持
- **冪等性**: 何度実行しても安全
- **拡張性**: 他の dotfiles も簡単に追加可能

## 内容

- `.bashrc` - カスタム bash 設定（エイリアス、関数、プロンプトなど）
- `.gitconfig` - Git 設定（エイリアス、カラー設定など）
- `.vimrc` - Vim 設定（基本設定、キーマッピングなど）
- `install.sh` - インストールスクリプト

## インストール方法

1. このリポジトリをホームディレクトリ（または任意の場所）にクローン:
   ```bash
   git clone <repository-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. インストールスクリプトを実行:
   ```bash
   ./install.sh
   ```

3. 変更を反映:
   ```bash
   . ~/.bashrc
   ```
   または新しいターミナルセッションを開いてください。

## 動作の仕組み

`install.sh` スクリプトは、既存の設定ファイルに dotfiles の設定を読み込む設定を追加します。

### .bashrc の場合

既存の `~/.bashrc` に読み込み設定を追加:

```bash
# Dotfiles 設定
if [ -f "$HOME/dotfiles/.bashrc" ]; then
    . "$HOME/dotfiles/.bashrc"
fi
```

### .gitconfig の場合

既存の `~/.gitconfig` に include 設定を追加:

```ini
# Dotfiles 設定
[include]
    path = /path/to/dotfiles/.gitconfig
```

### .vimrc の場合

シンボリックリンク方式で管理:

```bash
~/.vimrc -> /path/to/dotfiles/.vimrc
```

既存の `~/.vimrc` があればバックアップを作成してから置き換えます。

### このアプローチの利点

- 既存設定を**すべて保持**（.bashrc, .gitconfig の場合）
- dotfiles のカスタム設定を**追加**または**置き換え**
- 変更前に元のファイルの**バックアップを作成**
- 各ツールの標準的な管理方法を採用

## カスタマイズ

### .bashrc

以下を追加できます:
- エイリアス（ls, rm など）
- 関数
- 環境変数
- プロンプトのカスタマイズ
- シェルオプション

### .gitconfig

以下をカスタマイズできます:
- Git エイリアス（`git s` = `git status` など）
- カラー設定
- エディタ設定
- デフォルトブランチ名

**注意**: ユーザー情報（name, email）は `~/.gitconfig` で個別に設定してください。

### .vimrc

以下をカスタマイズできます:
- 基本設定（行番号、シンタックスハイライトなど）
- インデント設定
- 検索設定
- キーマッピング（`jj` で Esc など）
- ファイルタイプ別設定

## アンインストール

dotfiles 設定を削除するには:

1. `~/.bashrc` と `~/.gitconfig` を編集して dotfiles セクション（コメント付き）を削除
2. `~/.vimrc` のシンボリックリンクを削除: `rm ~/.vimrc`
3. bash 設定を再読み込み: `. ~/.bashrc`

または、インストール時に作成されたバックアップファイルから復元:
```bash
# .bashrc の復元
cp ~/.bashrc.backup.YYYYMMDD_HHMMSS ~/.bashrc
. ~/.bashrc

# .gitconfig の復元
cp ~/.gitconfig.backup.YYYYMMDD_HHMMSS ~/.gitconfig

# .vimrc の復元
cp ~/.vimrc.backup.YYYYMMDD_HHMMSS ~/.vimrc
```

## 他の dotfiles の追加

追加の設定ファイル（`.tmux.conf`、`.zshrc` など）を管理するには:

1. このリポジトリにファイルを追加
2. `install.sh` を更新して新しいファイルを管理
3. 適切な管理方式を選択:
   - **ソーシング方式**: `.bashrc` を参考
   - **Include 方式**: `.gitconfig` を参考
   - **シンボリックリンク方式**: `.vimrc` を参考
4. 既存ファイルと同じ冪等性パターンを適用

## ライセンス

自由に使用・変更できます。