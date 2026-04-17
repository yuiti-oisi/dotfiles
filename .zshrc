echo "Hi $USERNAME!\nThis is XPS14(Ubuntu 24.04.3 LTS)."
echo 
echo 
echo "########## TODO ##########"
echo 
cat  ~/todo.txt
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-completions	
	)

source $ZSH/oh-my-zsh.sh


# zsh-completionsのPATH
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

  autoload -Uz compinit
  compinit
fi


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=ja_JP.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias python="python3"
alias ls="eza --icons=always --time-style '+<%Y-%m-%d %H:%M:%S>'"
alias la="ls -a"
alias lsa="la -a"
alias lsla="la -la"
alias xuu="sudo sync ; sudo shutdown -h now" # 今後addr予定
alias tree="eza --icons=always -T -L"
alias lsort="ls -l -r --total-size  -s size" # 今後addr予定
alias dnsrestart="sudo systemctl restart systemd-resolved" # 今後addr予定
alias android-studio-linux="sh /home/u3sound/Downloads/android-studio-2025.2.1.7-linux/android-studio/bin/studio.sh" # 今後addr予定
alias win-restart='sudo grub-reboot "Windows Boot Manager (on /dev/nvme0n1p1)" ; sudo reboot'

# JAVA 環境変数, PATH設定
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

# Homeberw用の環境変数設定
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# typo時に確認してくれる
setopt correct

# Google search by chrome
# --- Google 検索コマンド: `google <query>` -------------------------------
# 依存: Google Chrome(google-chrome または google-chrome-stable) / もしくは xdg-open
# 使い方: google "zsh プロンプト 設定"
google() {
  if [[ $# -eq 0 ]]; then
    print -u2 "Usage: google <query>"
    return 1
  fi

  # 利用可能な Chrome 実行ファイルを検出
  local chrome=""
  for c in google-chrome google-chrome-stable chromium chromium-browser; do
    if command -v "$c" >/dev/null 2>&1; then
      chrome="$c"
      break
    fi
  done

  # クエリを URL エンコード（Python を用いて確実に実施）
  # ※「計算系はPythonを使う」方針に合わせています
  local encoded
  encoded="$(
    python3 - "$@" <<'PY'
import sys, urllib.parse
print(urllib.parse.quote(' '.join(sys.argv[1:])))
PY
  )"

  local url="https://www.google.com/search?q=${encoded}"

  # Chrome があれば新しいタブで、無ければ xdg-open にフォールバック
  if [[ -n "$chrome" ]]; then
    nohup "$chrome" --new-tab "$url" >/dev/null 2>&1 & disown
  elif command -v xdg-open >/dev/null 2>&1; then
    nohup xdg-open "$url" >/dev/null 2>&1 & disown
  else
    print -u2 "Chrome も xdg-open も見つかりません。Chrome をインストールしてください。"
    return 127
  fi
}


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/u3sound/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
