{config, pkgs, ... }:

let
    myAliases = {
        ll = "ls -l";
        ls = "eza --icons -l -T -L=1";
        ".." = "cd ..";
        fd = "fd -Lu";
        w3m = "w3m -no-cookie -v";
        neofetch = "disfetch";
        fetch = "disfetch";
        gitfetch = "onefetch";
    }; #myAliases
in
{
programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
}; #programs.bash

programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    initContent = ''
    PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
     %F{green}→%f "
    RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    '';
}; #programs.zsh

 home.packages = with pkgs; [
    disfetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd bc
    direnv nix-direnv
  ];


  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;


}
