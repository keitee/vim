# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=~/kit-bin:~/source/setup-humax:~/source/zinc-git-tools:$PATH
export ET=~/source/DEVARCH

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTFILE=~/.bash_history_$(echo $SSH_TTY | cut -f 4 -d'/')
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=erasedups
HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto -anH'
    #alias fgrep='fgrep --color=auto -anH'
    #alias egrep='egrep --color=auto -anH'
fi

# for gtag
export GTAGSFORCECPP=
export GTAGSLIBPATH=.:~/source:/home/kpark/gtags/toolchain:/home/kpark/gtags/master-oss:/home/kpark/gtags/cpp-pc

# for skype
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM='/usr/bin/ibus-daemon -x -d'

# some more ls aliases
alias a=alias
alias s='source ~/.bashrc'
alias grep='grep --color -anH'
alias fgrep='fgrep --color -anH'
alias egrep='egrep -anH --color'
alias gdiff=gvimdiff
alias diff='diff -up'
alias cdiff='colordiff -up'
alias gl='global --color -x'
alias ag='ag -C 4 -S --color-path="1;31" --color-match="0;32" --pager "less -r"'
alias gu='gtags ~/source ~/source/DEVARCH'
alias sl='echo $SHLVL'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# set editing-mode vi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c=clear
alias h=history

# enable dir expansion
shopt -s direxpand

# humax and com serial
alias hssh='ssh root@172.20.35.27' 
alias hlog="sudo grabserial -v -d /dev/ttyS0 | tee 2>&1 ~/logs/`date | awk '{print "log-com-"$1"-"$2"-"$3"-"$4}'`"
alias hcom='sudo grabserial -v -d /dev/ttyS0'
alias hcpt='scp libnexusMgr.so root@172.20.35.27:/usr/local/lib'
alias hcpf='scp root@172.20.35.27:'
alias hbld='ZB_CFG="humax.1000" zb-make Polonium/Polonium.NexusInspect'
#alias hscr='sudo screen -a -D -R -fn -l -L /dev/ttyS0 115200,cs8'
alias hscr='sudo minicom -C=hmax.log -c on hmax'

# huawei and usb serial
alias wssh='ssh root@172.20.33.192' 
alias wlog="sudo grabserial -v -d /dev/ttyUSB0 | tee 2>&1 ~/logs/`date | awk '{print "log-usb-"$1"-"$2"-"$3"-"$4}'`"
alias wcom='sudo grabserial -v -d /dev/ttyUSB0' 
alias wcpt='scp libnexusMgr.so root@172.20.33.192:/usr/local/lib'
alias wcpf='scp root@172.20.33.192:'
alias wscr='sudo screen -a -D -R -fn -l -L /dev/ttyUSB0 115200,cs8'
alias wtag='export GTAGSLIBPATH=~/gtags/oem-hwei:$GTAGSLIBPATH'

alias wsk='zinc-send-key-hwei'

#alias chi='sudo screen -a -D -R -fn -l -L /dev/ttyUSB0 115200'
alias btag='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
