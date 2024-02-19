# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
# PS1="%B%{$fg[red]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$reset_color%}$%b "
# PS1="%B%n@%M %~%{$reset_color%}$%b "
PS1="%B%~%{$reset_color%}%b $%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
setopt +o nomatch

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.local/share/zsh/history"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use neovim for vim if present.
#[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Use $XINITRC variable if file exists.
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

# sudo not required for some system commands
for command in mount umount sv pacman updatedb su shutdown poweroff reboot gparted ; do
	alias $command="sudo $command"
done; unset command

se() { cd ~/.local/bin; $EDITOR $(fzf) ;}

ulimit -s 2000123

## Change cursor shape for different vi modes.
#function zle-keymap-select () {
#    case $KEYMAP in
#        vicmd) echo -ne '\e[1 q';;      # block
#        viins|main) echo -ne '\e[5 q';; # beam
#    esac
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^s' '^ulfcd\n'

bindkey -s '^r' '^usxb 2> /dev/null\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey -s '^x' '^uao\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# bat as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'" not sure what this was, doesnt work anymore
export MANPAGER="bat -l man -p"
# works mostly, breaks on some lines, still better than less or wtvr

# Verbosity and settings that you pretty much just always are going to want.
alias \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	bc="bc -ql" \
	mkd="mkdir -pv" \
	ffmpeg="ffmpeg -hide_banner" \
    cpy="xclip -selection c"

# Colorize commands when possible.
alias \
	ccat="highlight --out-format=ansi" \
	ip="ip -color=auto" \
        ls="ls -hN --color=auto --group-directories-first" \
    ll='ls -lh --color=auto' \
	la='ls -a --color=auto' \
	lla='ls -lah --color=auto' \

    #ls='exa --color=always --group-directories-first' \
    #ll='exa -lF --color=always --group-directories-first' \
    #la='exa -a --color=always --group-directories-first' \
    #lla='exa -alF --color=always --group-directories-first' \
    #l='exa -F --color=always --group-directories-first' \
    #l.='exa -a | egrep "^\."' \



# These common commands are just too long! Abbreviate them.
# General
alias \
	c='clear' \
	trem="transmission-remote" \
	sdn="shutdown -h now" \
	e="$EDITOR" \
	v="$EDITOR" \
    t="tmux" \
    ta="tmux a" \
	p="pacman" \
	z="zathura" \
	grep='grep --colour=auto' \
	diff="diff --color=auto" \
	egrep='egrep --colour=auto' \
	fgrep='fgrep --colour=auto' \
	hist='less +G $HISTFILE' \
    h="sort $HISTFILE | uniq | fzf | tr '\\n' ' ' | cpy" \
    sv="sudo nvim" \
    pss="ps -aux | grep" \
    ev='v ~/.config/nvim/init.vim' \
    ez='v ~/.zshrc' \
    es='v ~/portal/share' \
    edwm='cd ~/.local/src/dwm && v ~/.local/src/dwm/config.h && cd -' \
    est='v ~/.local/src/st/config.h' \
    eur='v ~/.config/newsboat/urls' \
    cfg='cd ~/.config/ && ls' \
    curl='curl --no-progress-meter' \
    n='nvim ~/vimwiki/index.wiki' \

#Programs n other
alias \
    fm='pcmanfm' \
    sst='sudo systemctl' \
    cdf='~/files/programs/problems/codeforces' \
    cdp='~/files/programs' \
    cdc='~/.local/src' \
    cdb='~/.local/bin' \
    ao='ao && exit' \
    rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'" \
    pkgsizesort='expac "%n %m" -l"\n" -Q $(pacman -Qq) | sort -rhk 2' \
    ytm="ytfzf -m" \
    ytdw="ytfzf -d" \
    mpm="mpv --no-video" \
    psu="sudo pacman -Syu" \
    ysu="yay -Syu" \
    ysur="yay --noconfirm -Syu && reboot" \
    ysus="yay --noconfirm -Syu && shutdown now" \
    asgg="sudo pacman -Sgg | grep " \
    ytmp3="yt-dlp -f 'ba' -x --audio-format mp3 -o '%(title)s.%(ext)s'" \
    ytmp4="yt-dlp -S res,ext:mp4:m4a --recode mp4" \
    ytmp3fzf='ytmp3 $(ytfzf --type=all -L)' \
    tekk="mpv --volume=90 --shuffle ~/wake/*" \
    chil="mpv --volume=50 --shuffle ~/chill/*" \

alias \
    pycharm="export _JAVA_AWT_WM_NONREPARENTING=1; setsid pycharm; exit" \
    delnvimswap="rm ~/.local/state/nvim/swap/*" \
    emoji="v ~/.local/share/air/chars/emoji" \
    med="mpv ~/meditation.mp4 breathing.mp4" \
    codiumext="codium --list-extensions > ~/.config/VSCodium/User/codium_extensions_list" \
	lf="lfub" \
    sxb="sxiv -tf *" \
    ccl="cd && clear && ls" \
    ppf="systemctl --user restart pipewire && sleep 2 && killall wireplumber" \
    brs="setsid -f st -e browser-sync -b surf -w ." \
	#ref="shortcuts >/dev/null; source ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc ; source ${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" \
	#magit="nvim -c MagitOnly" \
	#weath="less -S ${XDG_DATA_HOME:-$HOME/.local/share}/weatherreport" \
#additional aliases:

PATH="$HOME/.local/bin:$PATH"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
