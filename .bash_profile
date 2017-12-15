if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

source ~/local/bin/activate

HISTSIZE=

export GREP_COLOR='1;37;41'
# aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias infomart-ansible="AWS_PROFILE=infomart ansible-playbook --private-key=~/.ssh/id_rsa --vault-password=~/.ansible/infomart-vault.txt -i inventory/aws_dynamic_inventory.py"
alias postmedia-ansible="ANSIBLE_CONFIG=ansible.cfg ../scripts/get-credentials.py pdsandbox ansible-playbook -i inventory/ec2.py --private-key=~/.ssh/id_rsa --vault-password=~/.ansible/pmdigital-stage-vault.txt"
alias stage-postmedia-ansible="ANSIBLE_CONFIG=stage-pmd-ansible.cfg ../scripts/get-credentials.py stage ansible-playbook -i inventory/ec2.py --private-key=~/.ssh/id_rsa --vault-password=~/.ansible/pmdigital-stage-vault.txt"
alias prod-postmedia-ansible="ANSIBLE_CONFIG=prod-pmd-ansible.cfg ../scripts/get-credentials.py prod ansible-playbook -i inventory/ec2.py --private-key=~/.ssh/id_rsa --vault-password=~/.ansible/pmdigital-prod-vault.txt"
alias stage-ssh="/Users/pedler/Documents/git/postmedia-infrastructure/scripts/get-credentials.py stage /Users/pedler/Documents/git/postmedia-infrastructure/scripts/ssh-jump"
alias prod-ssh="/Users/pedler/Documents/git/postmedia-infrastructure/scripts/get-credentials.py prod /Users/pedler/Documents/git/postmedia-infrastructure/scripts/ssh-jump"
alias composer="php /usr/local/bin/composer.phar"

# GO environment
export GOPATH=$HOME/Documents/go_work

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

complete -C '/usr/local/bin/aws_completer' aws

function ec2-info()
{
  aws ec2 describe-instances --filters 'Name=tag:Name,Values='$1 --output text --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value | [0], State.Name, InstanceId, PrivateIpAddress]'
}

# Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

PATH="/Users/pedler/kubernetes:/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
