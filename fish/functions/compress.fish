function compress
    set -l dir_name $argv[1]
    tar -czf (string trim -r "/" $dir_name).tar.gz (string trim -r "/" $dir_name)
end
