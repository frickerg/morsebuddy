
#!/bin/bash
# author: frickerg

# update dependencies
# sudo apt-get install sox || brew install sox

# execute script in the project folder
cd "$(dirname "$0")"

# define text variables
banner[0]="+-----------------------------------------------------------------------------+"
banner[1]="|                                                                             |"
banner[2]="| ███╗  ███╗ █████╗ █████╗ █████╗██████╗█████╗ ██╗  ██╗█████╗ █████╗ ██╗   ██╗|"
banner[3]="| ████╗████║██╔══██╗██╔═██╗██╔══╝██╔═══╝██╔═██╗██║  ██║██╔═██╗██╔═██╗╚██╗ ██╔╝|"
banner[4]="| ██╔███╔██║██║  ██║█████╔╝█████╗████╗  █████╔╝██║  ██║██║ ██║██║ ██║ ╚████╔╝ |"
banner[5]="| ██║╚█╔╝██║██║  ██║██╔═██╗╚══██║██╔═╝  ██╔═██╗██║  ██║██║ ██║██║ ██║  ╚██╔╝  |"
banner[6]="| ██║ ╚╝ ██║╚█████╔╝██║ ██║█████║██████╗█████╔╝╚█████╔╝█████╔╝█████╔╝   ██║   |"
banner[7]="| ╚═╝    ╚═╝ ╚════╝ ╚═╝ ╚═╝╚════╝╚═════╝╚════╝  ╚════╝ ╚════╝ ╚════╝    ╚═╝   |"
banner[8]="+-------------------------------+-----------------------------+---------------+"
banner[9]="|  Developed by G. Fricker      |       Follow me on GitHub:  |   @frickerg   |"
banner[10]="+-------------------------------+-----------------------------+---------------+"

function banner {
	for i in "${banner[@]}"
	do
		echo "$i"
		sleep 0.1
	done
}

# read resource file to know the morse alphabet
while read -r line; do declare  "morse_$line"; done <alphabet.res

# plays a tune on the sound card
# param $1: frequency
# param $2: duration (optional)
function synthbeep {
	if [ -z "$2" ]
	then
		play -q -n synth 0.1 $mode $1
	else
		play -q -n synth $2 $mode $1
	fi
}

# define the notes for the intro song
d4='synthbeep 293.66'
d5='synthbeep 587.33'
a4='synthbeep 440'
gs4='synthbeep 415.30'
g4='synthbeep 392'
f4_long='synthbeep 349.23 0.2'
f4='synthbeep 349.23'

# define the notes for the morse sounds
shortBeep='synthbeep 880'
longBeep='synthbeep 420 0.5'

# set synth mode to triangle
mode=triangle
clear
sleep 0.2

# play intro song and display banner
banner & ($d4 && $d4 && $d5 && sleep 0.1 && $a4 && sleep 0.2 && $gs4 && sleep 0.1 && $g4 && sleep 0.1 && $f4_long && $d4 && $f4 && $g4)
sleep 1
echo 'ready to go!'

# set synth mode to sinus
mode=sin

function decode {
	local var="morse_$1"
	local decode_letter="${!var}"
	for (( j=0; j<${#decode_letter}; j++ ))
	do
		if [[ ${decode_letter:$j:1} == "." ]]
		then
			$shortBeep
			echo -n "."
		else
			$longBeep
			echo -n "-"
		fi
	done
}

while [[ $userinput != "exit" ]];
do
	read -p 'Enter your text message: ' userinput
	for (( i=0; i<${#userinput}; i++ )); do
		current_letter=${userinput:$i:1}
		decode $current_letter
		if [[ "$current_letter" == " " ]]
		then
			echo -n "/"
		fi
		echo -n " "
		sleep 1
	done
	echo "//"
done
