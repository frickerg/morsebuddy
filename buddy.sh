#!/bin/bash
# author: frickerg

# for using the soundcard, sox needs to be installed. If you do not want to use any external packages, use the param --mute when executing the script
# using the param --update will install/update the external packages (optional, but much more fun!)
play_sound="true"
if [ "$1" == "--mute" ];then play_sound="false" && printf "you have chosen to disable the sound function.\nno external packages will be used.\n";fi
if [ "$1" == "--update" ];then echo "updating external packages" && sudo apt-get install sox || brew install sox; fi

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

# animate the banner
function banner {
	for i in "${banner[@]}";do echo "$i" && sleep 0.1;done
}

# read resource file to know the morse alphabet
while read -r line; do declare  "morse_$line"; done <resources/alphabet.res

# detect environment
if [ $(uname) == "Linux" ];then alsa_param="-t alsa";fi

# plays a tune on the sound card
# param $1: frequency, param $2: duration (optional)
function synthbeep {
	if [ $play_sound == "true" ];then
		if [ -z "$2" ];then
			# only use one argument
			play -nq $alsa_param synth 0.1 $mode $1
		else
			# use the second argument as beep length
			play -nq $alsa_param synth $2 $mode $1
		fi
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
shortBeep='synthbeep 880' && longBeep='synthbeep 560 0.5'

# set synth mode to triangle
mode=triangle && clear && sleep 0.2

# play intro song and display banner
banner & ($d4 && $d4 && $d5 && sleep 0.1 && $a4 && sleep 0.2 && $gs4 && sleep 0.1 && $g4 && sleep 0.1 && $f4_long && $d4 && $f4 && $g4)
sleep 1 && printf 'Ready to go, you can exit anytime by simply typing "exit"\nHow does morse work? Check out the PDF in the "manual" folder.\nType in lower case and morsebuddy will translate it into morse code for you!\n\n'
# set synth mode to sinus
mode=sin

# the decoding function to display text in morse code. also plays the beeping sound if sox is installed
function decode {
	character=$1
	if [ ! -z "${character//[!0-9]/}" ];then character=n$character;fi
	if [ "$character" == ")" ];then character="bracket_close";fi
	if [ "$character" == "(" ];then character="bracket_open";fi
	if [ "$character" == ":" ];then character="colon";fi
	if [ "$character" == "," ];then character="comma";fi
	if [ "$character" == "!" ];then character="exclamation_mark";fi
	if [ "$character" == "." ];then character="full_stop";fi
	if [ "$character" == "-" ];then character="hyphen";fi
	if [ "$character" == '"' ];then character="quotation_mark";fi
	if [ "$character" == "?" ];then character="question_mark";fi

	local var="morse_$character"
	local decode_letter="${!var}"
	for (( j=0; j<${#decode_letter}; j++ ));do
		if [[ ${decode_letter:$j:1} == "." ]];then
			$shortBeep && printf "."
		else
			$longBeep && printf "-"
		fi
	done
}

while true;do
	read -p 'Enter your text message: ' userinput
	if [[ $userinput == "exit" ]];then sleep 1 && printf "Thank you and have a --. .-. . .- - day!\n\n" && exit 1;fi
	for (( i=0; i<${#userinput}; i++ ));do
		current_letter=${userinput:$i:1} && decode $current_letter
		if [[ "$current_letter" == " " ]];then printf "/";fi
		printf " " && sleep 1
	done
	printf "\n\n"
done
