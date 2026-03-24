#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 
# by Stephan Raabe (2023)
# -----------------------------------------------------
# ~/.bashrc
# -----------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# -----------------------------------------------------
# VARIALBES
# -----------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

export EDITOR=nvim
export VISUAL=nvim

export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="/home/josh/.local/bin:$PATH"

export DOCKER_CLI_EXPERIMENTAL=enabled

source "$HOME/.cargo/env"
eval "$(fnm env --use-on-cd --shell bash)"

# Add .NET Core SDK tools
export PATH="$PATH:/home/josh/.dotnet/tools"

if [[ -f "${HOME}/.secrets" ]]; then
    source "${HOME}/.secrets"
fi

# ZVM
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

alias shutdown='systemctl poweroff'
alias wb='~/dotfiles/waybar/launch.sh'
alias dot="cd ~/dotfiles"
alias neo="cd ~/.config/nvim"
alias rusty="cd ${HOME}/dev/test/rust/" # test rust
alias ziggy="cd ${HOME}/dev/test/zig/" # test zig
alias pythony="cd ${HOME}/dev/test/python/" # test python
alias ls='ls --color=auto'
alias grep='grep --color=auto'


# -----------------------------------------------------
# WINDOW MANAGER
# -----------------------------------------------------

alias hl="start-hyprland"
alias st="ENABLE_HDR_WSI=1 DXVK_HDR=1 gamescope --hdr-enabled --prefer-output DP-3 -w 3440 -h 1440 -e -- steam -gamepadui"

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gP="git push"
alias gp="git pull"
alias gco="git checkout"

# -----------------------------------------------------
# SCRIPTS
# -----------------------------------------------------

alias gr='python ~/dotfiles/scripts/growthrate.py'
alias ascii='~/dotfiles/scripts/figlet.sh'

# -----------------------------------------------------
# EDIT CONFIG FILES
# -----------------------------------------------------

alias confb='nvim ~/dotfiles/.bashrc'
alias confm='nvim ~/dotfiles/hypr/conf/monitor.conf'

# -----------------------------------------------------
# EDIT NOTES
# -----------------------------------------------------

alias resume='nvim ~/dev/notes/resume.md'

# -----------------------------------------------------
# SERVER ACCESS
# -----------------------------------------------------

alias server-keepass='TERM=xterm ssh -i ~/.ssh/aws-archy keepass@keepass.holmes-software.com'
alias server-debby='TERM=xterm ssh -i ~/.ssh/id_rsa 192.168.1.69'
alias server-mini='TERM=xterm ssh -i ~/.ssh/azure mini@mini.westus3.cloudapp.azure.com'

# -----------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------

docker-kill() {
    docker rm -f $(docker ps -aq)
}

docker-clean() {
    docker-kill
    docker image rm -f $(docker images -q)
    docker volume rm -f $(docker volume ls -q)
}

echo ""
if [[ $(tty) == *"pts"* ]]; then
    # Import colorscheme from 'wallust' asynchronously
    # &   # Run the process in the background.
    # ( ) # Hide shell job control messages.
    # NOTE: commented out for now because the term theme colors are too close to bg color
    # (cat ~/.cache/wallust/sequences &)

    fastfetch --config ~/.config/fastfetch/bashrc-config.jsonc
else
    echo "Start Hyprland with command hl"
    echo "Start Steam in gamepad mode with command st"
fi
