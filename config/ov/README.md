# ov Configuration

Configuration for `ov` - a feature-rich terminal pager (alternative to less/more).

## Overview

`ov` is a modern terminal pager with advanced features:
- **Vim-like keybindings** - j/k, g/G, search with /?, etc.
- **Multiple view modes** - markdown, psql, mysql with syntax-aware formatting
- **Search highlighting** - Multi-color highlights, incremental search
- **Column mode** - CSV/TSV viewer with column highlighting
- **Follow mode** - Tail -f like behavior
- **Watch mode** - Auto-reload on file changes

## Files Included

- `config.yaml` - Main configuration with keybindings and styling

## Configuration Highlights

### Vim-like Navigation
```yaml
- down: j, Enter, Down, ctrl+n
- up: k, Up, ctrl+p
- top: g, Home
- bottom: G, End
- page_down: PageDown, ctrl+d, ctrl+v
- page_up: PageUp, ctrl+u, ctrl+b
```

### Search
- `/` - Forward search
- `?` - Backward search
- `n` - Next match
- `N` - Previous match
- Incremental search enabled by default

### Key Features
- **Wrap mode** (w/W) - Toggle line wrapping
- **Column mode** (c) - CSV/TSV viewing
- **Follow mode** (ctrl+f) - Tail mode
- **Watch mode** (F4) - Auto-reload
- **Mark lines** (m/M) - Bookmark navigation

### Styling
- Gruvbox-inspired colors
- Search highlight with reverse colors
- Mark lines highlighted in darkgoldenrod
- Multi-color highlights for multiple search terms

## Usage with aerc

Configured as default pager in `~/.config/aerc/aerc.conf`:
```ini
pager=ov
```

## Dependencies

- `ov` - The pager itself

## References

- [ov GitHub Repository](https://github.com/noborus/ov)
- [ov Documentation](https://github.com/noborus/ov/blob/master/README.md)

## Notes

- Works seamlessly with aerc for email viewing
- Supports ANSI escape codes (colors from filters)
- Mouse support enabled by default (toggle with ctrl+F8)
- Custom keybindings fully compatible with vim muscle memory
