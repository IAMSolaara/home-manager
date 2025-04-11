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
# -----

