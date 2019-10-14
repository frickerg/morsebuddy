#sudo apt-get install sox || brew install sox

# read resource file to know the morse alphabet
while read -r line; do declare  "$line"; done <alphabet.res

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

echo 'testing...'

# set synth mode to triangle
mode=triangle

# play testing sound
$d4 && $d4 && $d5 && sleep 0.1 && $a4 && sleep 0.2
$gs4 && sleep 0.1 && $g4 && sleep 0.1 && $f4_long && $d4 && $f4 && $g4

clear
echo 'ready!'
sleep 1 && clear

# set synth mode to sinus
mode=sin

# test morse code
$shortBeep && $longBeep && $longBeep
echo $a