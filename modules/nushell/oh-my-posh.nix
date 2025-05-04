{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}: let
  cfg = config.solaaradotnet.shells.nushell;
in {
  config = lib.mkIf cfg.enable {
    programs.oh-my-posh.enable = true;
    programs.oh-my-posh.enableNushellIntegration = true;
    programs.oh-my-posh.settings = {
      version = 3;
      console_title_template = "{{.UserName}} in {{.PWD}}";
      final_space = true;
      iterm_features = ["prompt_mark" "current_dir" "remote_host"];
      palette = {
        rosewater = "#F4DBD6";
        flamingo = "#F0C6C6";
        pink = "#F5BDE6";
        mauve = "#C6A0F6";
        red = "#ED8796";
        maroon = "#EE99A0";
        peach = "#F5A97F";
        yellow = "#EED49F";
        green = "#A6DA95";
        teal = "#8BD5CA";
        sky = "#91D7E3";
        sapphire = "#7DC4E4";
        blue = "#8AADF4";
        lavender = "#B7BDF8";
        text = "#CAD3F5";
        subtext1 = "#B8C0E0";
        subtext0 = "#A5ADCB";
        overlay2 = "#939AB7";
        overlay1 = "#8087A2";
        overlay0 = "#6E738D";
        surface2 = "#5B6078";
        surface1 = "#494D64";
        surface0 = "#363A4F";
        base = "#24273A";
        mantle = "#1E2030";
        crust = "#181926";
      };
      transient_prompt = {
        background = "transparent";
        template = " {{ .PWD }}  ";
      };
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "text";
              style = "diamond";
              foreground = "p:red";
              background = "p:crust";
              template = "{{if .Root}}<b>{{.UserName}}</b>{{end}}";
              leading_diamond = "";
              trailing_diamond = " ";
            }
            {
              type = "path";
              style = "diamond";
              foreground = "p:pink";
              background = "p:crust";
              template = "{{ .Path }}";
              leading_diamond = "";
              trailing_diamond = " ";
              properties = {
                home_icon = "⌂";
                style = "powerlevel";
                mixed_threshold = 8;
                max_depth = 3;
              };
            }
            {
              type = "git";
              style = "diamond";
              background = "p:crust";
              foreground = "p:lavender";
              template = "{{ .HEAD }}{{ if .Working.Changed }} <p:sapphire>{{.Working.String}}</>{{end}}{{if .Staging.Changed}} <p:yellow>{{.Staging.String}}</>{{end}}{{if gt .Ahead  0}} <p:green>{{.Ahead}}</>{{end}}{{if gt .Behind 0}} <p:green>{{.Behind}}</>{{end}}";
              leading_diamond = "";
              trailing_diamond = "";
              properties = {
                branch_icon = " ";
                cherry_pick_icon = " ";
                commit_icon = " ";
                fetch_status = true;
                fetch_upstream_icon = false;
                merge_icon = " ";
                no_commits_icon = " ";
                rebase_icon = " ";
                revert_icon = " ";
                tag_icon = " ";
              };
            }
            {
              type = "text";
              style = "plain";
              foreground = "p:closer";
              template = "";
              foreground_templates = ["{{if .Root}}p:red{{end}}"];
            }
          ];
        }
        {
          type = "rprompt";
          alignment = "right";
          segments = [
            {
              type = "status";
              style = "plain";
              foreground = "p:red";
              template = "{{if .Error }}{{.String}}{{end}} ";
              properties = {always_enabled = true;};
            }
            {
              type = "executiontime";
              style = "plain";
              foreground = "p:text";
              template = "<p:subtext0>took</> {{ .FormattedMs }} ";
              properties = {
                threshold = 500;
                style = "austin";
              };
            }
            {
              type = "time";
              style = "diamond";
              leading_diamond = " ";
              trailing_diamond = "";
              foreground = "p:rosewater";
              background = "p:crust";
              template = "󰥔 {{ .CurrentDate | date .Format }}";
            }
            {
              type = "session";
              style = "diamond";
              leading_diamond = " ";
              trailing_diamond = "";
              foreground = "p:peach";
              background = "p:crust";
              template = "{{ if .SSHSession }} {{ .UserName }}@{{ .HostName }} {{ end }}";
              overflow = "hide";
            }
            {
              type = "talosctl";
              style = "diamond";
              leading_diamond = " ";
              trailing_diamond = "";
              foreground = "p:maroon";
              background = "p:crust";
              template = "󰊄 {{ .Context }}";
            }
            {
              type = "kubectl";
              style = "diamond";
              leading_diamond = " ";
              trailing_diamond = "";
              foreground = "p:blue";
              background = "p:crust";
              template = "{{ if .Context }}󱃾 {{ .Context }}::{{if .Namespace}}{{.Namespace}}{{else}}default{{end}}{{end}}";
            }
          ];
        }
      ];
    };
  };
}
