#sudo apt-get install sox || brew install sox
d4='play -q -n synth 0.1 sin 293.66'
d5='play -q -n synth 0.1 sin 587.33'
a4='play -q -n synth 0.1 sin 440'
gs4='play -q -n synth 0.1 sin 415.30'
g4='play -q -n synth 0.1 sin 392'
f4_long='play -q -n synth 0.2 sin 349.23'
f4='play -q -n synth 0.1 sin 349.23'

shortBeep='play -q -n synth 0.1 sin 880'
longBeep='play -q -n synth 0.5 sin 420'
okayBeep='play -q -n synth 0.1 sin 560'
lowBeep='play -q -n synth 2 sin 493.88'


echo 'testing'

$d4 && $d4 && $d5 && sleep 0.1 && $a4 && sleep 0.2
$gs4 && sleep 0.1 && $g4 && sleep 0.1 && $f4_long && $d4 && $f4 && $g4

sleep 1 && clear
echo 'ready!'
sleep 1 && clear