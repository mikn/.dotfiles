if test (tty) = '/dev/tty2' -a $USER != root -a ! -e /tmp/.X0-lock
    startx
    exit
end
eval (direnv hook fish)
status --is-interactive; and source (pyenv init -|psub) and source (pyenv virtualenv-init -|psub)
