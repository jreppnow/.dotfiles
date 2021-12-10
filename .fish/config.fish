if status is-interactive
    # Commands to run in interactive sessions can go here
end

set CMAKE_EXPORT_COMPILE_COMMANDS TRUE

# see https://github.com/ivakyb/fish_ssh_agent
fish_ssh_agent

set -x PATH ~/.bin/ $PATH ~/.cargo/bin/ /snap/bin/ 
