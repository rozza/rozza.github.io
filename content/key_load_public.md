+++
Categories = ["github", "tech", "ssh", "osx"]
Description = "Get 'key_load_public: invalid format' after upgrading to El Capitan?"
Tags = ["github", "tech", "ssh", "osx"]
date = "2015-11-20T12:06:46Z"
title = "El Capitan and key_load_public: invalid format"
+++

I upgraded to El Capitan on my Mac and it all went smoothly apart from one hitch. When pulling or pushing to Github I would get the following error: `key_load_public: invalid format`.  Everything worked but opaque error messages are annoying.  

I tried googling and all I found was this  [article](http://rcmdnk.github.io/blog/2015/10/09/computer-github-mac/). It seemed to solve the issue but I didn't like the solution, mainly because it didn't help me understand the problem! So I persevered and *ignored the message*, until it became too annoying.

After more investigation it turns out it was caused by my public key: `~/.ssh/id_rsa.pub`, somehow it been corrupted during the upgrade. The good news is you can regenerate it easy enough with `ssh-keygen` like so:

```
  ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub
```

And now I don't get `key_load_public: invalid format` messages anymore. Happy days.
