{
  description = "nix flake to manage claw code";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "rusty-claude-cli";
          version = "0.1.0";

          src = rust/.;

          cargoLock = {
            lockFile = rust/Cargo.lock;
          };

          cargoBuildFlags = [
            "--package"
            "rusty-claude-cli"
          ];

          doCheck = false;

          nativeBuildInputs = with pkgs; [
            pkg-config
          ];

          buildInputs = with pkgs; [
            openssl
          ];
        };
      });
}
