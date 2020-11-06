# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
#force_color_prompt=yes

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

alias ssh_linux="ssh -X pooni@10.113.111.32"

alias ssh_local="ssh -X pt.gaurav@10.113.161.123" #inactive

alias ssh_cog="ssh -X pooni@10.113.158.35"

alias ssh_M40="ssh -X pooni@10.113.161.121" #inactive

alias ssh_K40="ssh -X pooni@10.113.161.123" #inactive

alias ssh_dgx="ssh -X pooni@10.113.161.56"

alias ssh_pk="ssh -X pooni@10.113.176.160" #inactive

alias ssh_dmc="ssh -X pt.gaurav@10.113.242.105"

alias ssh_sr_jinsu="ssh js.yeo@75.17.101.11" #1qaz2wsx!

alias ssh_sr="ssh -Y pt.gaurav@75.17.101.11"
# alias scp_sr="scp pt.gaurav@75.17.101.11:~/workspace/Ext_SSD.TensorFlow_to_RefineDet/run_efficientnetb3/effb3_res.png Downloads/scp/"
alias scp_sr="scp -r pt.gaurav@75.17.101.11:/dbstore/sr_odl/datasets/VOC/VOC2012_seg/init_models/deeplabv3* ."
# alias scp_sr="scp Downloads/mobilenet_sgd_68.848.pth.tar pt.gaurav@75.17.101.11:~/workspace/Quantization/dfq2/modeling/classification/ "

# alias ssh_mlp="ssh -p 30008 -t pt.gaurav@75.17.101.5"
alias ssh_mlp="ssh -Y pt.gaurav@75.17.101.11 ssh -p 30008 -t pt.gaurav@75.17.101.5"
alias ssh_mlplogin="ssh -p 30008 -t pt.gaurav@75.17.101.5"

# export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
# export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# export ANDROID_NDK_ROOT=~/Android/Sdk/ndk-bundle
# export SNPE_ROOT=~/projects/android/snapdragon-snpe-sdk/snpe-1.2.2
# export CAFFEDIR=~/caffe/
# export CAFFE_DIR=~/caffe/
# export TENSORFLOWDIR=~/tensorflow/
# export TENSORFLOW_DIR=~/tensorflow/
# export TENSORFLOW_HOME=~/tensorflow
# source ~/projects/android/snapdragon-snpe-sdk/snpe-1.2.2/bin/envsetup.sh -c ~/caffe
# source ~/projects/android/snapdragon-snpe-sdk/snpe-1.2.2/bin/envsetup.sh -t ~/tensorflow

# Setup snpe for PMP model testing
export ANDROID_NDK_ROOT=~/Workspace/snpe/snpe-1.37.0.788/android-ndk-r21d/


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pooni/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pooni/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pooni/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pooni/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

