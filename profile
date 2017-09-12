# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
	PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.rbenv/bin" ] ; then
	PATH="$HOME/.rbenv/bin:$PATH"
fi

export PYTHONSTARTUP="$HOME/.pythonrc"
export GOPATH="$HOME/gocode"
export ANSIBLE_ROOT="$HOME/xv/sysadmin/Lin/systembuild/parallel-management"

if [ "$TERM" = "linux" ]; then
	. $HOME/bin/base16-oceanicnext.dark.sh
fi

test `tty` = /dev/tty2 -a $USER != root -a ! -e /tmp/.X0-lock && startx && exit
