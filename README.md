# dotfiles

Thomas Nichols's dotfiles, managed with [chezmoi](https://www.chezmoi.io/).
Linux (bash, tmux, Neovim, git, WezTerm) plus a few Windows-only files
(PowerShell profile, key-remap scripts in `~\bin`); `.chezmoiignore` picks
per OS.

```bash
chezmoi init --apply https://github.com/thomasn/dotfiles.git
```

Fleet boxes are provisioned by faerieconfig, which applies a pinned commit of
this repo. Per-machine secrets live in `~/.bashrc.local` (not in this repo).

The pre-chezmoi dotfiles (2009–2026, symlinked with `linkall.sh`) are on the
`master` branch and tag `legacy`.
