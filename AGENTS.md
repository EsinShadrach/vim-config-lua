# AGENTS.md

## Architecture
- **Plugin manager**: [packer.nvim](https://github.com/wbthomason/packer.nvim) — run `:PackerSync` to install/update, **not** `:Lazy`
- **Load order**: `init.lua` → `lua/rafe/{init,remap,set}.lua` → plugins loaded by packer → `after/plugin/*.lua`
- All plugin-specific config lives in `after/plugin/` (23 files). This is **not** the `lua/` directory.
- Keymaps are split across `lua/rafe/remap.lua` and individual `after/plugin/*.lua` files.

## Active Theme
- **Catppuccin macchiato** — configured in `after/plugin/catppucin.lua` with `vim.cmd.colorscheme "catppuccin"`
- 4 other themes are **installed but inactive**: Tokyo Night, OneDark, Rose Pine, Material. Their `setup()` calls still run on every startup (dead code). Only `catppucin.lua` has an uncommented `colorscheme` command.

## Completion & LSP
- **CoC** (`neoclide/coc.nvim`) is the primary completion engine, not nvim-cmp
- `<TAB>` / `<S-TAB>` navigate completions, `<CR>` confirms, `<c-space>` triggers
- LSP configs are split across:
  - `coc-settings.json` — Dart, Go, Kotlin LSP servers
  - `after/plugin/lsp_config.lua` — pyright, ts_ls, rust-analyzer, kotlin-language-server
  - `after/plugin/coc.lua` — CoC keymaps and `:Format` / `:OR` commands
- `:Format` (and `<C-P>`) invokes CoC formatting, not conform/null-ls
- `:OR` organizes imports (CoC)

## Rust
- `rust-tools.nvim` configured in `after/plugin/rustconfig.lua`
- Uses `<C-space>` for hover actions and `<Leader>a` for code action groups (overrides typical defaults)
- Inlay hints enabled with custom prefixes (`<-` / `=>`)

## Avante AI
- Primary provider: `gemini-cli`, auto-suggestions: `claude`
- Keymaps: `<leader>ha` (ask), `<leader>he` (edit), `<leader>hc` (add current file), `<leader>ht/hd/hs/hR` (toggle)

## Other Notes
- **Lualine** uses `theme = 'auto'` (override in `after/plugin/lualine.lua`). The packer spec's `'catppuccin'` is superseded.
- **nvim-tree** renders on the **right** side (`side = "right"`), dotfiles hidden by default
- **Supermaven** is installed but **disabled** (`condition = function() return false end`)
- **Snacks.nvim** is installed with no dedicated config file yet
- **Treesitter** auto-installs missing parsers (`auto_install = true`)
- **Dressing.nvim** uses `nui` input backend
- **Terminal bg sync**: On `UIEnter`/`ColorScheme`, terminal background syncs to `Normal` bg via OSC 11 (macOS dark mode only). Resets on `UILeave`.
- **ToggleBackground** command (`<leader>tb`) toggles `vim.o.background` between dark/light
- Snippets are CoC-based, stored in `snippets/` (dart, jsx, tsx)
- `:W` and `:Wa` are aliases for `:w` and `:wa`
