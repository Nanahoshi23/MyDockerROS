export LANG=ja_JP.UTF-8

bindkey -v

# Prompt
autoload -Uz colors
colors

function zle-line-init zle-keymap-select {
case $KEYMAP in
    vicmd)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%{$fg[red]%}%n@%m:%{$reset_color%}%{$fg[cyan]%}NOR%{$reset_color%}%{$fg[red]%}]%{$reset_color%} "
        ;;
    main|viins)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%{$fg[red]%}%n@%m:%{$reset_color%}%{$fg[green]%}INS%{$reset_color%}%{$fg[red]%}]%{$reset_color%} "
        ;;
esac
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
RPROMPT="[ %~ ]"

bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank





# LS
autoload -Uz compinit && compinit -u
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' menu select=2
setopt menu_complete

zmodload zsh/complist
bindkey -v '^a' beginning-of-line
bindkey -v '^b' backward-char
bindkey -v '^e' end-of-line
bindkey -v '^f' forward-char
bindkey -v '^h' backward-delete-char
bindkey -v '^i' expand-or-complete
bindkey -M menuselect '^g' .send-break
bindkey -M menuselect '^i' forward-char
bindkey -M menuselect '^j' .accept-line
bindkey -M menuselect '^k' accept-and-infer-next-history
bindkey -M menuselect '^n' down-line-or-history
bindkey -M menuselect '^p' up-line-or-history
bindkey -M menuselect '^r' history-incremental-search-forward

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt append_history
setopt extended_history
setopt hist_verify
setopt hist_ignore_space
#setopt inc_append_history

setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst


setopt complete_in_word
setopt always_last_prompt

setopt print_eight_bit
setopt extended_glob
setopt globdots

setopt list_packed


setopt correct
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# cdr------------------------------------------------------------------------------------
# cdr, add-zsh-hook を有効にする
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# cdr の設定
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#ROS--------------------------------------------------------------------------------------
source /opt/ros/kinetic/setup.zsh
source ${HOME}/catkin_ws/devel/setup.zsh


