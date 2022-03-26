#!/usr/bin/bash

path=$(xdotool getactivewindow getwindowname | awk -F ' —' '{print $1}')
file="Αρχείο κειμένου"
extension=txt
filename="$file.$extension"
a=0
while [[ -f $path/$filename ]]; do
	a=$((a + 1))
	filename="$file ($a).$extension"
done
userfile=$(zenity --entry --entry-text "$filename" --title "Νέο Έγγραφο Κειμένου - Dolphin" --text "Create new file in $path" --width=420 --height=50)
if [[ -f $path/$userfile ]]; then
	zenity --error --title "File exists" --text "Please choose a unique file name" --width=300 --height=50
	exit 1
else
	touch "$path/$userfile"
	exit 0
fi
