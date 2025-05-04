# -----
use std "path add"
path add /opt/homebrew/bin/
path add /usr/local/bin
path add ~/.local/bin
path add ~/.cargo/bin
path add /opt/homebrew/opt/mysql-client@5.7/bin
path add /opt/homebrew/opt/mysql-client/bin
path add ($env.HOME | path join '.krew' | path join 'bin')
path add ($env.HOME | path join '.mix' | path join 'escripts')
path add ($env.HOME | path join '.bun' | path join 'bin')
path add ($env.HOME | path join 'go' | path join 'bin')
# -----
