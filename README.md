# iterm2-fish-integration


> **OBSOLETE**
>
> You can use the built-in
> `iterm2_prompt_mark`
> to place the mark glyph
> see **Marks** in the
> iTerm2 [topic on shell integration](https://www.iterm2.com/documentation-shell-integration.html)
>
> so don't use this anymore

[fish shell][fish] functions for iTerm2 v3 Shell Integration

[Why](#why) I did this.

## How to Use

Put `iterm_shell_integration.fish` in your `.config/fish/functions/` directory.

Define the `fish_prompt` function in  `./config/fish/functions/fish_prompt.fish`
like this:


```
#   Call `iterm_shell_integration` _outside_
#   fish_prompt to load the iTerm Shell Integration functions.

iterm_shell_integration

#   Define your `fish_prompt`

function fish_prompt

  #   use iterm2_status to color the marker
  #   of the previous command

  set last_status $status
  iterm2_status $last_status

  #   define and iTerm2 user vars that you want to use
  #   in badges, for instance. This function must be named
  #   iterm2_print_user_vars

  function iterm2_print_user_vars
    iterm2_set_user_var curDir (echo $PWD | sed -e "s|^$HOME|~|")
  end

  #   This is where the command mark will go

  iterm2_prompt_start

  #   The code for your prompt goes here

  #   Mark the end of the prompt

  iterm2_prompt_end
end
```

There's an example `fish_prompt.fish` in this repo.



## Why

[iTerm2 v3][iterm2v3] supports new [Shell Integration][shell_integration] features.
The default method to enable this involves running a script
that creates a `.iterm2_shell_integration.fish` which gets sourced
at the end of your `config.fish`.

`.iterm2_shell_integration.fish` contains a function that wraps
around your `fish_prompt`. It's non-destructive and works pretty well.

Unfortunately for me,
my prompt is three lines long, starting with a blank line (don't judge):

```

philip@ningal: ~/github/iterm2-fish-integration
[master *%=]$ ls
README.md                    iterm_shell_integration.fish
```

I took the utility functions defined in
[`.iterm2_shell_integration.fish`][iterm_fish_fns]
[(`b668459`)](https://github.com/gnachman/iterm2-website/blob/b6684595b61d60064034e04b08b2a7a82339a7e9/source/misc/fish_startup.in)
and put them in `iterm_shell_integration.fish`
so I can use them in my own `fish_prompt`.


[fish]: https://fishshell.com/
[iterm2v3]: https://www.iterm2.com/version3.html
[shell_integration]: https://www.iterm2.com/shell_integration.html
[iterm_fish_fns]: https://iterm2.com/misc/fish_startup.in


