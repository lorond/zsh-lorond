# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

# Modified PS1:
#  * dashes removed - cause mess on terminal resize
#  * blank line as delimiter - instead of dashes
#  * prompt moved to a new line - not alligned by pwd anymore
#  * space between pwd and vsc status

# settings
typeset +H return_code=""
typeset +H my_gray="$FG[237]"
typeset +H my_orange="$FG[214]"

# show the return code only on the first prompt after a command actually ran
typeset -g _af_cmd_ran=0
af_rc_preexec() { _af_cmd_ran=1 }
af_rc_precmd() {
  local code=$?   # preserve real $? for any later precmd hooks
  (( _af_cmd_ran && code )) && return_code="%F{red} ↵ $code%f"$'\n' || return_code=''
  _af_cmd_ran=0
  return $code
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec af_rc_preexec
add-zsh-hook precmd  af_rc_precmd

# primary prompt
PS1='${return_code}
$my_gray%n@%m%{$reset_color%} $FG[032]%~ $(git_prompt_info)$(hg_prompt_info)
$FG[105]%(!.#.»)%{$reset_color%} '
PS2='%{$fg[red]%}\ %{$reset_color%}'
RPS1=''

# right prompt
(( $+functions[virtualenv_prompt_info] )) && RPS1+='$(virtualenv_prompt_info)'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" $FG[075]["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
