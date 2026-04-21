# ToggleSprint script

Disclaimer: I'm not a modder, I'm just a developer and I never shared anything, I just do little things for myself like this little mod here. I wanted the feature of walking by pressing a button and not having to keep that button pressed at all times. Also, I kinda really hope this thing isn't in the game already so I didn't work for nothing!

![Example Gif](https://i.imgur.com/NbJ2o5T.gif)

## Description

This mod it's just a little lua script (so you will need [UE4SS](https://www.nexusmods.com/windrose/mods/43) for it to work) that modifies the player's sprint mechanic. If you hit the assigned key, the player will keep running until either he stops or you press the sprint key again. You can also keep the button pressed to make it work as default (hold to sprint). The hotkey is configurable in the game menu, it's the "sprint" key. Default is "Left Shift".

Also, I hope this is a temporary workaround until the game dev add this funcionality to the game.

## Requirements

As I said, the only hard-requirement is [UE4SS](https://www.nexusmods.com/windrose/mods/43).

## Installation

After installing UE4SS, you need to:

1. unzip **ToggleSprint.zip** to the "Mods" folder

After that, you should be good to go.

Recap of the folder structures that you should have: 
- **\*Game root\*/R5/Binaries/Win64/Mods/ToggleSprint/Scripts/main.lua**
- **\*Game root\*/R5/Binaries/Win64/Mods/ToggleSprint/enabled.txt**

## Known Bug

- Not really a bug, but I didn't implement or test the online compatibility of the mod. I don't know if it works online

Feel free to suggest, edit and improve the mod and I hope that it works for you