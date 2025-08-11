{ pkgs, lib, ... }:

{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    colorschemes.oxocarbon.enable = true;

    plugins = {
      lsp-format.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installRustc = false; # should always be handled via flake
            installCargo = false;
          };
        };
      };

      telescope.enable = true;
      yazi.enable = true;

      nix.enable = true;

      blink-cmp = {
        enable = true;
        setupLspCapabilities = true;

        settings = {
          keymap = {
            preset = "super-tab";
          };
          sources = {
            default = [
              "buffer"
              "lsp"
              "path"
              "snippets"
            ];
          };
        };
      };

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

      config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end;
    '';
  };
}
