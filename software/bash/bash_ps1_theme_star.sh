### Command Prompt settings
# Requires Nerd Fonts to support icons, https://www.nerdfonts.com/
# Please refer to docs for font settings with TERM tools.

function _ps1_prompt_hook() {
  local LAST_STATUS=$?
  local COLOR_RESET='\[\e[m\]'
  local COLOR_LIGHT_GRAY='\[\e[30;1m\]'
  local COLOR_RED='\[\e[31m\]'
  local COLOR_GREEN='\[\e[32m\]'
  local COLOR_LIGHT_BROWN='\[\e[33;1m\]'
  local COLOR_LIGHT_CRAN='\[\e[36;1m\]'
  local COLOR_ON_GREEN='\[\e[42m\]'
  local OS_PROMPT=""
  local PWD_TRUNCATE="$(echo ${PWD/#${HOME}/\~} | awk '{ if (length($0) > 60) print "➥ " substr($0, length($0)-58); else print $0 }')"

  local left=${COLOR_GREEN}${COLOR_RESET}${COLOR_ON_GREEN}"${OS_PROMPT} ${PWD_TRUNCATE}"${COLOR_RESET}${COLOR_GREEN}${COLOR_RESET}
  local __PS1_COMPENSATION=0

  if [ ${LAST_STATUS} = 0 ]; then
    PS1="💚"
  else
    PS1="${COLOR_RED}(${LAST_STATUS})${COLOR_RESET}💥"
    __PS1_COMPENSATION=$(($(expr length ${LAST_STATUS}) + 2))
  fi
  PS1="$PS1 ${COLOR_LIGHT_GRAY}\D{%Y(%Ww) %m/%d}-\t${COLOR_RESET}"
  # The reason why we need compensation is the escape codes from ANSI and PS1, like colors and special variables.
  # The string will be varying while render in the final, which will impact the rendering position.
  __PS1_COMPENSATION=$((${#PS1} - ${__PS1_COMPENSATION} - $(expr length "$left") + 30))
  PS1=$(tput sc)$(printf "%*s" $(($(tput cols) + ${__PS1_COMPENSATION})) "$PS1")$(tput rc)
  PS1='\n'${left}$PS1
  PS1=$PS1'\n\$ '
  PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
}

[[ "${PROMPT_COMMAND}" == *"_ps1_prompt_hook"* ]] || {
  [[ -n ${PROMPT_COMMAND} ]] && PROMPT_COMMAND="_ps1_prompt_hook;${PROMPT_COMMAND}" || PROMPT_COMMAND="_ps1_prompt_hook"
}
