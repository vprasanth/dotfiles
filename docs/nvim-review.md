Neovim Review Workflow
======================

This repo includes a lightweight review setup for Git branches and inline notes.

Summary
-------
- Diffview: open diffs and file history, plus a custom "compare vs target" command.
- Gitpad: per-project/branch/daily/per-file notes stored by the plugin.
- Snacks scratch: quick scratch buffers for temporary notes.
- Copy file:line: copy a reference to the current line for pasting into notes.

Setup
-----
1) Open Neovim and run `:Lazy sync` to install/update plugins.
2) Use the keymaps below.

Keymaps (leader is `,`)
-----------------------
Diffview
- `,gd` open diff view
- `,gc` close diff view
- `,gh` file history for current file
- `,gH` file history for repo
- `,gD` compare current branch vs target (see below)

GitLab (gitlab.nvim)
- `,gr` review MR for current branch
- `,gR` choose MR to review
- `,gM` open MR in browser

Notes
- `,pp` Gitpad project notes
- `,pb` Gitpad branch notes
- `,pd` Gitpad daily notes
- `,pf` Gitpad per-file notes
- `,.` Snacks scratch buffer
- `,S` Snacks scratch picker
- `,pl` copy `path:line` reference to clipboard

Diffview target compare
-----------------------
The `,gD` mapping compares your current branch to a target base using:
1) `vim.g.diffview_target` if set
2) `.diffview-target` file at repo root (first line)
3) fallback to `origin/main`

Example: create a `.diffview-target` file at the repo root:
```
origin/main
```

Notes behavior
--------------
Gitpad manages notes per repo/branch/file or date. It handles where notes are
stored internally; check the plugin docs if you want to change storage behavior.

Snacks scratch provides lightweight scratch buffers. Use it for temporary review
notes you do not want tied to a specific file.

GitLab MR review flow (terminal + Neovim)
-----------------------------------------
1) Fetch the merge request branch locally (example with a numbered MR):
```
git fetch origin merge-requests/123/head:mr-123
git checkout mr-123
```
2) Set the compare target for this repo once:
```
echo origin/main > .diffview-target
```
3) In Neovim, open the compare view:
- `,gD` to compare target...HEAD
4) Leave notes while you review:
- `,pp` for project notes, `,pb` for branch notes, `,pl` to copy `path:line`.

GitLab.nvim setup (self-hosted)
-------------------------------
Requirements:
- Go installed (gitlab.nvim uses a Go server). The plugin requires Go >= 1.25.1.

Authentication:
- Set `GITLAB_TOKEN` in your environment, or create a `.gitlab.nvim` file in the
  repo root. The file takes `auth_token` and optional `gitlab_url` values.
- For self-hosted GitLab, set `GITLAB_URL` (env var) or `gitlab_url` in the file.

Example `.gitlab.nvim`:
```
auth_token=your_gitlab_token
gitlab_url=https://gitlab.your-company.com/
```
