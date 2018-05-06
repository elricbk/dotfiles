export PS1='\u:\w\$ '

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

for file in ~/.{exports,aliases,functions,mappings,bashrc_local}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
