########################################
# env parameters
export LANG=ja_JP.UTF-8


# enable to use colors.
autoload -Uz colors
colors

# key bind like emacs
# bindkey -e

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HISTTIMEFORMAT='%Y-%m-%d %T%z '
setopt extended_history

# PROMPT view settings
# two lines view
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "
RPROMPT='[%F{green}%d%f]'

# color alias for remote with tmux
alias ssh='TERM=xterm ssh'

# split character settingz.
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# auto-complete
fpath=(~/.zsh_repo/completion $fpath)

autoload -Uz compinit
compinit -u

# ignore higher/lower character.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# do not complete after "../".
zstyle ':completion:*' ignore-parents parent pwd ..

# auto-complete after sudo command.
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# auto-complete ps command.
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# Optional
# Enable to view japanese (8bit char-set).
setopt print_eight_bit

# disable beep.
setopt no_beep

# disable flow controll.
setopt no_flow_control

# do not exit with "Ctrl+D".
setopt ignore_eof

# behave after '#' as comments.
setopt interactive_comments

# enable "cd" command if directory input.
setopt auto_cd

# auto pushd if cd.
setopt auto_pushd
# ignore duplicate directory in pushd.
setopt pushd_ignore_dups

# share history in same session zsh.
setopt share_history

# ignore duplicate command in history.
setopt hist_ignore_all_dups

# ignore command if begin with space.
setopt hist_ignore_space

# trim blanks
setopt hist_reduce_blanks

# use high wildcard
setopt extended_glob

########################################
# keybind

# enable wildcard with "Ctrl+R" history command search.
bindkey '^R' history-incremental-pattern-search-backward

########################################
# alias

alias la='ls -al'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# Enable alias with sudo command.
alias sudo='sudo '

# global
alias -g L='| less'
alias -g G='| grep'

alias -g vu='vagrant up'
alias -g vs='vagrant ssh'
alias -g vh='vagrant halt'
alias -g vr='vagrant reload'

alias -g gs='git status'
alias -g ga='git add'
alias -g gd='git diff'
alias -g gc='git checkout'
alias -g gl='git log'
alias -g gf='git fetch'
alias -g gb='git branch'

dbdl(){ scp -rC root@$1:~/backup/mysql/`ssh $1 "ls -ltr /root/backup/mysql | tail -n 1 | rev | cut -d' ' -f1 | rev"` ./$1_`date +%y%m%d`.sql.gz }
drestore(){ zcat $1 | mysql -u root -p $2 }
dsync_remote(){ scp root@$1:~/backup/mysql/`ssh $1 "ls -ltr /root/backup/mysql | tail -n 1 | rev | cut -d' ' -f1 | rev"` ./${1}_`date +%y%m%d`.sql.gz ; zcat ${1}_`date +%y%m%d`.sql.gz | mysql -u root -p $2 }
duser(){ zcat /var/www/html/User*.sql.gz | mysql -u root -p $1}

alias -g ms='mysql -u root -p'
alias -g esl='exec $SHELL -l'

# copy to clipboard with "C"
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# set each OS
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:



#########################################
# Tab switch keybind
# alias twd=new_terminal_working_directory
function new_terminal_working_directory() {
  osascript > /dev/null << --END
    tell application "System Events" to click menu item 2 of menu 1 of menu bar item 3 of menu bar 1 of application process "Terminal"
    delay 0.1
    tell application "Terminal"
      do script "cd $(pwd)" in first window
    end tell
--END
}

zle -N new_terminal_working_directory
bindkey "^T" new_terminal_working_directory



# zsh-bd
. ~/.zsh_repo/plugins/bd/bd.zsh

