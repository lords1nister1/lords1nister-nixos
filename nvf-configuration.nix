{ pkgs, lib, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    optPlugins = [ "nvim-autopairs" ];

    luaConfigRC.post = ''
      -- Add extra pairing rule for Nix files
      local ok_rule, rules = pcall(require, "nvim-autopairs.rules")
      if ok_rule and type(rules.add_rules) == "function" then
        local ok_Rule, Rule = pcall(require, "nvim-autopairs.rule")
        if ok_Rule then
          rules.add_rules({ Rule("{", "}", "nix") })
        end
      end
    '';

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
