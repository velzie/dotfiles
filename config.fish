if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ls 'ls --color=auto'
alias die "shutdown -P now"
alias btw "sudo pacman -S"
alias emerge "yay -S"
alias pkyeet "sudo pacman -Rns"
alias yeet "yay -Rns"
alias restart "sudo reboot"
alias linux "lolcat $HOME/.linuxcopypasta"
alias hack "hollywood"
alias neoflex "neofetch | lolcat"
alias c "clear"
alias rm "rm -i"
alias cs "cd"
alias .. "cd .."
alias f "fuck"
function fish_prompt
	fishline -s $status
end
function fish_greeting
	neoflex
end

thefuck --alias | source
if status is-interactive
    set FLINE_PATH $HOME/.config/fish/fishline
    source $FLINE_PATH/init.fish
end
