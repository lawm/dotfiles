# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# starting ssh-agent will overwrite SSH_AUTH_SOCK with random path
# on creating tmux session, link will be created
# new windows will use static path
# reattached session/windows will work they use static path and ssh-agent
#   stays alive
sock=/tmp/ssh-auth-sock-$USER
if [ ! -e "$SSH_AUTH_SOCK" ]; then
    # if linked file doesn't exist, delete link
    rm -f "SSH_AUTH_SOCK"
fi
if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" $sock
fi
export SSH_AUTH_SOCK=$sock
