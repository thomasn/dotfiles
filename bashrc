# ~/.bashrc
#
# -- ALL PLATFORMS --
# If not running interactively, do not proceed
[[ $- != *i* ]] && return

export EDITOR=vim
alias e='vim'
export PATH=$PATH:$HOME/bin
# Set WezTerm title
echo -ne "\x1b]0;${USER}\@${HOSTNAME}\x1b\\"

# because tmux is life... attach to existing server or start anew
if [[ -v TMUX ]] 
then
  echo "TMUX set - to attach to session use tmux attach -t base"
else
  echo "No TMUX found, starting new session"
  tmux new -s base
fi

# SDF.ORG is running NetBSD with limited tools - bail out here.
# echo "OSTYPE is $OSTYPE"
[[ "${OSTYPE}" == "netbsd" ]] && return

# echo "Not in NetBSD..."
# -- ArchWSL --
PS1='[\u@\h \W]\$ '
export EDITOR=nvim
alias ls='ls --color=auto'
alias e='nvim'
alias xe='nvim'
alias nv='nvim'
# for ArchWSL, ensure sshd is started
SSHDPROC=`ps -ef | grep sshd | grep listener`
[ -z "$SSHDPROC" ] && echo sudo systemctl start sshd
[ -z "$SSHDPROC" ] && sudo systemctl start sshd
# Set for X410.dev X server
[ -z "$DISPLAY"  ] && export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

export RSX_ADDR=10xxx@ch-sxxx.rsync.net

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

