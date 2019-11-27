# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/gwh/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

#PROMPT="
#%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
#    %(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
#    %{$fg[white]%}in \
#    %{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
#    ${hg_info}\
#    ${git_info}\
#     \
#     %{$fg[white]%}[%*] $exit_code
#%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting extract z sudo web-search)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



#开启tmux
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
    fi


#添加环境变量
#anaconda----------------------------------------
#export PATH="/home/gwh/anaconda3/bin:$PATH"
export PATH="$PATH:/home/gwh/anaconda3/bin"
#ros---------------------------------------------
source /opt/ros/kinetic/setup.zsh
#source ~/catkin_mn/devel/setup.zsh
source ~/catkin_vins/devel/setup.zsh
source ~/catkin_ws/devel/setup.zsh
source ~/MYNT-EYE-D-SDK/wrappers/ros/devel/setup.zsh
#ORB_SLAM2
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:PATH/semantic_slam/ORB_SLAM2/Examples/ROS
#ridgeback,远程部署ros
export ROS_HOSTNAME=gwh-Aspire-T5000
#export ROS_MASTER_URI=http://192.168.1.102:11311 # Your robot’s hostname
#export ROS_IP=192.168.1.112                      # Your computer ’s wireless IP address
#export Ros_HOSTNAME=192.168.1.112


#便捷指令----------------------------------------
alias py36="source activate python36"
alias godie="conda deactivate"

#终端配置polipo代理上网---------------------------
alias hp="export http_proxy=http://localhost:8123"
alias unset_hp="unset http_proxy"
#使终端一直处于代理模式
#export http_proxy=http://localhost:8123
