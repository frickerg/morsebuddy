# morsebuddy

```
+-----------------------------------------------------------------------------+
|                                                                             |
| ███╗  ███╗ █████╗ █████╗ █████╗██████╗█████╗ ██╗  ██╗█████╗ █████╗ ██╗   ██╗|
| ████╗████║██╔══██╗██╔═██╗██╔══╝██╔═══╝██╔═██╗██║  ██║██╔═██╗██╔═██╗╚██╗ ██╔╝|
| ██╔███╔██║██║  ██║█████╔╝█████╗████╗  █████╔╝██║  ██║██║ ██║██║ ██║ ╚████╔╝ |
| ██║╚█╔╝██║██║  ██║██╔═██╗╚══██║██╔═╝  ██╔═██╗██║  ██║██║ ██║██║ ██║  ╚██╔╝  |
| ██║ ╚╝ ██║╚█████╔╝██║ ██║█████║██████╗█████╔╝╚█████╔╝█████╔╝█████╔╝   ██║   |
| ╚═╝    ╚═╝ ╚════╝ ╚═╝ ╚═╝╚════╝╚═════╝╚════╝  ╚════╝ ╚════╝ ╚════╝    ╚═╝   |
+-------------------------------+-----------------------------+---------------+
|  Developed by G. Fricker      |       Follow me on GitHub:  |   @frickerg   |
+-------------------------------+-----------------------------+---------------+
```

A simple shell script which converts text into beeping morse code

## How it works

Morse Code was developed in the 1830’s by Samuel Morse. It was developed to enable communication over long distances via a telegraph. It can be transmitted via sound, like on a telegraph, or with light, such asusing lanternson ships.

Morse Code itself is a simple substitution cipher. The code consists of two components: dots and dashes. Each letter of the alphabetand the numbers 0 through 9 havea unique combination of these dots and dashes. For example, A is one dot followed by one dash, which we would write as `.-`

Morse Code, however, is usually represented visually with lights (such as on ships) or audibly (with a telegraph or other device, such as a buzzer). Dots are represented by short bursts of light or sound and dashes are represented by long bursts of light/sound. When transmitting messages, you need to leave a short pause between letters and a longer pause between words.

Whomever is receiving the message will write down the dots and dashes as the transmitter sends them and leave small spaces between letters and slashes between words. Once the transmission is complete, the message can be deciphered with the help of a table, if necessary.

Morsebuddy comes in handy to easily translate your texts into that old school morse code. Just write down your message in full text (only supports lower-case, do not capitalize your letters) and morsebuddy will translate it into morse code. Some special characters are supported. If you activate your soundcard using sox, morsebuddy will also play the morse sound corresponding to the letters in your text message!

*May the morse be with you.*

## Prerequisites

Morsebuddy has been tested on Mac OS Catalina as well as on Linux Mint 18. If you want to update the sox driver automatically, a preinstalled apt or brew package manager is mandatory. You can also update sox in other UNIX based distros by installing sox manually over your own package manager.

The sox package is not mandatory to run the program, but the auditive feedback you get with it makes the program infinite times more fun and is therefore dearly recommended!

Please be advised that this package targets on`!/bin/bash` but should also work on `!/bin/sh`. If you are facing any difficulties when executing the program with`sh buddy.sh` just make sure to execute it with `bash buddy.sh` instead.

Always run the program in your terminal. Navigating to the project directory is not necessary, you can run the script from anywhere. Turn your speakers on if you wanna have a good time.

## Parameters

You can trigger different behavior in morsebuddy with two additional parameters:

- `--mute` deactivates the use of sound and therefore makes no use of the external sox package

- `--update` automatically updates the sox package over brew or apt (might require root privilege)

Only a single parameter can be used at once, you cannot use both params simultaneously. The default behavior (no params) will use the sox driver but does not install it automatically.

## Credits

Developed by Guillaume Fricker in 2019 for the course **BTI7542 - Modern Linux** at the Bern University of Applied Sciences to get in touch with bash scripting. This program should only be used for educational purposes and does not guarantee full accuracy of information provided by its content. Should not be used for military purposes, but that's up to you ;-)
