# Karabiner-Elements Configuration

Keyboard remapping for macOS.

## File location

```
stow/karabiner/.config/karabiner/karabiner.json
```

Note: `automatic_backups/` contains generated files - do not edit.

## Profile: PrasanthWork

### Global modifications

| From | To |
|------|-----|
| Caps Lock | Left Control |

### Device-specific modifications

**External keyboard (vendor 1203, product 12315)**
- Caps Lock → Left Control
- Left Command → Left Option
- Left Option → Left Command

**Apple keyboard (vendor 1452, product 591)**
- Caps Lock → Left Control

**Other keyboard (vendor 1204, product 257)**
- Left Option → Left Command

### Complex modifications

| Trigger | Action |
|---------|--------|
| Print Screen | Cmd+Shift+5 (Screenshot) |

## Notes

- Caps→Control is applied globally and per-device for reliability
- Command/Option swaps normalize external PC keyboards to Mac layout
- Use Karabiner-EventViewer to identify vendor/product IDs for new keyboards
