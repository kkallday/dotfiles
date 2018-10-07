#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# terminal preferences
#export PS1='\u@\h:\W$ '
export VISUAL="nvim"
export EDITOR="nvim"

# aliases
alias ll='ls -lah'
alias vim=nvim

# autojump
source /etc/profile.d/autojump.bash

# golang
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"

function init-gpg-agent() {
  # starts the gpg-agent if not already running
  if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
  fi

  # Set SSH to use gpg-agent
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  fi

  # Set GPG TTY
  export GPG_TTY=$(tty)

  # Refresh gpg-agent tty in case user switches into an X session
  gpg-connect-agent updatestartuptty /bye >/dev/null
}

function decrypt-files-in-dir() {
  function decrypt() {
    local path
    path="${1}"

    local dest
    dest="$(echo ${path} | sed s/\.gpg//g)"

    echo $dest
    echo $path
    gpg2 -o "${dest}" -d "${path}"
  }

  find . -name '*.gpg' | while read line; do
    decrypt "${line}"
  done
}
