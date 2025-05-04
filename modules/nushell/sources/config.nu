$env.config.show_banner = false;

$env.config.cursor_shape.emacs = "blink_line";
$env.config.cursor_shape.vi_insert = "block";
$env.config.cursor_shape.vi_normal = "underscore";

$env.config.use_kitty_protocol = true;

$env.config.hooks.env_change.PWD = [];

# -----
export def send-notification [msg: string, --title: string = "from nu"] {
    if (sys host).name == "Darwin" {
        ^osascript -e $"display notification \"($msg)\" with title \"($title)\""
    } 
}

def "from env" []: string -> record {
    lines 
    | split column '#' 
    | get column1 
    | filter {($in | str length) > 0} 
    | parse "{key}={value}"
    | update value {str trim -c '"'}
    | transpose -r -d
}

def get_aerospace_windows [--app-name: string]: nothing -> table {
    let windows = aerospace list-windows --all 
        | parse '{window_id} | {app_name} | {window_title}'
        | str trim 
    match $app_name {
        null => $windows
        _ => ($windows | where app_name == $app_name)
    }
}

alias l = ls -la
alias ll = ls -l
alias vim = nvim
#alias kubectl = kubecolor
#alias k = kubectl
alias hyfetch = hyfetch --ascii-file "/Users/evermore/Documents/solaara_logo.txt"
alias tailscale = /Applications/Tailscale.app/Contents/MacOS/Tailscale
alias make_xiv_fullscreen = aerospace fullscreen --no-outer-gaps on --window-id (get_aerospace_windows --app-name 'FINAL FANTASY XIV' | get window_id | to text | str trim)
alias reload-tmux-config = tmux source-file ~/.config/tmux/tmux.conf
alias clabverter = docker run --rm --platform linux/amd64 --user (id -u) -v $"(pwd):/clabernetes/work" ghcr.io/srl-labs/clabernetes/clabverter
alias wireshark = /Applications/Wireshark.app/Contents/MacOS/Wireshark

# show console banner
try {
    so-logo-ascii-generator $"(hostname -s)" -c
}
# -----

