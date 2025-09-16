{ inputs, pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    settings.vim = {
      binds.whichKey.enable = true;

      options.tabstop = 2;
      options.shiftwidth = 2;

      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      # theme = {
      #   enable = true;
      #   name = "catppuccin";
      #   style = "mocha";
      # };

      telescope.enable = true;
      statusline.lualine.enable = true;
      autocomplete.blink-cmp.enable = true;
      utility.oil-nvim.enable = true;

      lsp.enable = true;
      languages = {
        enableTreesitter = true;

        nix.enable = true;
      };
    };
  };
}
