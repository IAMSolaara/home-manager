{...}: {
  # make_rgb_esc_fg :: int -> int -> int -> string
  make_rgb_esc_fg = r: g: b: (builtins.fromJSON ''"\u001b" '') + "[38;2;${builtins.toString r};${builtins.toString g};${builtins.toString b}m";

  # make_rgb_esc_bg :: int -> int -> int -> string
  make_rgb_esc_bg = r: g: b: "\u001b[48;2;${builtins.toString r};${builtins.toString g};${builtins.toString b}m";
}
