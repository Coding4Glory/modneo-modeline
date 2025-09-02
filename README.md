# modneo-modeline

A tiny plugin to add and update modelines with settings
from current buffer.

## Setup 🚀 and Configuration ⚙

Setup with Lazy

```lua
return { "Coding4Glory/modneo-modeline.nvim",
    -- default settings, for defaults set an empty table `{}`
    opts = {
        style = 'set',
        separator = ' ',
        prefix = 'vim',
        include = {
            opts = {
                'ts',
                'sw',
                'tw',
            },
            flags = {
                'et',
            }
        },
        add_space = true,
        add_default_keybindings = true,
        update_on_save = false,
    } 
}
```

## Commands ⌨

```vimdoc
                                                   *modneo-modeline-append*
:ModelineAppend[!]     Appends the modeline if missing. If bang is present a
                       modeline will be added regardless of an existing

                                                   *modneo-modeline-update*
:ModelineUpdate        Replaces existing or appends a new modeline with current
                       settings
```

## Known Issues ⚡

Checks only the last line. Will fail or cause unexpected behaviour
in following situation (which are supported by vim/neovim):

- Last line is an empty line after modeline
- Modeline is at the top of the file. Allowed by spec, but not seen in the wild.

## Contribution 🤜🤛

Rules to be set up
