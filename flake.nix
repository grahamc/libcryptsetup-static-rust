{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.rustPlatform.buildRustPackage
        rec {
          pname = "staticcryptsetup";
          version = "0.1.0";

          buildInputs = [
            pkgs.cryptsetup
          ];

          nativeBuildInputs = [
            pkgs.pkg-config
            pkgs.rustPlatform.bindgenHook
          ];

          src = self;

          cargoLock.lockFile = src + "/Cargo.lock";
        };

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
