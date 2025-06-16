# mygit
A git wrapper that adds and extends git's functionality. Intended for use in MacOS, Linux, or WSL.

## Requirements
Some of the commands are github-specific, and require the "gh" command-line tool to be installed to use them.

## Current Commands
All commands can be invoked with `mygit` at the terminal.

### help
Command: `mygit help [COMMAND]`
Provides help on how to use mygit, or a command if passed in.

### clone
Command: `mygit clone [URL]`
Reads in the provided URL parameter and attempts to create a folder named after the org or user that owns the repository you're trying to clone. For example, running `mygit clone https://github.com/google/guava` will create a "google" folder in the current directory, then change into the newly-created directory and pass the URL to `git clone` to clone it as normal. 

### release
GITHUB ONLY.
Command: `mygit release [VERSION_TYPE]
Creates a new GitHub relesae with the contents of the repo's main branch. It will increment the version number of the release by whichever VERSION_TYPE is passed in - "major", "minor", or "patch". The user will be prompted to enter release notes after starting the command.


## Instructions
This repo includes a shell script called `install.sh` that creates a "bin" folder inside your home directory (on Linux and MacOS), then copies the current `mygit` file into the user's personal `bin` folder. Placing the `bin` folder in your home directory ensures you don't need `sudo` or escalated privileges to use `mygit`.

1. Clone the repository, then change directory into it.
2. Ensure the `install.sh` script is executable:
  ```
  chmod +x ./install.sh
  ```
3. Execute the script:
  ```
  ./install.sh
  ```
  The script will copy the `mygit` script into the `bin` directory in your home directory, overwriting any existing files, and ensure the `~/bin` directory is in your PATH.
4. You should now be able to run `mygit` in your terminal. Try `mygit help`.