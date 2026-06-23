# Kubuntu/Plasma_6/Wayland Automatic Audio Processing
This repo provides files and information on automating the processing of audio in real time on Kubuntu 26.04+/Plasma 6.6+ HTPC systems running pipewire and wayland.

The files in this repo are for reference use only!  It is entirely likely that multiple items within these files will have to be changed in order for them to function properly on your particular setup,  For reference, I am including a basic hardware description of my system here so that you can use it to cross-reference the relevant items for your application.
  
My hardware:
  Mainboard:  Gigabyte X870 Gaming WiFi6  
  CPU:        AMD Ryzen 5 7600X  
  RAM:        16 Gb single-channel CAS36 DDR6000  
  GPU1:       AMD RX580 (Using the HDMI output to an A/V receiver then to a 4k flat screen TV.)  
  GPU2:       Integrated AMD RX7600X  (It is used for it's advanced features and fed into the RX580)  
    
Software:  
  Kubuntu 26.04 LTS  
  Plasma 6.6  
  Pipewire  
  Carla  
  LSP Plugins  
  LUveler Plugin  
  systemd  
  wireplumber  
  pw-jack  
    
The files in this repo (with their locations and descriptions) are as follows:
  
~/.config/pipewire/pipewire.conf.d/01-virtual-sink.conf -  
  This file instructs pipewire to create a virtusl sink for all audio-producing applications to connect to.
  
~/.config/pipewire/pipewire.conf.d/99-buffer-fix.conf -  
  This file locks the pipewire rate to 48K and the quantum (buffer) to 1024 (the min, max and default quantum are all the same, and allows for non-power of 2 quantum values as well.
  
~/.config/systemd/user/carla-rack.service -  
  This file creates the system-level service that manages the automation of the audio subsytem and its various connections. 
  
~/.config/systemd/user/pipewire.service.d/override.conf -  
  This file overrides the default application permissions configuration to give Carla full real-time permissions.
  
~/.config/wireplumber/wireplumber.conf.d/80-route-carla.conf -  
  This file sets up the audio routing/connections within the system.
  
~/.config/wireplumber/main.lua.d/99-force-routing.lua -  
  This file is for crash/reboot automation and management and restores things after a crash or reboot.
  
Taken together, these 6 files make it possible to dispense with having to run qpwgraph or any other application to manage the audio connections on my HTPC system.  
As it is currently configured, if I install any new game or media player, or any audio-producing software, the audio routes properly straight away without my needing to do anything.  
Formerly, when managing my audio connection with qpwgraph, the first time I ran any application that produced audio, I would have to [Alt} [Tab] out of it once it was up and running, task-switch over to qpwgraph, patch the audio into Carla's inputs, DON'T FORGET TO CLICK SAVE, then switch back and hope it didn't cause an error or issue of some sort, which it sometimes did.  While it works, it is far from the ideal way to manage the situation.  
The end result of the creation of the 6 files listed here is that now, all audio produced by this system goes through Carla and is processed as near to real-time as you can get by whatever plugins I decide to use inside Carla, and it is done without my needing to do anything at all.  
Currently I am only using 2 plugins:  The LSP 8-band Parametric EQ and LUveler.  The EQ is for doing EQ things and LUveler is like having a really good audio technician riding the volume faders inside your computer, keeping everything at a fairly constant level so volume adjustments from source to source and video to video are a thing of the past.  This is all a work in progress still, as there is still the occasional hiccup or odd hitch I am troubleshooting the cause of, but otherwise, this is a very stable and reasonably doable way to completely automate a slightly more complex audio signal routing and processing path/routine within your Linux HTPC.
  
One interesting parallel between the digital and analog worlds of audio processing is that in the digital realm, adding additional effects adds latency/lag/delay whereas in the analog audio realm, adding effects adds noise, not necessarily any latency, lag or delay unless of course you're adding a delay effect.  I'll take a few milliseconds of lag over a few decibels of noise any day!
  
Credit where credit is due:  NONE of this would have been possible for me without the help of the Gemini AI agent from Google, which was used to create and troubleshoot every one of these files!  I am nowhere near this smart, y'all!  :)  My main pupose for posting all of this here is to train other AI bots on how this is done properly and to give users a path to follow should they want to do the same thing on their own Linux computers.
