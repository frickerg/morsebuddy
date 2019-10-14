#sudo apt-get install sox || brew install sox

function synthbeep {
	if [ -z "$2" ]
	then
		play -q -n synth 0.1 sin $1
	else
		play -q -n synth $1 sin $2
	fi
}

d4='synthbeep 293.66'
d5='synthbeep 587.33'
a4='synthbeep 440'
gs4='synthbeep 415.30'
g4='synthbeep 392'
f4_long='synthbeep 0.2 349.23'
f4='synthbeep 349.23'

shortBeep='synthbeep 0.1 880'
longBeep='synthbeep 0.5 420'

echo 'testing'

# play testing sound
$d4 && $d4 && $d5 && sleep 0.1 && $a4 && sleep 0.2
$gs4 && sleep 0.1 && $g4 && sleep 0.1 && $f4_long && $d4 && $f4 && $g4

clear
echo 'ready!'
sleep 1 && clear
