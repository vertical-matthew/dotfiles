# Neovim Dotfiles — Driver’s Manual (Updated)

This config is built to be **fast**, **portable**, and **muscle-memory friendly**.  
Leader-heavy workflows, strong text objects, and minimal friction on Windows.

---

## Start / Update

### Install / sync plugins
- `:Lazy` → plugin UI
- `:Lazy sync` → install/update plugins

### Quick checks
- `:checkhealth` → diagnose providers/plugins
- `:LspInfo` → confirm LSP attached to current buffer

### Treesitter
- `:TSUpdate` → update parsers
- `:TSInstall python` → install python parser (example)

---

## Controls (Keymap Summary)

### Leader
- **Leader** = `<Space>`

### Save / Quit
- `ww` → write all
- `Ctrl+s` → write current buffer (only if changed)
- `qq` → quit all
- `q` → quit current window

### Insert mode
- `jk` → escape

### Clear search highlight
- `Enter` (normal mode) → clear search highlight

---

## Movement (Muscle Memory)

### Paragraph jumps
- `J` → next paragraph (`}`)
- `K` → previous paragraph (`{`)

### Half-page scroll (recommended mapping)
- `Ctrl+j` → half page down (`<C-d>`)
- `Ctrl+k` → half page up (`<C-u>`)

### Jump list back/forward
- `H` → jump back
- `L` → jump forward

### File top/bottom (arrows)
- `Up` → top of file
- `Down` → bottom of file

### Line start/end
- `Ctrl+h` → first non-blank (`^`)
- `Ctrl+l` → end of line (`$`)

---

## Buffers / Tabs (barbar.nvim)

- `Left` → previous buffer
- `Right` → next buffer

(If you get too many open buffers: use Telescope buffers.)

---

## File Browser (oil.nvim)

Open:
- `-` → Oil (parent dir)
- `F5` or `<leader>5` → Oil

Inside Oil:
- It’s an editable directory buffer (rename/move/delete workflows available).
- Press **`g?`** inside Oil to see available keys for your installed version.

---

## Search / Jump (telescope.nvim)

- `<leader>ff` → find files
- `<leader>fg` → live grep (project search)
- `?` → live grep (same)
- `<leader>fb` → buffers
- `<leader>fh` → help tags
- `<leader>fl` → fuzzy search in current buffer
- `<leader>//` → fuzzy search in current buffer (alias)

Practical use:
- Use `?` when you don’t know where something lives.
- Use `<leader>fb` when you’ve opened “too many tabs.”

---

## Key Help (which-key.nvim)

- Press `<leader>` and pause → popup of available leader mappings
- `:WhichKey` → manual invocation

Notes:
- which-key can show icons. `nvim-web-devicons` is installed and loaded early.
- If you ever see missing icon warnings, it means devicons wasn’t loaded early enough.

---

## Teleport (hop.nvim)

- `<leader>w` → Hop word
- `<leader>a` → Hop line
- `<leader><leader>/` → Hop pattern

Use Hop when the target is visible and you want instant movement.

---

## Undo (undotree)

- `F6` or `<leader>6` → toggle UndoTree

UndoTree is for branching history (alternate timelines after undo + edit).

---

## Git Awareness (gitsigns.nvim)

- Shows added/changed/deleted lines in the gutter.
- Useful commands:
  - `:Gitsigns preview_hunk`
  - `:Gitsigns blame_line`
  - `:Gitsigns stage_hunk`
  - `:Gitsigns reset_hunk`

---

## LSP + Completion (pyright + nvim-cmp)

### Code navigation (buffer-local when LSP attaches)
- `gK` → hover docs (because `K` is your paragraph jump)
- `gd` → definition
- `gr` → references
- `<leader>rn` → rename symbol
- `[g` / `]g` → previous/next diagnostic

### Symbols (Tagbar replacement)
- `F8` or `<leader>8` → document symbols (Telescope list of functions/classes/etc.)

If it’s not working:
- confirm `pyright --version` in your terminal
- open a `.py` file and run `:LspInfo`

---

## Text Objects (Select Like a Surgeon)

### Entire file / buffer
- `ae` / `ie`
  - `vae` → select entire file
  - `dae` → delete entire file

### Line text object
- `al` / `il`
  - `yal` → yank a line
  - `yil` → yank “inner line”

### Indent block object (huge for Python/YAML)
- `ai` / `ii`
  - `vii` → select indent block
  - `dii` → delete indent block
  - `cii` → change indent block

### Python text objects (Python files only)
- Function: `af` / `if`
- Class: `ac` / `ic`
Examples:
- `vaf` / `vif` → select around/inner function
- `vac` / `vic` → select around/inner class
Extra motions (plugin-provided):
- `]pf` / `[pf` → next/prev function
- `]pc` / `[pc` → next/prev class

---

## Precision “f/t” (clever-f)

You still use:
- `f{char}`, `F{char}`, `t{char}`, `T{char}`

clever-f improves repeat behavior (so you don’t need `;` repeat semantics).

---

## Move Lines / Blocks (vim-move)

This config disables vim-move’s default keymaps to avoid collisions and binds explicit keys:

### Normal mode
- `Alt+j` → move line down
- `Alt+k` → move line up
- `Alt+h` → move line left
- `Alt+l` → move line right

### Visual mode
- `Alt+j` → move block down
- `Alt+k` → move block up
- `Alt+h` → move block left
- `Alt+l` → move block right

If Alt keys are flaky in your terminal, rebind these to leader keys.

---

## Browser helpers
- `<leader>dict` → open Dictionary.com for word under cursor
- `<leader>thes` → open Thesaurus.com for word under cursor

---

## Driving Patterns (What to actually do)

### Find → Edit → Save
1. `<leader>ff` (or `?`)
2. jump
3. edit
4. `ww`

### Refactor (Python)
1. `gd` to understand
2. `<leader>rn` rename
3. `gr` confirm impact
4. `[g`/`]g` fix diagnostics

### Reshape code quickly
- use text objects:
  - `cii`, `vaf`, `vac`, `vae`, `yil`
- use movement:
  - `J/K` paragraphs, `Ctrl+j/k` screen
- use Hop when you can see it

---

## If something breaks (fast path)
- `:checkhealth`
- `:Lazy`
- `:LspInfo`
- `:messages`

Verify external tools:
- `rg --version`
- `fd --version`
- `pyright --version`
