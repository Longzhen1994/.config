# ~/.config/zsh/.zprofile - Environment for login shells

# macOS 默认终端为登录 shell，适合在此设置环境变量。

# 初始化 Homebrew（添加 Homebrew bin 目录和变量到 PATH）
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH 扩展（在 Homebrew 初始化后进行）
# 现在包含 Cargo 和其他工具的路径
export PATH="$CARGO_HOME/bin:$PATH"

# gnu 工具 替代 BSD
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"


# Conda 初始化
# 将路径修改为符合 XDG 规范的位置 (要放在 .zshrc 里面, 不然 emacs 的 vterm 打不开)
__conda_setup="$('$XDG_DATA_HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$XDG_DATA_HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$XDG_DATA_HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$XDG_DATA_HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$XDG_DATA_HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "$XDG_DATA_HOME/miniforge3/etc/profile.d/mamba.sh"
fi
