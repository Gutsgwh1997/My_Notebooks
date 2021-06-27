# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gwh/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/gwh/.fzf/bin"
fi

# Key bindings
# export FZF_DEFAULT_OPTS='--bind tab:toggle+down,btab:toggle+up,change:toggle+down --bind ctrl-k:down,ctrl-i:up'
export FZF_DEFAULT_OPTS='--cycle --border'
export FZF_DEFAULT_COMMAND='fd'
export FZF_COMPLETION_TRIGGER='\'
# export FZF_TMUX=1
# export FZF_TMUX_HEIGHT='80%'
# export fzf_preview_cmd='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-neovim} "${files[@]}"
}

fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
				  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gwh/.fzf/shell/completion.zsh" 2> /dev/null
# ------------
source "/home/gwh/.fzf/shell/key-bindings.zsh"
# source ~/.fzf/shell/zsh-interactive-cd.plugin.zsh
