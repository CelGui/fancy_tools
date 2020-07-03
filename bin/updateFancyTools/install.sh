#!/bin/bash

function write_to_file
{
    if [[ -r "$2" && -w "$2" ]]
    then
        echo "$1" >> "$2"
        return 0
    else
        return 1
    fi
}

#Creating aliases for the code
path="~/fancy_tools"
line_path="source $path/.aliases"
file=~/.bashrc
#Preventing duplicate lines in .bashrc file
grep -qF -- "$line_path" "$file" || echo "$line_path" >> "$file"

line_path="source $path/fancy_functions.sh"
file=~/.bashrc
grep -qF -- "$line_path" "$file" || echo "$line_path" >> "$file"


if [ $? -ne 0 ]
then
    echo "Unable to write in ~/.bashrc"
else
    echo "Succeed to write PATH to ~/.bashrc"
fi

#Create bin folder if missing
if [[ -d ~/bin ]]; then
    echo "Cannot create bin folder, already exists."
else
    mkdir ~/bin
    echo "Creating bin folder & copying of updateFancyTools in : Successfull"
fi


#Add bin to PATH (Output:Error & Success msg)
#Creating aliases
cd ~/bin
n_path="$(pwd)"
e_path="export PATH=$PATH:$n_path"
bashrc="$(<~/.bashrc)"


#Prevent duplicate lines in .bashrc
if grep -q "$e_path" <<< "$bashrc"; then
        echo "Already add PATH in ~/.bashrc"
else
        echo "export PATH=$PATH:$n_path" >> ~/.bashrc
        echo "Success! (PATH has been added in .bashrc)"
fi

cd ~/src
option="$(ls)"
folder="src"
if [[ "$option" == *"$folder"* ]]; then
        cd src

        list_content="$(ls)"
        repo="$fancy_tools"
        if [[ "$list_content" == *"$repo"* ]]; then
                echo "~/src/fancy_tools already clone"
        else
                git clone --single-branch --branch master https://github.com/CelGui/fancy_tools.git
                echo "fancy_tools clone successfully in ~/src"
        fi

else
        mkdir ~/src
        cd ~/src
        git clone --single-branch --branch master https://github.com/CelGui/fancy_tools.git
        echo "fancy_tools clone successfully in ~/src"
fi


cd ~/bin
cp -r ~/fancy_tools/bin/updateFancyTools ~/bin
chmod +x updateFancyTools
