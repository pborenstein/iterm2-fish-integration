# Taken from .iterm2_shell_integration.fish
# see: https://www.iterm2.com/shell_integration.html
# this should track https://github.com/gnachman/iterm2-website/blob/master/source/misc/fish_startup.in

set -g -x iterm2_hostname (hostname -f)

function iterm2_status
  printf "\033]133;D;%s\007" $argv
end

# Mark start of prompt
function iterm2_prompt_start
  printf "\033]133;A\007"
end


# Mark end of prompt
function iterm2_prompt_end
  printf "\033]133;B\007"
end


# Tell terminal to create a mark at this location
function iterm2_preexec
  # For other shells we would output status here but we can't do that in fish.
  printf "\033]133;C;\r\007"
end

# Usage: iterm2_set_user_var key value
# These variables show up in badges (and later in other places). For example
# iterm2_set_user_var currentDirectory "$PWD"
# Gives a variable accessible in a badge by \(user.currentDirectory)
# Calls to this go in iterm2_print_user_vars.
function iterm2_set_user_var
  printf "\033]1337;SetUserVar=%s=%s\007" "$argv[1]" (printf "%s" "$argv[2]" | base64 | tr -d "\n")
end

# iTerm2 inform terminal that command starts here
function iterm2_precmd
  printf "\033]1337;RemoteHost=%s@%s\007\033]1337;CurrentDir=$PWD\007" $USER $iterm2_hostname

  # Users can define a function called iterm2_print_user_vars.
  # It should call iterm2_set_user_var and produce no other output.
  if functions -q -- iterm2_print_user_vars
    iterm2_print_user_vars
  end
end

function -v _ underscore_change
  if [ x$_ != xfish ]
    iterm2_preexec
  end
end

iterm2_precmd
printf "\033]1337;ShellIntegrationVersion=3;shell=fish\007"

function -e fish_prompt iterm2_run_precmd
    iterm2_precmd
end

function iterm_shell_integration
end

