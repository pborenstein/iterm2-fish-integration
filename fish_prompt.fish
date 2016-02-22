#  Example fish_prompt with iterm_shell_integration

iterm_shell_integration

function fish_prompt -d "Write out the prompt"
  set last_status $status
  iterm2_status $last_status

  iterm2_prompt_start

  function iterm2_print_user_vars
    iterm2_set_user_var curDir (echo $PWD | sed -e "s|^$HOME|~|")
  end

  printf '%s@%s%s%s%s> ' (whoami) (hostname | cut -d . -f 1) \
      (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)

  iterm2_prompt_end

end
