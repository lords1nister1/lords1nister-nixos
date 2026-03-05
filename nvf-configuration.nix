{ pkgs, lib, ... }:

{
  vim = {
   autopairs.nvim-autopairs.enable = true;
    theme = {
      enable = true;
      name = "github";
      style = "dark_tritanopia";
      transparent = true;

    };

    statusline.lualine.enable = true;
    telescope.enable = true;

    autocomplete.nvim-cmp = {
      enable = true;
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix = {
        enable = true;
        lsp.server = "nixd";
      };

      ts.enable = true;
      rust.enable = true;
    };
  };
}
