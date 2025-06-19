{ config, pkgs, inputs , ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ernstrom";
  home.homeDirectory = "/home/ernstrom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  #  /etc/profiles/per-user/ernstrom/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let's configure neovim!

  programs.neovim =
   let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua <<EOF\n${builtins.readFile file}\nEOF\n";
   in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

     extraPackages = with pkgs; [
      
      lua-language-server
      ripgrep
      fd
      nil
      wl-clipboard

    ];
    

    plugins = with pkgs.vimPlugins; [
    
      plenary-nvim

#      { 
#        plugin = nvim-lspconfig;
#        config = toLuaFile ./user/nvim/plugin/lsp.lua;
#      }


      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }
      
      neodev-nvim

   {
       plugin = nvim-cmp;
       config = toLuaFile ./user/nvim/plugin/cmp.lua;
    }

      { 
        plugin = telescope-nvim;
        config = toLuaFile ./user/nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
	        p.tree-sitter-vim
	        p.tree-sitter-bash
	        p.tree-sitter-lua
	        p.tree-sitter-python
  	      p.tree-sitter-json
          p.tree-sitter-r
        ]));
        config = toLuaFile ./user/nvim/plugin/treesitter.lua;
      }
      
      {
         plugin = lualine-nvim;
	     config = toLuaFile ./user/nvim/plugin/lualine.lua;
      }

      nvim-lspconfig
      nvim-web-devicons
      neo-tree-nvim

#      vim-nix
       
      ];

    extraLuaConfig = ''
      ${builtins.readFile ./user/nvim/options.lua}
    '';

  };
          
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
