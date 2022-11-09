## Invoke starship
eval "$(starship init zsh)"

## Loader for WSL to talk to local GPG
#
# https://github.com/BlackReloaded/wsl2-ssh-pageant
#
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
  rm -f "$SSH_AUTH_SOCK"
  wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
  if test -x "$wsl2_ssh_pageant_bin"; then
    (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
  else
    echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
  fi
  unset wsl2_ssh_pageant_bin
fi

## History
HISTFILE=~/.zsh_histfile
HISTSIZE=9999
SAVEHIST=9999
setopt appendhistory

# Misc alias
# install exa from apt
alias ls="exa --icons --group-directories-first"
alias ll="exa --icons --group-directories-first -l -g"
alias grep='grep --color'
alias d='docker'

# Kubectl alias and Functions/autocomplete etc.
#
# kubecm : https://github.com/sunny0826/kubecm
# kubectx : https://github.com/ahmetb/kubectx
#
alias k="kubectl"
alias h="helm"
# alias kn="kubens"
alias kx="kubectx"
alias kc="kubecm"
alias kn="kubecm namespace"

ku() {
    kubectl config unset current-context
}

source <(kubectl completion zsh)

# Setup for Vagrant/Virtualbox
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"


# find out which distribution we are running on
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# set an icon based on the distro
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DISTRO="$ICON "
