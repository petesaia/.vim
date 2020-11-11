export GOPATH=$HOME/work/go
export N_PREFIX=$HOME/work/node_versions
export GOBIN=$GOPATH/bin
export PATH=$HOME/work/node_versions/bin:$PATH:$GOBIN
export GO111MODULE=auto
export GOPRIVATE="github.com/nytimes,github.com/nytm"
export VAULT_ADDR=https://vault-prd.dv.nyt.net
export CLOUDSDK_PYTHON=python2

# Easily switch versions of Go.
sgo() {
  brew install go@$1
  brew unlink go
  brew link go@$1 --overwrite --force
  go version
}

alias k='kubectl'

eval "$(direnv hook zsh)"
