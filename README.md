<img align="right" height="256" src="./cheater_logo.png">

# CHEATER
A simple program for printing and managing your own cheat sheets to print in terminal. For those like me, who always forget commands and stuff. Inspired by [tldr](https://tldr.sh/) and [Cheaty](https://github.com/linuxmint/cinnamon-spices-applets/tree/master/cheaty@centurix). Written in Bash.

## ⚡ Quick start

For help and list over all functionality:

`cheat -h`

To print the vim example cheat sheet:

`cheat vim`

To add your own git cheat sheet:

`cheat --add git`

Delete the example tmux cheat sheet:

`cheat --delete tmux`

Edit the vim cheat sheet to add more commands:

`cheat --edit vim` 

## 📥 Install
Download the [latest version](https://github.com/jrgn9/cheater/releases/latest) or use git to clone the repo.

Run the `install.sh` script with sudo to automate the install. The script requires curl and rsync to function. It needs sudo privileges to symlink the program to /usr/local/bin. You can also install it manually.

### 📜 Script install
The script requires rsync and curl to work properly!

Make sure the install script have execution rights, then run it:

```
chmod u+x install.sh

./install.sh
```
### 💪 Manual install
If you want to manually install the program follow these steps:

1. **Create a .cheater directory in /home/$USER:** `mkdir /home/$USER/.cheater`
2. **Copy the contents of the cheater directory with rsync or cp (do not copy the .git directory):** `rsync/cp .* /home/$USER/.cheater`
   **Tip:** rsync allows to exclude directories. Use `rsync --exclude=".git"`
3. **Symlink the cheat program to $PATH. I prefer /usr/local/bin:** `sudo ln -s /home/$USER/.cheater/program_files/cheat /usr/local/bin/cheat`
4. **Give cheat the right permissions:** `sudo chmod u+x /home/$USER/.cheater/program_files/cheat`
5. **Check if it is installed correctly (you might have to restart your shell):** `cheat -h`

## 📝 How to use

`cheat [name]` 

This command prints the cheat sheet in your terminal. For example `cheat vim` will print your vim cheat sheet.

`cheat [option] [name]`

Choose an option (add/edit/delete) and the name of the cheat sheet as a second argument. If you don't provide a name you will be prompted for one.

Add your own cheat sheets by using the `cheater --add` command. This creates and opens the cheat sheet in your default text editor (or nano as fallback).

Edit a cheat sheets by using the `cheater --edit` command. This opens a cheat sheet in your default text editor for editing.

Delete a cheat sheet by using the `cheater --delete` command. This removes a specified cheat sheet.

You can of course also add, delete and edit the files manually by going to the cheat_sheets directory.

**Note:** I don't use file extensions for my cheat sheets. If you do, you have to write the extension as a part of the name when invoking the sheet. For example, neovim.txt needs to be invoked with `cheat --edit neovim.txt`. I recommend not using file extensions.

### 🧰 Options
A list of all the options and a description of what they do. If you don't provide a file name as an argument, you will be prompted for one. 

| Short option | Long option  | Secondary options        | Description                                                                                                                                                                              |
| ------------ | ------------ | ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     [file_name]         |              |                          | No options only name: Prints the cheat sheet with the provided file name |
| \-h          | \--help      |                          | Display help message                                                                                                                                                                     |
| \-a          | \--add       |  [file_name]            | Add a new cheat sheet. Provide name for the cheat. If there are no second argument, you will be prompted for a name |
| \-e          | \--edit    | [file_name]                 | Opens the cheat in your default text editor for editing. |
| \-d          | \--delete      | [file_name]           | Delete a cheat sheet. Provide name for the cheat. If there are no second argument, you will be prompted for a name    |
| \-v          | \--version     |  | Prints version of the program |
|           | \--about     |  | Prints the about page for the program |

## 🚮 Uninstall
I haven't created a script to do the uninstall. However, you simply need to delete the .cheater directory in home and remove the cheat symlink in /usr/local/bin

```
rm -rf /home/$USER/.cheater
rm /usr/local/bin/cheat
```

## 🪪 License and attributions
This project is licensed with [GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.en.html)

[Writing icons created by Smashicons - Flaticon](https://www.flaticon.com/free-icons/writing)

Cheater is made by Jørgen Skontorp.

## ✅ Todo
- Import function (and possibly export/backup to save a copy of the sheets)
