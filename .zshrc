autoload colors
colors
export MANPATH=$MANPATH:/usr/local/texlive/2013/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2013/texmf-dist/doc/info
export PYTHONPATH=/usr/lib/python3.4/site-packages
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export LANG=en_US.UTF-8
export LC_CTYPE=zh_CN.UTF-8
export XDG_CONFIG_DIRS="/etc"
export EDITOR="vim"

# for java app fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export HISTSIZE=100000000
export SAVEHIST=100000000
export HISTFILE=~/.history

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt complete_in_word
setopt extended_glob
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1, -1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)      style="fg=magenta,bold";;
                *'alias for'*)          style="fg=cyan,bold";;
                *'shell builtin'*)      style="fg=yellow,bold";;
                *'shell function'*)     style='fg=green,bold';;
                *"$arg is"*)                            
                    [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="f    g=blue,bold";;
                *)                      style='none,bold';;                  
            esac                                        
            region_highlight+=("$start_pos $end_pos $style")
        fi                                                 
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes'     ]] && colorize=true
        start_pos=$end_pos                                 
    done                                                
}                                                       

cd() {
    builtin cd "$@"
    fc -W
    local HISTDIR="$HOME/.zsh_history$PWD"
    if [ ! -d "$HISTDIR" ]; then
        mkdir -p "$HISTDIR"
    fi
    export HISTFILE="$HISTDIR/zhistory"
    touch $HISTFILE
    local ohistsize=$HISTSIZE
    HISTSIZE=0
    HISTFIZE=$ohistsize
    fc -R
}
mkdir -p $HOME/.zsh_history$PWD
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
function convhistory {
sort $1 | uniq |
sed 's/^.\{20\} *cd/i\\' }
function hist { convhistory $HISTFILE }
# Path to your oh-my-zsh installation.
ZSH=$HOME/.zsh
alias vi='vim'
alias rm='rm -i'
alias cp='cp -i'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source ~/.zsh/oh-my-zsh.sh
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:/usr/local/texlive/2013/bin/x86_64-linux:$PATH
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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
sudo-command-line(){
[[ -z $BUFFER ]] && zle up-history
[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
zle end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line
# for C/C++ include path
C_INCLUDE_PATH=$C_INCLUDE_PATH:/home/frost/workspace/opengl/SB5/Src/GLTools/include:/home/frost/workspace/opengl/SB5/Src/GLTools/include/GL
export C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH:/home/frost/workspace/opengl/SB5/Src/GLTools/include:/home/frost/workspace/opengl/SB5/Src/GLTools/include/GL
export CPLUS_INCLUDE_PATH
