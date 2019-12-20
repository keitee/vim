# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PATH=~/works/bitbake-1.40/bin:~/Downloads/clang+llvm-9.0.0-x86_64-linux-gnu-ubuntu-18.04/bin:~/bin:~/vim/bin:~/git/kb/bin:~/.cargo/bin:~/Downloads/git-repo:$PATH

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


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
export GTAGSLIBPATH=.:~/mw:

# for tools that use this variable
export EDITOR='gvim'


#={===========================================================================
# pager
# 
# https://leanpub.com/the-tao-of-tmux/read#leanpub-auto-example-powerline
# Read the tmux manual in style
# 
# most(1), a solid PAGER, drastically improves readability of manual pages by
# acting as a syntax highlighter.
# 
# sudo apt install most
# 
# To get this working, you need to set your PAGER environmental variable to point
# to the MOST binary. You can test it like this:
# 
# $ PAGER=most man ls
# 
# If you found you like most, you’ll probably want to make it your default manpage
# reader. You can do this by setting an environmental variable in your “rc” (Run
# Commands) for your shell. The location of the file depends on your shell. You
# can use $ echo $SHELL to find it on most shells). In Bash and zsh, these are
# kept in ~/.bashrc or ~/.zshrc, respectively:
# 
# export PAGER="most"
# 
# I often reuse my configurations across machines, and some of them may not have
# most installed, so I will have my scripting only set PAGER if most is found:
# 
# #!/bin/sh
# 
# if command -v most > /dev/null 2>&1; then
#     export PAGER="most"
# fi

if command -v most > /dev/null 2>&1; then
  export PAGER="most"
fi


#={===========================================================================
# fzf
#
# Environment variables
#
# FZF_DEFAULT_COMMAND
# Default command to use when input is tty
# e.g. export FZF_DEFAULT_COMMAND='fd --type f'
#
# In fact, "export FZF_DEFAULT_COMMAND=" makes fzf uses the default command in
# the code which uses `find` command
#
# FZF_DEFAULT_OPTS
# Default options
# e.g. export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"
#
# To use fzf in Vim like `Files` but limits to files in flist.out
# alias fmw="export FZF_DEFAULT_COMMAND='cat /home/keitee/mw/flist.out'"
# alias fcu="export FZF_DEFAULT_COMMAND='cat ./flist.out'"

# when use `fd`
# export FZF_DEFAULT_COMMAND='fd --type f'
#
# If you want the command to follow symbolic links, and don't want it to exclude
# hidden files, use the following command:
#
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'


# FILE TYPES
#
# It is possible to restrict the types of files searched. For example, passing
# --html will search only files with the extensions htm, html, shtml or xhtml.
# For a list of supported types, run ag --list-file-types.
#
#  --cc
#      .c  .h  .xs
#  --cpp
#      .cpp  .cc  .C  .cxx  .m  .hpp  .hh  .h  .H  .hxx  .tpp
#
# --depth NUM: Search up to NUM directories deep, -1 for unlimited. Default is
# 25.

# export FZF_DEFAULT_COMMAND="ag --depth -1 --nocolor --nogroup -g ''"

export FZF_DEFAULT_COMMAND="ag --depth -1 --cc --cpp --nocolor --nogroup -g ''"

# export FZF_DEFAULT_OPTS="-m --layout=reverse --inline-info"
export FZF_DEFAULT_OPTS="-m --inline-info"

# However, completion for bash do not seem to use above env settings.
#
# Fuzzy completion for bash and zsh
# Files and directories
#
# Fuzzy completion for files and directories can be triggered if the word before
# the cursor ends with the trigger sequence which is by default **.
# 
# COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB>
# 
# Supported commands
# 
# On bash, fuzzy completion is enabled only for a predefined set of commands
# (complete | grep _fzf to see the list). But you can enable it for other
# commands as well by using _fzf_setup_completion helper function.
# 
# # usage: _fzf_setup_completion path|dir COMMANDS...
# _fzf_setup_completion path ag git kubectl
# _fzf_setup_completion dir tree


# Using the finder
#
# CTRL-J / CTRL-K (or CTRL-N / CTRL-P) to move cursor up and down
#
# Enter key to select the item, CTRL-C / CTRL-G / ESC to exit
#
# On multi-select mode (-m), TAB and Shift-TAB to mark multiple items


# Key bindings for command-line
#
# The install script will setup the following key bindings for bash, zsh, 
# and fish.
# 
# CTRL-T - Paste the selected files and directories onto the command-line
#
# Set FZF_CTRL_T_COMMAND to override the default command
# Set FZF_CTRL_T_OPTS to pass additional options
#
# CTRL-R - Paste the selected command from history onto the command-line
#
# If you want to see the commands in chronological order, press CTRL-R again
# which toggles sorting by relevance
#
# Set FZF_CTRL_R_OPTS to pass additional options
#
# export FZF_CTRL_C_COMMAND='cat ~/.`hostname`_persistent_history'

# ALT-C - cd into the selected directory
# Set FZF_ALT_C_COMMAND to override the default command
# Set FZF_ALT_C_OPTS to pass additional options
#
# If you're on a tmux session, you can start fzf in a split pane by setting
# FZF_TMUX to 1, and change the height of the pane with FZF_TMUX_HEIGHT (e.g.
# 20, 50%).
# 
# If you use vi mode on bash, you need to add set -o vi before source
# ~/.fzf.bash in your .bashrc, so that it correctly sets up key bindings for vi
# mode.
# 
# More tips can be found on the wiki page.


# note: 
# To apply the command to CTRL-T as well
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# 
# However, use the default since CTRL-T do not respect .agignore. So can use
# ignore feature in vim but see all files in command line.


#={===========================================================================
# vim
# http://vimdoc.sourceforge.net/htmldoc/remote.html
# alias gv="gvim --remote-silent"
alias gv="gvim --remote-tab-silent"
alias gs="gvim --servername "


#={===========================================================================
# clang
# clang-format -i -style=file bleaudioreader.cpp
alias cf="clang-format -i -style=file"


#={===========================================================================
# alias
alias a=alias
alias th='tmuxinator start home'
alias ta='tmuxinator start airplay'
alias tb='tmuxinator start blue-titan'
alias ta='tmux a'
alias s='source ~/.bashrc'
alias ll='ls -alFrth'
alias la='ls -A'
alias l='ls -CFh'
alias c=clear
alias h=history

alias cgrep='grep --color'

alias vdiff=gvimdiff
alias diff='diff -up'
alias cdiff='colordiff -up'
alias gl='global --color -x'

#={===========================================================================
# alias-ag
#
# -m --max-count NUM: Skip the rest of a file after NUM matches. Default is 0,
# which never skips.
#
# -S --smart-case: Match case-sensitively if there are any uppercase letters in
# PATTERN, case-insensitively otherwise. Enabled by default.
#
# -C --context [LINES]: Print lines before and after matches. Default is 2.
#
# --color-match: Color codes for result match numbers. Default is 30;43.
#
# --color-path: Color codes for path names. Default is 1;32.

alias agc='ag -m 1000000 -C 4 -S --color-path="1;31" --color-match="0;32"'
alias ag='ag -m 1000000 -S --color-path="1;31" --color-match="0;32"'
alias agn='ag --no-numbers -m 1000000 -S --color-path="1;31" --color-match="0;32"'
alias agl='ag -m 1000000 -S --color-path="1;31" --color-match="0;32" --pager "less -r"'

alias sl='echo $SHLVL'
alias addr2line='/home/kyoupark/STB_SW/FUSIONOS_2/BLD_AMS_BCM_MIPS4K_LNUX_DARWIN_01/platform_cfg/linux/compiler/mips4k_gcc_x86_linux_hound_2/bin/mips-uclibc-addr2line'

# git
alias g=git
alias gc='git commit -am "`date` `hostname`"'

# nfs
# 10.209.62.232:/home/NDS-UK/kyoupark/STB_SW      /home/kyoupark/bld_STB_SW       nfs     rw,sync,hard,intr   0 0
# 10.209.62.232:/home/NDS-UK/kyoupark/si_logs     /home/kyoupark/bld_si_logs      nfs     rw,sync,hard,intr   0 0

# for build
alias bllt="git tag -l '*BLD_83*"
alias con='sudo screen -S name -a -D -R -fn -l -L /dev/ttyUSB0 115200,cs8'


#={===========================================================================
# readline 
# To set binding to up/down key to history search:
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


# enable dir expansion
shopt -s direxpand

alias sh2='ssh uk2'
alias sho='ssh -X 10.209.60.101'
alias mmo='sudo mount -o nfsvers=4 10.209.60.101:/home/kyoupark/ /mnt/'
alias umo='sudo umount /mnt/'

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


#={===========================================================================
# bash-completion
#
# https://www.linuxjournal.com/content/more-using-bash-complete-command
#
# For more complex cases where you need more control over how things are
# completed you can tell bash to call a function for doing the completion work.
# This is a function that you supply, that you would probably source from your
# .profile file. The function name is then supplied as an argument to the -F
# option of complete:
#
# function _mycomplete_()
# {
#     local cmd="${1##*/}"
#     local word=${COMP_WORDS[COMP_CWORD]}
#     local line=${COMP_LINE}
#     local xpat='!*.foo'
# 
#     COMPREPLY=($(compgen -f -X "$xpat" -- "${word}"))
# }
# 
# complete -F _mycomplete_ myfoo

# In the first three lines of the function body we create some useful local
# variables, here mainly for showing what's available since most of them aren't
# used in the function. 

# The first, cmd, gets the command that's being executed, this can be used if
# your completion function can handle multiple commands. 

# The second, word, gets the word that is being completed, this can be used if
# your completion strategy changes based on the word that's being expanded, it's
# also needed so that only matching values are returned. 

# The third, line, gets the entire command line that is being completed. 

# The fourth variable, xpat, is our exclusion pattern, the same one used in the
# simple example above. Check the bash man page for other useful COMP_*
# variables.

# The only real code in the function is the last line that sets the variable
# COMPREPLY, which is our reply to bash's request to expand something. This line
# uses compgen to generate the expansion. The compgen command accepts most of
# the same options that complete does but it generates results rather than just
# storing the rules for future use. Here we tell compgen to create a list of
# files with -f. Then we tell it to exclude all the files that match our
# exclusion pattern with -X "$xpat". And finally, we pass in the word being
# completed so that only items that match it are returned.

# How do I get bash completion for command aliases?
# https://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases
#
# Wraps a completion function
# make-completion-wrapper <actual completion function> <name of new func.>
#                         <command name> <list supplied arguments>
# eg.
# 	alias agi='apt-get install'
# 	make-completion-wrapper _apt_get _apt_get_install apt-get install
# defines a function called _apt_get_install (that's $2) that will complete
# the 'agi' alias. (complete -F _apt_get_install agi)

function make-completion-wrapper () 
{
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2

  local function="
    function $function_name 
    {
    ((COMP_CWORD+=$arg_count))
    COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
    "$comp_function_name"
    return 0
  }"

  eval "$function"
  echo $function_name
  echo "$function"
}


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


#={===========================================================================
# Keeping persistent history in bash
# https://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
# https://eli.thegreenplace.net/2016/persistent-history-in-bash-redux/
#
# There are many approaches to improve the situation; here I want to discuss one
# I've been using very successfully in the past few months - a simple
# "persistent history" that keeps track of history across terminal instances,
# saving it into a dot-file in my home directory (~/.persistent_history). All
# commands, from all terminal instances, are saved there, forever. I found this
# tremendously useful in my work - it saves me time almost every day.
#
# o Note that an environment variable is used to avoid useless duplication (i.e.
# if I run ls twenty times in a row, it will only be recorded once).
#
# o being kept in a Git repository for safekeeping,
#
# But trimming is easy:
#
# tail -20000 ~/.persistent_history | tee ~/.persistent_history
# 
# 'PROMPT_COMMAND'
#      If set, the value is interpreted as a command to execute before the
#      printing of each primary prompt ('$PS1').

log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.`hostname`_persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"

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

# alias hgrep='cat ~/.`hostname`_persistent_history | grep --color'
alias hgrep='cat ~/.`hostname`_persistent_history | fzf'
alias hlist='less -N +G ~/.`hostname`_persistent_history'


#={===========================================================================
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
