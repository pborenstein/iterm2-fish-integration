# Taken from .iterm2_shell_integration.fish
# see: https://www.iterm2.com/shell_integration.html
  set iterm2_hostname (hostname -f)

# If hostname -f is slow for you, set iterm2_hostname before sourcing this script
if not set -q iterm2_hostname
  set iterm2_hostname (hostname -f)
end




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
      printf "\033]1337;SetUserVar=%s=%s\007" "$argv[1]" (printf "%s" "$argv[2]" | base64)
    end

    # Users can override this.
    # It should call iterm2_set_user_var and produce no other output.
    function iterm2_print_user_vars
    end

    # iTerm2 inform terminal that command starts here
    function iterm2_precmd
      printf "\033]1337;RemoteHost=%s@%s\007\033]1337;CurrentDir=$PWD\007" $USER $iterm2_hostname
      iterm2_print_user_vars
    end

    function -v _ underscore_change
      if [ x$_ != xfish ]
        iterm2_preexec
      end
    end

    iterm2_precmd
    printf "\033]1337;ShellIntegrationVersion=2;shell=fish\007"

 function -e fish_prompt foo_prop
      iterm2_precmd
  end

function iterm_shell_integration
end

