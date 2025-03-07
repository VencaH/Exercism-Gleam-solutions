{
  description = "Gleam";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ erlang gleam rebar3 ];

            shellHook = ''
              ${pkgs.gleam}/bin/gleam --version
            '';
          };
        };
      });
}
