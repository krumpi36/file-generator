#!/bin/bash

# Check '--help' for documentation

# Function to display the formatted documentation using less
show_help() {
    printf "\033[1mNAME\033[0m\n"
    printf "    file-generator.sh - Create files with random content\n\n"

    printf "\033[1mSYNOPSIS\033[0m\n"
    printf "    \033[1mfile-generator.sh\033[0m [\033[4mOPTIONS\033[0m]...\n\n"

    printf "\033[1mDESCRIPTION\033[0m\n"
    printf "    Generates random files with specified options.\n\n"

    printf "\033[1mOPTIONS\033[0m\n"
    printf "    \033[1m-n\033[0m, \033[1m--num-files \033[0m\033[4mNUM\033[0m\n"
    printf "        Specify the number of random files to create (\033[3mdefault: 1000\033[0m)\n\n"

    printf "    \033[1m-s\033[0m, \033[1m--size \033[0m\033[4mSIZE\033[0m\n"
    printf "        Specify the average size in bytes for generated files (\033[3mdefault: 1024\033[0m)\n\n"

    printf "    \033[1m-l\033[0m, \033[1m--log\033[0m\n"
    printf "        Generate a log file named 'generated-files.log' to record file details.\n\n"

    printf "    \033[1m-h\033[0m, \033[1m--help\033[0m\n"
    printf "        Display this \033[4mhelp\033[0m and \033[4mexit\033[0m\n\n"

    printf "\033[1mEXAMPLES\033[0m\n"
    printf "    file-generator.sh -n 5 -s 2048\n"
    printf "        Create 5 random files with average size 2048 bytes.\n\n"

    printf "    file-generator.sh -l\n"
    printf "        Generate files and create a log.\n\n"

    printf "    file-generator.sh --help\n"
    printf "        Display this \033[4mhelp\033[0m documentation.\n\n"

    printf "\033[1mAUTHORS\033[0m\n"
    printf "    Written by Adam Krumpolec.\n\n"

    printf "\033[1mLICENSE\033[0m\n"
    printf "    This program is free software: you can redistribute it and/or modify\n"
    printf "    it under the terms of the GNU General Public License as published by\n"
    printf "    the Free Software Foundation, either version 3 of the License, or\n"
    printf "    (at your option) any later version.\n\n"

    printf "\033[1mSEE ALSO\033[0m\n"
    printf "    The source code for this project is available on GitHub:\n"
    printf "    \033[4mhttps://github.com/krumpi36/file-generator\033[0m\n\n"
}

# Number generated of files
num_files=1000
# Average size of generated of files
avg_size=1024
# Generate a log file if not empty.
log_file=""
# Progress bar values
bar_size=40
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2

# Function to show a progress bar
show_progress() {
    current="$1"
    total="$2"

    # Calculate the progress in percentage
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total")
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100")
    todo=$(bc <<< "scale=0; $bar_size - $done")

    # Build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # Output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}%"

    if [ "$total" -eq "$current" ]; then
        echo ""
    fi
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
    -n | --num-files)
        num_files="$2"
        shift
        ;;
    -s | --size)
        avg_size="$2"
        shift
        ;;
    -l | --log) log_file="generated-files.log" ;;
    -h | --help)
        show_help | less -R
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
    shift
done

# Create directory for generated files
mkdir -p generated-files

# Function to generate random data
generate_random_data() {
    tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "$1"
}

# Create random files
for i in $(seq "$num_files"); do

    filename="generated-files/generated-file-${i}.txt"
    file_size=$((RANDOM % ((avg_size * 2) + 1)))

    generate_random_data "$file_size" > "$filename"

    # Log filename and size
    if [ -n "$log_file" ]; then
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")
        printf "%s  CREATED : %42s : [ %6d ]\n" "$timestamp" "$filename" "$file_size" >> "$log_file"
    fi

    # Show progress bar if generating more than 10 files
    if [ "$num_files" -gt 10 ]; then
        show_progress "$i" "$num_files"
    fi
done

printf "\033[1mDONE\033[0m - $num_files files created in '\033[3mgenerated-files\033[0m' directory\n"

if [ -n "$log_file" ]; then
    printf "     - created '\033[3m$log_file\033[0m'\n"
fi

printf "\n"

exit 0
