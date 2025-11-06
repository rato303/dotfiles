# カスタム bash 設定
# このファイルは ~/.bashrc から読み込まれます

# =====================================
# エイリアス
# =====================================

# ls エイリアス
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# 安全性向上のためのエイリアス
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# =====================================
# 環境変数
# =====================================

# カスタム bin ディレクトリが存在すれば PATH に追加
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# =====================================
# プロンプトのカスタマイズ
# =====================================

# カラフルなプロンプト（git ブランチ表示付き）
if [ -n "$PS1" ]; then
    # 色定義
    RED='\[\033[0;31m\]'
    GREEN='\[\033[0;32m\]'
    YELLOW='\[\033[0;33m\]'
    BLUE='\[\033[0;34m\]'
    RESET='\[\033[0m\]'

    # プロンプトに git ブランチを表示する関数
    parse_git_branch() {
        git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
    }

    export PS1="${GREEN}\u@\h${RESET}:${BLUE}\w${RESET}${YELLOW}\$(parse_git_branch)${RESET}\$ "
fi

# =====================================
# 関数
# =====================================

# ディレクトリを作成して移動
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 各種アーカイブ形式を展開
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' は extract() で展開できません" ;;
        esac
    else
        echo "'$1' は有効なファイルではありません"
    fi
}

# =====================================
# ヒストリー設定
# =====================================

# ヒストリーサイズを拡大
export HISTSIZE=10000
export HISTFILESIZE=20000

# ヒストリーに重複エントリを保存しない
export HISTCONTROL=ignoredups:erasedups

# ヒストリーファイルに追記（上書きしない）
shopt -s histappend

# =====================================
# カスタム設定
# =====================================

# この行の下に独自の設定を追加してください
