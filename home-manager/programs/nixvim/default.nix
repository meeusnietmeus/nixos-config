{ pkgs, lib, ... }:

{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.oxocarbon.enable = true;

    plugins = {
      telescope.enable = true;
      yazi.enable = true;

      nix.enable = true;

      #blink-cmp.enable = true;

      web-devicons.enable = true;

      undotree.enable = true;

      treesitter = {
        enable = true;

        folding = true;

        settings = {
          ensure_installed = [
            "nix"
            "svelte"
            "lua"
            "javascript"
            "typescript"
            "go"
            "fish"
            "json"
            "html"
            "c"
            "cpp"
            "css"
            "yaml"
            "toml"
            "regex"
          ];

          highlight.enable = true;
          indentation.enable = true;
          incremental_selection.enable = true;
        };
      };
    };

    extraConfigLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true

      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.incsearch = true

      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2

      vim.opt.mouse = 'a'

      vim.opt.list = true
      vim.opt.listchars = {
        tab = '→ ',
        trail = '·',
        nbsp = '␣'
      }

      vim.opt.undofile = true
    '';
  };
}
