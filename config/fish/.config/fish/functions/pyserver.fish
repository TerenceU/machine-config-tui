function pyserver --wraps='python -m http.server' --description 'alias pyserver=python -m http.server'
    python -m http.server $argv
end
