#!/bin/bash
set -x  # echo on

# ToDoList is software in the category of Task Management, Project Management, Productivity, “Getting Things Done” (GTD), Scheduling, and Collaboration.


function download_and_unzip {
	wget http://abstractspoon.pbwiki.com/f/todolist_exe.zip -P /tmp

	sudo mkdir -p "/opt/todolist_exe"
	sudo chmod a+rw -R "/opt/todolist_exe"

	unzip "/tmp/todolist_exe.zip" -d "/opt/todolist_exe"
	rm "/tmp/todolist_exe.zip"
}


function create_menu_entry {

cat >~/.local/share/applications/ToDoList.desktop <<EOL
[Desktop Entry]
Name=ToDoList
GenericName=ToDoList
Comment=task manager
Exec=wine /opt/todolist_exe/ToDoList.exe
Icon=application-x-wine-extension-tdl
Terminal=false
Type=Application
Categories=Office;Application;
Encoding=UTF-8
Name[en_US]=ToDoList
Comment[en_US]=task management tool
EOL

}


download_and_unzip
create_menu_entry
