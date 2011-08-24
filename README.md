# next_background
This gem is to offer a WM agnostic solution to changing the wallpaper, either via CLI or daemon.

Usage
=====

Installation
------------
Currently, I don't have it producing a gem, though you can create one if you know how:) 

As such, just to **clone** do this:

```
git clone https://erniebrodeur@github.com/erniebrodeur/next_background.git
```
To generate a **config** file run it one time, this also **changes**:

```
next_background\bin\next_background -r
```

After that you can edit the config file in *~/.config/next_background/config.yaml* to change the settings you see.  The mask is the **GLOB** pattern you want to use to find images.  It will not choke on non-images so you do not need to worry about that.

Want it to run in **daemon** mode?

```
next_background\bin\next_background -d
```

Why isn't it changing your background?  
Make sure to **change** xfce4 to point to the **link** file for its desktop, all this app does is update link file.  You have to configure the WM to use it as the background.

Notes
=====
At the moment this script has some severe limitations:

* Limited command line options.
* Very limited configuration
* Only works on XFCE4
* Only selects images that match a 16:9 ratio.
* Changes every 10 seconds for that oh so ADHD feeling.

Current
=======
I am happy to say that in theory, this could work for you just fine. Given you run xfce4 and use a 16:9 monitor.  With that said, it should work juuuusst fine;) .

The Road map
============
I hate version numbers, they never work for me.  This is a short list of the major points I want to add before I consider this project 'public' worthy.  This is a short list of things I think need to be done before this is ready for public consumption.

* Mulltiple Monitor (dual and triple)
* Multiple WM's supported by a plugin model(this,in theory should allow it to work on Mac and Win with min work).
* Proper documentation and specs

Copyright
=========
Copyright (c) 2011 Ernie Brodeur. See LICENSE.txt for further details, but think open source through and through.
