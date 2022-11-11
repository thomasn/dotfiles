# ~/.bashrc
#
# -- ALL PLATFORMS --
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export EDITOR=vim
export PATH=$PATH:$HOME/bin
# Set WezTerm title
echo -ne "\x1b]0;`hostname`\x1b\\"
# because tmux is life... attach to existing server or start anew
alias e='nvim'
alias xe='nvim'
alias nv='nvim'
tmux attach -t base || tmux new -s base
#
# -- ArchWSL --
# SDF.ORG is running NetBSD with limited tools - bail out here.
echo "OSTYPE is $OSTYPE"
[[ "${OSTYPE}" == "netbsd"]] && return

echo "Not in NetBSD..."
PS1='[\u@\h \W]\$ '
export EDITOR=nvim
# for ArchWSL, ensure sshd is started
SSHDPROC=`ps -ef | grep sshd | grep listener`
[ -z "$SSHDPROC" ] && echo sudo systemctl start sshd
[ -z "$SSHDPROC" ] && sudo systemctl start sshd
# Set for X410.dev X server
[ -z "$DISPLAY"  ] && export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

export RSX_ADDR=10xxx@ch-sxxx.rsync.net

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

