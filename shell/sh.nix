{config, pkgs, ... }:

let
    myAliases = {
        ll = "ls -l";
        ".." = "cd ..";
    }; #myAliases
in
{
programs.bash = {
    enable = true;
    shellAliases = myAliases;
}; #programs.bash

programs.zsh = {
    enable = true;
    shellAliases = myAliases;
}; #programs.zsh


}
