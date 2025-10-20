# modneo-modeline

A simple plugin to add and update modelines with settings
from current buffer.

## Features ✨

- Supports both modeline styles
- Can honor style of existing modelines

## Setup 🚀 and Configuration ⚙

Setup with Lazy

```lua
return { "Coding4Glory/modneo-modeline.nvim",
    -- default settings, for defaults set an empty table `{}`
    opts = {
        ---The modeline style, can be separated (first form from help) and set
        ---(second form from help)
        style = 'set',
        ---The separator to use, either blank `' '` or colon `":"`.
        ---Default: blank
        separator = ' ',
        ---Prefix string the prefix to use for the modeline, one of vi, vim
        ---Vim or ex. Default: vim
        prefix = 'vim',
        ---A table with opts and flags to include
        include = {
            ---opts are considered having avalue e. g. ts=4
            opts = {
                'ts',
                'sw',
                'tw',
            },
            ---flags don't have values e. g. et
            flags = {
                'et',
            }
        },
        ---add additional spaces where applicable
        add_space = true,
        ---adds the default keybinding
        add_default_keybindings = true,
        ---automatically update or append modelines on write
        update_on_save = false,
        ---Override settings with style of existing modeline
        honor_existing = true,
    }
}
```

## Commands ⌨

```vimdoc
                                                   *modneo-modeline-append*
:ModelineAppend[!]     Appends the modeline if missing. If bang is present a
                       modeline will be added regardless of an existing

                                                   *modneo-modeline-update*
:ModelineUpdate[!]     Replaces existing or appends a new modeline with current
                       settings
```

Both commands only work if the comment string is set in the current buffer.
This can be overriden with bang.

## Known Issues ⚡

Checks only the last line. Will fail or cause unexpected behaviour
in following situation (which are supported by vim/neovim):

- Last line is an empty line after modeline
- Modeline is at the top of the file. Allowed by spec, but not seen in the wild.

## Contribution 🤜🤛

Rules to be set up

<!-- vim: set et ts=4 sw=4 tw=78: -->