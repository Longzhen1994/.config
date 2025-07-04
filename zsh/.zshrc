# ~/.config/zsh/.zshrc (仅交互式 shell）

# 历史设置
# 修改 HISTFILE 路径，使用 XDG 规范
HISTFILE="$XDG_STATE_HOME/zsh/history"
[ -d "$(dirname $HISTFILE)" ] || mkdir -p "$(dirname $HISTFILE)"
HISTSIZE=5000
SAVEHIST=3000
setopt HIST_IGNORE_ALL_DUPS  # 忽略重复命令
setopt HIST_IGNORE_SPACE  # 忽略空格开头的命令
setopt HIST_FIND_NO_DUPS  # 历史搜索时不重复

# 补全设置
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
    zstyle ':completion:*' history true
    zstyle ':completion:*' insecure yes

    autoload -Uz compinit
    compinit -u -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi
# if type brew &>/dev/null; then
#   FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
#   # 使用 XDG 路径存储补全缓存
#   zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
#   [ -d "$XDG_CACHE_HOME/zsh/zcompcache" ] || mkdir -p "$XDG_CACHE_HOME/zsh/zcompcache"
#   autoload -Uz compinit
#   compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
# fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 设置大小写不敏感的补全

# 其他选项
setopt BEEP
setopt COMBINING_CHARS # 正确显示 UTF-8 组合字符

# 初始化 Homebrew（添加 Homebrew bin 目录和变量到 PATH）
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# 加载插件
if [ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# 别名定义
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias ls='gls --color=auto --group-directories-first'
alias la='gls -A --color=auto --group-directories-first'
alias ll='gls -lh --color=auto --group-directories-first'
alias lsla='gls -lhA --color=auto --group-directories-first'

# alias emacsnw= 'emacs -nw --init-directory ~/.config/emacs'
# alias cat = 'bat'
# alias less = 'bat'

# Simple prompt
if [ -n "$SSH_CONNECTION" ]
then
    export PS1="\u@\h: \w \$ "
else
    export PS1="\w \$ "
fi
export PS2="> "

# Enter directory and list contents
_ls()
{
    gls --color=auto -lhA --group-directories-first
}

cd ()
{
    if [ -n "$1" ]
    then
        builtin cd "$@" && _ls
    else
        builtin cd ~ && _ls
    fi
}

# 提示符设置
autoload -U colors && colors
PROMPT='%F{green}%n@%m %F{blue}%~ %f%# '
