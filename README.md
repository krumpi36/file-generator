# File Generator Script

Shell script for generating files with random content.


## Usage

Run the script `file-generator.sh` with the following command-line options:

- `-n`, `--num-files`: Specify the number of random files to create (default: 1000).
- `-s`, `--size`: Specify the average size in bytes for generated files (default: 1024).
- `-l`, `--log`: Generate a log file named 'generated-files.log' to record file details.
- `-h`, `--help`: Display help documentation and exit.


## Todo List

Here are some potential enhancements and features:

- [ ] Add an option for automatic cleanup of generated files and log files.
- [ ] Add an option for archiving generated files using tar, possibly with compression.
- [ ] Improve the progress bar by adding an estimation of processing time.
- [ ] Implement parallel processing to generate files more efficiently for larger file counts.
- [ ] Enhance the script's error handling and user feedback.
- [ ] Allow users to specify the file name prefix or format for generated files.
- [ ] Add an option for generating specific patterns or formats or Lorem ipsum.
- [ ] . . .

Contributions and ideas are welcome!<br>
Feel free to open an issue or pull request.


## License
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
