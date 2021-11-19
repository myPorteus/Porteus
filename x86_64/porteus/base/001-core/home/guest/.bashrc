# Setup color scheme for list call <brokenman>
alias ll='/bin/ls --color=auto -lF'
alias la='/bin/ls --color=auto -axF'
alias ls='/bin/ls --color=auto -xF'

# Append any additional sh scripts found in /etc/profile.d/:
for y in /etc/profile.d/*.sh ; do [ -x $y ] && . $y; done
unset y

# Setup shell prompt for guest <wread and fanthom>
PS1='\[\033[01;36m\]\u@\h:\[\033[01;32m\]\w\$\[\033[00m\] '
PS2='> '
