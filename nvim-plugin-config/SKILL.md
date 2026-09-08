---
name: nvim-plugin-config
description: Install, remove, or modify lazy.nvim plugin specifications in the current Neovim configuration. Use when a user asks to add a Neovim plugin, change plugin options, dependencies, keymaps, lazy-loading, version/build settings, or reorganize files under lua/plugins; do not use for unrelated core editor settings.
---

# Neovim Plugin Config

Work only in the current Neovim configuration directory. Preserve its existing plugin manager, module layout, formatting, and conventions unless the user explicitly asks to change them. Inspect the repository before proposing edits; in this configuration, lazy.nvim imports plugin specs from `lua/plugins/*.lua`.

## Clarify the desired configuration

For a new plugin, establish the repository slug or official plugin URL and the behavior the user wants. For an existing plugin, find its current spec and merge into it rather than creating a duplicate.

Offer a short, context-specific menu of common configurable choices and let the user select. Include only choices that materially affect this plugin, typically:

- purpose or feature set to enable;
- lazy-loading trigger: event, command, filetype, keymap, or startup;
- keymaps and descriptions;
- dependencies or optional integrations;
- release policy: stable tag/version, branch, or latest commit;
- build/update command when the plugin requires one;
- plugin-specific `opts`, including a recommended preset when supported;
- configuration file/category when more than one location is reasonable.

Recommend sensible defaults and state their effect in one sentence. Do not make the user choose values that can be safely inferred from the repository, plugin defaults, or their request. If the user already supplied enough detail, edit directly. Ask at most three focused questions at a time; use mutually exclusive choices where practical and allow a free-form answer. Do not present unsupported plugin options as facts.

## Verify plugin information

Before adding an unfamiliar plugin or option, consult its current official documentation when internet access is available. Confirm its canonical repository, minimum Neovim version, dependencies, setup shape, lazy-loading caveats, build steps, and option names. Prefer the plugin's README/help/docs and lazy.nvim documentation over third-party examples.

If documentation cannot be checked, say which details are inferred and avoid inventing options. Do not run installation, synchronization, update, or build commands merely to discover configuration.

## Edit the configuration

Place the spec in the closest existing category under `lua/plugins/`; create a clearly named category file only when none fits. Keep one valid returned LazySpec list per module.

Use native lazy.nvim fields where applicable: `dependencies`, `event`, `cmd`, `ft`, `keys`, `version`, `branch`, `build`, `opts`, `config`, `init`, `enabled`, and `cond`. Prefer `opts` over a manual `config` callback when the plugin supports ordinary `setup(opts)`. Use `config` only for imperative setup, global variables that must be assigned in a particular phase, or coordinated configuration across plugins.

Preserve unrelated user changes. Before editing, inspect the target file and relevant neighboring specs for conventions and key conflicts. Merge tables carefully, keep existing comments that remain accurate, and avoid rewriting an entire file for a small change. Never edit `lazy-lock.json` by hand.

Removing a plugin includes removing only its spec and configuration made exclusively for it. Point out potentially shared dependencies, keymaps, commands, or integrations rather than deleting them speculatively.

## Validate

After changes:

1. Format only changed Lua files with the repository's formatter when one is configured and available.
2. Check changed files for Lua syntax errors using an available Lua/Neovim parser.
3. Run a non-interactive Neovim startup check when feasible, while avoiding plugin updates or network mutations.
4. If installation or a native build is required, report the exact `:Lazy` action the user should run. Execute it only when the user asked to install/sync and the side effects are within scope.

Summarize the selected behavior, changed files, validation result, and any remaining manual installation step.
