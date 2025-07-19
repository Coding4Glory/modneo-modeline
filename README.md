# tiny.nvim modeline

A simple plugin to add and update modelines

## Setup 🚀 and Configuration ⚙

Setup with Lazy

```lua
return { "Coding4Glory/tiny-modeline.nvim",
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
    } 
}
```

<!-- panvimdoc-ignore-start -->

## Commands ⌨

- `:ModelineAppend[!]`: appens the mode line if missing. If bang is present a modeline will be added regardless of existing regarless of existing
- `:ModelineUpdate`: replaces exising or appends a new modline

<!-- panvimdoc-ignore-end -->

<!-- panvimdoc-include-comment

:ModelineAppend[!]

: Appends the modeline if missing.
If bang is present a modeline will be added regardless of existing

:ModelineUpdate

: Replaces existing or appends a new modeline with current settings

-->

## Contribution 🤜🤛

There is not really somthing to add, but maybe something to optimize or fix. If you think you found something, you might add a PR. But don't be sad if it's not accepted. The module is meant be tiny 😉.

