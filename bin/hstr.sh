# based on  https://github.com/pindexis/hstr 

# default key bindings
complete_shortcut="${hstr_complete_SHORTCUT:-\C-r}"

if [[ -n "$BASH" ]]; then

    function hstr_complete {
        offset=${READLINE_POINT}
        READLINE_POINT=0

        tmp_file=$(mktemp -t hstr.XXXXXXX)
        </dev/tty hstr ${READLINE_LINE:0:offset} 2>$tmp_file
        READLINE_LINE=$(<$tmp_file)
        rm -f $tmp_file

	READLINE_POINT=${#READLINE}
     }

     export HH_CONFIG=hicolor         # get more colors
     shopt -s histappend              # append new history items to .bash_history
     export HISTCONTROL=ignorespace   # leading space hides commands from history
     export HISTFILESIZE=10000        # increase history file size (default is 500)
     export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
     export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync


     bind -x '"'"$complete_shortcut"'":"hstr_complete"';
fi
