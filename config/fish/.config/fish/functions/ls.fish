function ls --wraps='exa -la --color=auto' --wraps='exa -abghHliS' --wraps=exa --description 'alias ls=exa'
    exa $argv
end
