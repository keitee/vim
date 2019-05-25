# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PATH=~/bin:~/vim/bin:~/git/kb/bin:$PATH

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
    # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto -anH'
    #alias fgrep='fgrep --color=auto -anH'
    #alias egrep='egrep --color=auto -anH'
fi

# for gtag
export GTAGSFORCECPP=
#export GTAGSROOT=~/STB_SW
export GTAGSLIBPATH=.:~/STB_SW:

# for tools that use this variable
export EDITOR='gvim'

# some more ls aliases
alias a=alias
alias s='source ~/.bashrc'
alias ll='ls -alFrth'
alias la='ls -A'
alias l='ls -CFh'
alias c=clear
alias h=history

alias cgrep='grep --color'
alias hgrep='cat ~/.persistent_history | grep --color'
# alias hgrep='history | grep --color'

alias vdiff=gvimdiff
alias diff='diff -up'
alias cdiff='colordiff -up'
alias gl='global --color -x'
alias agc='ag -m 1000000 -C 4 -S --color-path="1;31" --color-match="0;32"'
alias ag='ag -m 1000000 -S --color-path="1;31" --color-match="0;32"'
alias agn='ag --no-numbers -m 1000000 -S --color-path="1;31" --color-match="0;32"'
alias agl='ag -m 1000000 -S --color-path="1;31" --color-match="0;32" --pager "less -r"'
alias sl='echo $SHLVL'
alias tn='tmux new -s kit'
alias ta='tmux a'
alias addr2line='/home/kyoupark/STB_SW/FUSIONOS_2/BLD_AMS_BCM_MIPS4K_LNUX_DARWIN_01/platform_cfg/linux/compiler/mips4k_gcc_x86_linux_hound_2/bin/mips-uclibc-addr2line'

# git
alias g=git
alias gc='git commit -am "`date` `hostname`"'

# nfs
# 10.209.62.232:/home/NDS-UK/kyoupark/STB_SW      /home/kyoupark/bld_STB_SW       nfs     rw,sync,hard,intr   0 0
# 10.209.62.232:/home/NDS-UK/kyoupark/si_logs     /home/kyoupark/bld_si_logs      nfs     rw,sync,hard,intr   0 0

# for build
alias blres='Resolve_Deps/scripts/resolve_deps.sh FUSIONOS_2/BLD_AMS_BCM_MIPS4K_LNUX_DARWIN_01'
alias blcd='pushd FUSION_SYSTEM_INTEGRATION/BSKYB_INTEGRATION/build/'
alias blmw='./build_mw_epg.sh -p "ams-drx890" --project "picasso"  --profile "Sky_Trials" --variant "debug" --mw_only'
alias bllt="git tag -l '*BLD_83*"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# set editing-mode vi


# enable dir expansion
shopt -s direxpand

alias sh2='ssh uk2'
alias shb='ssh castor-03'
alias shy='ssh yard'
alias sho='ssh -X 10.209.60.101'
alias mmo='sudo mount -o nfsvers=4 10.209.60.101:/home/kyoupark/ /mnt/'
alias umo='sudo umount /mnt/'
alias tpi='telnet 10.209.60.87'
alias tpi2='telnet 10.209.60.149'

# humax and com serial
#alias hlog="sudo grabserial -v -d /dev/ttyS0 | tee 2>&1 ~/logs/`date | awk '{print "log-com-"$1"-"$2"-"$3"-"$4}'`"
#alias hcom='sudo grabserial -v -d /dev/ttyS0'
#alias hcpt='scp libnexusMgr.so root@172.20.35.27:/usr/local/lib'
#alias hcpf='scp root@172.20.35.27:'
#alias hbld='ZB_CFG="humax.1000" zb-make Polonium/Polonium.NexusInspect'
#alias hscr='sudo screen -a -D -R -fn -l -L /dev/ttyS0 115200,cs8'
#alias hscr='sudo minicom -C=hmax.log -c on hmax'

# only for linux hosts but not vm on windows host
alias xmap="xmodmap ~/.xmodmap"
xmodmap ~/.xmodmap

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

# Keeping persistent history in bash
# https://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
# https://eli.thegreenplace.net/2016/persistent-history-in-bash-redux/
log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"


#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"


# This PS1 snippet was adopted from code for MAC/BSD I saw from:
# http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better
#
# Let me explain how it works
#
# This is the current time, with seconds. This is controlled by the variable:
# $Time12h and the color is set just before it as $IBlack
#
# This is the current directory, with home folder abr. In this case the color
# and look is controlled near the end of the snippet by the section with
# $Yellow$PathShort 
#
# Ok, this is controlled by the $Color_Off variables littered throughout.  
#
# Ok, this is the fun! Green parenthesis means you're on an unchanged branch.  
#    
# Red Curly Brackets means something's changed! You have a dirty branch. Either
# finish & commit or cleanup. ;-) 

# export PS1=$IBlack$Time12h$Color_Off'$(git branch &>/dev/null;\
# if [ $? -eq 0 ]; then \
#   echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
#   if [ "$?" -eq "0" ]; then \
#     # @4 - Clean repository - nothing to commit
#     echo "'$Green'"$(__git_ps1 " (%s)"); \
#   else \
#     # @5 - Changes to working tree
#     echo "'$IRed'"$(__git_ps1 " {%s}"); \
#   fi) '$BYellow$PathShort$Color_Off'\$ "; \
# else \
#   # @2 - Prompt when not in GIT repo
#   echo " '$Yellow$PathShort$Color_Off'\$ "; \
# fi)'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
