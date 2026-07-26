# Neovim config

## Requirements

Before installing, make sure you have the following:

- Neovim >= 0.12.0
- A **Nerd Font** installed (e.g. FiraCode, JetBrainsMono), I personally use
  CommitMono Nerd Font
- Required by some plugins: `fd`, `ripgrep`, `fzf`
- For treesitter and plugin management: `gcc`, `make`, `tree-sitter-cli`
  (required to build tree-sitter parsers), `git`, `npm`, `python`, `curl`,
  `wget`

## Installation

Backup old config (if any and only if you want):

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Remove leftovers of previous Neovim configuration:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

Clone the repository. If you prefer SSH, you can use
`ssh://git@codeberg.org/AleHanndro/nvim.git` instead.

```bash
git clone https://codeberg.org/AleHanndro/nvim.git ~/.config/nvim --depth=1
```
