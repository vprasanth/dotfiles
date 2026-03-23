# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick start

```bash
# Check what's installed vs missing
./install.sh --check

# Pick individual formulas to install (uses fzf if available)
./install.sh --pick

# Interactive install (prompts for each category)
./install.sh

# Install everything
./install.sh --all
```

## Manual stow usage

```bash
# Link a single package
cd stow && stow nvim -t ~

# Link multiple packages
cd stow && stow nvim tmux zsh git -t ~
```

## What's included

| Package | Description |
|---------|-------------|
| nvim | Neovim config (lazy.nvim, LSP, Telescope) |
| tmux | Tmux with vim-style navigation |
| zsh | Minimal zsh config (fzf, zoxide, fnm) |
| git | Git user config |
| karabiner | Keyboard remapping (caps→ctrl) |
| btop | System monitor |

## Caps Lock → Control

**macOS**: Handled by Karabiner-Elements (stow package)

**Ubuntu**:
```bash
sudo vim /etc/default/keyboard
# Add: XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps
```

**Arch**: See [xmodmap wiki](https://wiki.archlinux.org/index.php/xmodmap#Turn_CapsLock_into_Control)

## Journaling

Use the following command for quick brain dumps/journaling.
Make sure ~/.journal exists.

```bash
j() {
  echo -e "\n$(date '+%H:%M')\n- $1" >> ~/journal/$(date +%F).md
}
```

### How to use

Hard rule:
- Each entry should take <30 seconds
- Don’t summarize → just trace your thinking

Messy is correct. Fragmented is correct.

Rule: write like you think, not like you report

Your brain doesn’t think in clean summaries:
- It jumps
- It questions
- It half-forms ideas

Capture that directly.

Use this simple prompt (when stuck)

Just answer one of these:
- “What am I doing?”
- “What am I stuck on?”
- “What’s next?”

That’s it. No more.
