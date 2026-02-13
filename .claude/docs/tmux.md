# Tmux Configuration

## File location

```
stow/tmux/.config/tmux/tmux.conf
```

## Key settings

- **Prefix**: `C-a` (remapped from default `C-b`)
- **Escape time**: 1ms (fast mode switching for vim)
- **Terminal**: tmux-256color with RGB override
- **Mouse**: disabled

## Keybindings

### Prefix commands (after `C-a`)

| Key | Action |
|-----|--------|
| `r` | Reload config |
| `\|` | Split horizontally |
| `-` | Split vertically |
| `^` | Split horizontal full-height |

### Pane navigation (vim-style)

| Key | Action |
|-----|--------|
| `h` | Select pane left |
| `j` | Select pane down |
| `k` | Select pane up |
| `l` | Select pane right |
| `C-h` | Previous pane |
| `C-l` | Next pane |

### Pane resizing (repeatable)

| Key | Action |
|-----|--------|
| `H` | Resize left 5 |
| `J` | Resize down 5 |
| `K` | Resize up 5 |
| `L` | Resize right 5 |

## Visual settings

- Activity monitoring enabled for other windows
- Status bar at bottom
- Focus events enabled (for git gutter integration in vim)

## Plugins (currently disabled)

- tpm (plugin manager)
- tmux-resurrect (session persistence)
- tmux-session-wizard

## Notes

- `C-a C-a` sends literal `C-a` to applications
- RGB colors enabled via terminal overrides for true color support
