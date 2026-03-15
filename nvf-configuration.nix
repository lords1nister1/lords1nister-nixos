{ pkgs, lib, ... }:
{
  vim = {
    options = {
      clipboard = "unnamedplus";
    };
    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };
    keymaps = [
      {
        key = "<leader>y";
        mode = ["v"];
        action = "\"+y";
        silent = true;
      }
      {
        key = "<leader>Y";
        mode = ["n"];
        action = "\"+yy";
        silent = true;
      }
      {
        key = "<C-c>";
        mode = ["v"];
        action = "\"+y";
        silent = true;
        noremap = true;
      }
    ];
    autopairs.nvim-autopairs.enable = true;
    theme = {
      enable = true;
      name = "github";
      style = "dark_tritanopia";
      transparent = true;
    };
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
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
    extraPlugins.presence-nvim = {
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "presence.nvim";
        version = "87c857a56b7703f976d3a5ef15967d80508df6e6";
        src = pkgs.fetchFromGitHub {
          owner = "andweeb";
          repo = "presence.nvim";
          rev = "87c857a56b7703f976d3a5ef15967d80508df6e6";
          hash = "sha256-ZpsunLsn//zYgUtmAm5FqKVueVd/Pa1r55ZDqxCimBk=";
        };
      };
      setup = ''
        require("presence").setup({
          auto_update = true,
          file_assets = {},
          show_time = true,
          editing_text = "Editing %s",
          file_explorer_text = "Browsing %s",
          git_commit_text = "Committing changes",
          plugin_manager_text = "Managing plugins",
          reading_text = "Reading %s",
          workspace_text = "Working on %s",
          line_number_text = "Line %s out of %s",
        })
      '';
    };
  };
}
