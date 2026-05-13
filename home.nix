{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "sakanai";
  home.homeDirectory = "/home/sakanai";

  home.stateVersion = "25.11";

  home.packages = [
    # cli apps
    pkgs.gowall
    pkgs.yazi
    pkgs.zoxide
    pkgs.starship
    pkgs.eza
    pkgs.opencode
    pkgs.rustup
    pkgs.nh
    pkgs.neovim
    # gui apps 
    pkgs.celluloid
    pkgs.thunderbird
    pkgs.firefox
    pkgs.discord

    inputs.caelestia-cli.packages.${pkgs.system}.default
    inputs.caelestia-shell.packages.${pkgs.system}.default
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sakanai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    settings.user.name = "santakameow";
    settings.user.email = "sakanai@cum.army";
  };
  
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
      line-numbers = true;
      syntax-theme = "gruvbox-dark";
    };
  };
  
#TODO refactor this thing
  xdg.configFile."hypr".source = ./hypr;
  xdg.configFile."fish".source = ./fish;
  xdg.configFile."nvim".source = ./nvim;

  programs.home-manager.enable = true;
}
