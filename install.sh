#!/bin/bash

# A script to install the 'mygit' custom command.
# This installer is designed for Bash-like environments (Linux, macOS, WSL, Git Bash on Windows).

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration & Colors ---
# Use color codes for better output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'       # No Color (reset)

# The directory where this script is located, to reliably find the mygit file.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
MYGIT_SOURCE_PATH="$SCRIPT_DIR/mygit"

# The destination for the script
INSTALL_DIR="$HOME/bin"
MYGIT_DEST_PATH="$INSTALL_DIR/mygit"

# --- Installation Steps ---

echo -e "${GREEN}Starting mygit installation...${NC}"

# 1. Ensure the ~/bin directory exists.
echo -e "\n${YELLOW}Step 1: Checking for installation directory...${NC}"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${BLUE}Directory '$INSTALL_DIR' already exists.${NC}"
else
    echo -e "${BLUE}Creating directory '$INSTALL_DIR'...${NC}"
    mkdir -p "$INSTALL_DIR"
fi
echo -e "${GREEN}Step 1 complete.${NC}"


# 2. Copy the 'mygit' file to the bin directory.
echo -e "\n${YELLOW}Step 2: Copying mygit script...${NC}"
if [ ! -f "$MYGIT_SOURCE_PATH" ]; then
    echo -e "\033[0;31mError: 'mygit' script not found in the current directory ($SCRIPT_DIR).${NC}"
    echo -e "${BLUE}Please place install.sh in the same directory as the mygit script.${NC}"
    exit 1
fi
# The -f flag forces an overwrite without prompting.
cp -f "$MYGIT_SOURCE_PATH" "$MYGIT_DEST_PATH"
echo -e "${BLUE}Copied 'mygit' to '$MYGIT_DEST_PATH'.${NC}"
echo -e "${GREEN}Step 2 complete.${NC}"


# 3. Make the 'mygit' script executable.
echo -e "\n${YELLOW}Step 3: Setting permissions...${NC}"
chmod +x "$MYGIT_DEST_PATH"
echo -e "${BLUE}Made '$MYGIT_DEST_PATH' executable.${NC}"
echo -e "${GREEN}Step 3 complete.${NC}"


# 4. Ensure ~/bin is in the user's PATH.
echo -e "\n${YELLOW}Step 4: Checking your shell PATH...${NC}"
# Determine the shell configuration file
if [[ "$SHELL" == *"zsh"* ]]; then
    PROFILE_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    PROFILE_FILE="$HOME/.bashrc"
else
    # Fallback for other shells like sh, dash, etc.
    PROFILE_FILE="$HOME/.profile"
fi

echo -e "${BLUE}Your shell configuration file is: ${YELLOW}$PROFILE_FILE${NC}"

# The line we want to add to the profile
PATH_EXPORT_LINE='export PATH="$HOME/bin:$PATH"'

# Check if the line already exists in the profile file
if grep -qF -- "$PATH_EXPORT_LINE" "$PROFILE_FILE"; then
    echo -e "${BLUE}'$INSTALL_DIR' is already in your PATH.${NC}"
    PATH_UPDATED=false
else
    echo -e "${BLUE}Adding '$INSTALL_DIR' to your PATH in '$PROFILE_FILE'...${NC}"
    # Append the line to the file
    echo -e "\n# Add user's local bin directory to PATH for mygit" >> "$PROFILE_FILE"
    echo "$PATH_EXPORT_LINE" >> "$PROFILE_FILE"
    echo -e "${BLUE}PATH updated for future terminal sessions.${NC}"
    PATH_UPDATED=true
fi
echo -e "${GREEN}Step 4 complete.${NC}"


# 5. Final success message and instructions for the current session.
echo -e "\n${GREEN}--- Installation Complete! ---${NC}"
echo -e "${BLUE}The 'mygit' command has been installed.${NC}"

# If we updated the PATH, provide instructions to make it work in the CURRENT terminal.
if [ "$PATH_UPDATED" = true ]; then
    echo -e "\n${YELLOW}To use 'mygit' in your *current* terminal session, please run this command:${NC}"
    echo -e "    source \"$PROFILE_FILE\""
    echo -e "${YELLOW}Or, simply open a new terminal.${NC}"
else
    echo -e "\n${BLUE}You can now use the 'mygit' command.${NC}"
fi