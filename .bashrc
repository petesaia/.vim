# vim: install module (`vimadd git@github.com:preservim/nerdtree.git nerdtree`)
vimadd() {
	cd ~/
	config submodule add $1 .vim/pack/psaia/start/$2
	config add .gitmodules .vim/pack/psaia/start/$2
	config status
}

# vim: remove module (`vimrm nerdtree`)
vimrm() {
	cd ~/
	config submodule deinit -f .vim/pack/psaia/start/$1
	config rm -f .vim/pack/psaia/start/$1
	config -Rf .git/modules/.vim/pack/psaia/start/$1
	config status
}

# vim: upgrade module
vimup() {
	cd ~/
	config submodule update --recursive
	config status
}

# go: switch go versions using brew
genv() {
	brew install go@$1
	brew unlink go
	brew link go@$1 --overwrite --force
	go version
}

# prompt: branch for prompt
branch_name() {
	branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
	if [[ $branch != "" ]]
	then
		echo ' ['$branch']'
	fi
}

# prompt: format the line
prompt_line() {
	local _GREEN=$(tput setaf 2)
	local _BLUE=$(tput setaf 4)
	local _RED=$(tput setaf 1)
	local _RESET=$(tput sgr0)
	echo "${_BLUE}\W${_RESET}${_GREEN}\$(branch_name)${_RESET} \$ \e[0m"
}

# env
export PS1=$(prompt_line)
export PATH="$HOME/bin:/usr/local/bin:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/work/node_versions/bin:$PATH:$GOBIN"
export PATH="/usr/local/sbin:$PATH"
export GOPATH="$HOME/work/go"
export N_PREFIX="$HOME/work/node_versions"
export CLOUDSDK_PYTHON=python2

# git: dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# direnv: install
eval "$(direnv hook bash)"

# zsh: source things I'd like to keep out of git
if [[ -f "$HOME/.bashrcs" ]]; then
	source $HOME/.bashrcs
fi
