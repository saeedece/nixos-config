$env.LS_COLORS = (open ~/.config/nushell/ls_colors.txt)
$env.PATH = $env.PATH | append "~/.local/bin"
source ~/.config/nushell/zoxide.nu
source ~/.config/nushell/starship.nu
