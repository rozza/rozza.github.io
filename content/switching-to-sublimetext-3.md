---
title: "Switching to Sublime Text 3"
date:  "2013-07-31"
comments: true
categories: [ide, sublime, tech]
aliases:
    - /2013/07/switching-to-sublimetext-3/
    - /posts/switching-to-sublimetext-3/  
---

For a long while I've been a huge fan of [Sublime Text 2](http://www.sublimetext.com/),
its easy to use and has a wealth of features that can be installed by the
awesome [package control](http://wbond.net/sublime_packages/package_control)
system. I use it for all python development and any adhoc file work, infact I
only abandon it for my scala work - where IntelliJ wins.

Sublime Text 3 (ST3) has been in beta for six months, and over that time its
plugin ecosystem has matured.  After experiencing some slow downs in
Sublime Text 2 (ST2) I thought it was time to upgrade to an even more
sublime experience.

## 5 step migration to Sublime Text 3

First off there is **no risk** in trying to upgrade, it has a different app
name to ST2 and its configurations are in a different directory. In short you
can have both installed and living happily.

### 1. Can I upgrade?

<!--more-->

Goto the awesome [Can I Switch To Sublime Text 3?](http://www.caniswitchtosublimetext3.com/)
website and check your packages.  Its probably not a goer if your most used
plugin doesn't work in ST3, but do check out alternatives as many packages
have already been updated and do now work with ST3.  My results were as
follows:

<p class="text-center">
<img src="/images/ready_for_sublime.png">
</p>

I had one fail but when looking at the package reposititory it suggested an
ST3 alternative for a python code intel tool that would work (SublimeJEDI) -
so I was good to go.


### 2. Install package control and packages

Its easy to install package control, just checkout the
[instructions](http://wbond.net/sublime_packages/package_control/installation#ST3).
Once installed, open package control and install all the green packages
mentioned on the can I switch website.

Don't be tempted to use package control for the yellow packages - as it will
install the ST2 versions which won't work.  Instead you will need to
manually install - this usually is simple and only involves cloning the
plugin repository into your packages directory and then checking out an
ST3 compatible branch.  Its no real hardship - so go for it.

### 3. Migrate settings

Once all the packages are installed, its time to get ST3 as comfy as you had
ST2.  To do this copy and paste your user settings from:
`Preferences -> Settings -> User`.

Then copy any language specific settings and snippets you have from the User
directory of ST2 into the User directory of ST3 eg:

    cp ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Python.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Python.sublime-settings

### 4. Update the subl helper:

Remove / rename any symlinked helpers then:

    sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/bin/subl

### 5. Profit!

Easy eh?  You now have ST3 configured as you are used to and if anything
is buggy (*it is still in a beta*) you can easily switch back to ST2.

My initial impressions are its ***much faster*** and I haven't hit any bugs yet,
so I'm a happy bunny. But if you need more convincing - heres some extra reasons
to make the switch:

  * Speed.
    Startup time, file load time, and Replace All have all been
    significantly improved.

  * Improved Project and Pane management.
    Working with multiple panes is now more efficient, with commands to
    create and destroy panes, and quickly move files between panes.  Also
    you can now have multiple workspaces per project.

  * Better Symbol Indexing.
    Allows goto definitions and goto symbol in a project, as well as new
    jump forward and jump back features.

Need some more reasons? Check out the original
[Sublime Text 3 announcement](http://www.sublimetext.com/blog/articles/sublime-text-3-beta).

So if you are on Sublime Text 2 then download Sublime Text 3 and see if
you can make the switch today.
