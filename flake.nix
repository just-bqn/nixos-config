{
  description = "My Nix config.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl-gtk-on-nix = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    zen-browser-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    globals = rec {
      hostname = "bqn-nixos";
      username = "_bqn";
      base16-scheme = "nord";

      configDirectory = "${homeDirectory}/Repositories/nixos-config";
      homeDirectory = "/home/${username}";
      notesDirectory = "${homeDirectory}/Documents";

      keyboards = [
        "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        "/dev/input/by-id/usb-SEMICO_USB_Keyboard-event-kbd"
      ];
      system = "x86_64-linux";
    };
  in {
    nixosConfigurations = {
      ${globals.hostname} = nixpkgs.lib.nixosSystem {
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.aagl-gtk-on-nix.nixosModules.default
          inputs.disko.nixosModules.disko
          inputs.flake-programs-sqlite.nixosModules.programs-sqlite
          inputs.impermanence.nixosModules.impermanence
          inputs.nixvim.nixosModules.nixvim
          inputs.stylix.nixosModules.stylix

          {
            home-manager.sharedModules = [
              inputs.impermanence.nixosModules.home-manager.impermanence
              inputs.plasma-manager.homeManagerModules.plasma-manager
              inputs.spicetify-nix.homeManagerModules.default
            ];
          }

          ./configuration.nix
        ];

        specialArgs = {inherit inputs outputs globals;};
      };
      #
      # live = nixpkgs.lib.nixosSystem {
      #   inherit (globals) system;
      #   specialArgs = {inherit inputs outputs globals;};
      #   modules = [
      #     "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
      #   ];
      # };
    };

    packages.${globals.system}.neovim =
      inputs.nixvim.legacyPackages.${globals.system}.makeNixvim ./modules/nixos/nixvim/modules;

    templates = {
      cpp = {
        path = ./templates/cpp;
        description = "C++ template.";
      };

      python = {
        path = ./templates/python;
        description = "Python template.";
      };
    };
  };
}
