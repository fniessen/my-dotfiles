# my-dotfiles - Project Guidelines

## Context and sources

Personal Bash, Git, SQLFluff, and Emacs configuration.

Preserve compatibility and sourcing order across `.bashrc`, `.gitconfig`,
`.sqlfluff`, `.emacs.d/`, and `bin/rc-common-settings-my-dotfiles`.

## Changes and precautions

- Keep changes focused and preserve unrelated working-tree edits.
- If a file is generated from an Org/Babel source, edit that source and
  regenerate only the affected output; inspect tangle directives first.
- Use syntax checks for the affected configuration. Do not replace
  home-directory configuration or source unknown startup commands into the
  active shell as a test.

## Org mode headers

- Recursively scan this Git repository's `.txt` files and prepend the
  following exact first line when missing:

  ```text
  # Hey Emacs, this is a -*- org -*- file ...
  ```

- Preserve the rest of the file and its line endings. Do not follow
  symbolic links, scan `.git`, or cross into nested Git repositories.
- For `.org` files, omit this redundant header; remove it only when it
  matches the exact first line above.

## Validation

- Inspect `Makefile` for prerequisites and side effects before
  choosing a target; do not assume `all` is a safe test command.
- For shell changes, `make lint-shell` runs the repository's
  ShellCheck checks; it requires ShellCheck to be installed.
- For documentation-only changes, review the diff and affected local
  links; run an export only when rendering is part of the change.
- Never report an unrun or unavailable validation as successful. Do not
  install new tooling solely to validate an instructions-file change.
