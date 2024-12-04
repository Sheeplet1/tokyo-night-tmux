{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.tmuxPlugins.mkTmuxPlugin {
          pluginName = "tokyo-night-tmux";
          version = "1.0";
          src = ./.;
          rtpFilePath = "tokyo-night.tmux";

          meta = {
            homepage = "https://github.com/Sheeplet1/tokyo-night-tmux";
            description = "Tokyo Night Tmux";
            license = pkgs.lib.licenses.mit;
            platforms = pkgs.lib.platforms.unix;
            maintainers = with pkgs.lib.maintainers; [ Sheeplet1 ];
          };
        };
      });
    };
}
