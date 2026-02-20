{ pkgs, lib, ... }:

{
  vim = {
   autopairs.nvim-autopairs.enable = true;
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
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
