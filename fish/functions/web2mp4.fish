function webm2mp4
    set -l input_file $argv[1]
    set -l output_file (string replace -r '\.webm$' '.mp4' -- $input_file)
    ffmpeg -i "$input_file" -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 192k "$output_file"
end
