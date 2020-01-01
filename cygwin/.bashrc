# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# Set Prompt
PS1="\[\e[30;1m\][$SHLVL][\D{%y/%m/%d}@\A](\D{%W}w)\[\e[0;1,\]\n\`if [ \$? = 0 ]; then echo \[\e[32m\]O\[\e[0m\]; else echo \[\e[31m\]X\[\e[0m\]; fi\`\[\[\e[30;1m\](\#/\!)\[\e[0;1m\][\[\e[36;1m\]\u\[\e[0m\]@\[\e[33;1m\]\h\[\e[0m\] \[\e[31;1m\]\W\[\e[0m\]]\\$ "
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# History Options
# Hisotory file settings
export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls*:rm -rf*' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007" && history -a'

# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

ulimit -n 3200
