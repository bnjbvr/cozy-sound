# Description

Cozy-sound is a music player working on [Cozy](http://cozy.io) with the API [SoundManager2](http://www.schillmania.com/projects/soundmanager2/).
It's based on [Cozy-music](https://github.com/rdubigny/cozy-music) originally created by [Rdubigny](https://github.com/rdubigny) but no more maintain.

It's a student work, for fun so don't be too hard.

# Main Releases

### V-0.1
- Move from Compound to Americano to fit with the actual Cozy needs
- Restructuring of most files to fit with the Cozy template structure
- Move from jugglingDb to Cozydb (CouchDb)
- Redo the youtube button, now that's work!
- Redo playlist system
- Localization


# Run

Clone this repository, install dependencies and run server (it requires Node.js
and Coffee-script)

    npm install -g coffee-script
    git clone https://github.com/Peltoche/cozy-sound
    cd cozy-sound
    npm install
    coffee server.coffee

If you want to build the application, be sure client side dependencies are installed

    cd client && npm install && cd ..

Check the `Cakefile` for more information.

# Todo

- Redo some parts of Css
- Add multiple select with Ctrl
- Add multiple select with Tab
- Redo broadcast
- Manage video
- ...

# Contribute

- If you have some times, juste read few lines and leave a comment or a trick, all feedback/question/comment/tip are welcome
- Report all issues
- Pick up an [issue](https://github.com/Peltoche/cozy-sound/issues) and solve it.
- Translate (English too, I'm french and I have a really bad english)
- **Any Front-developper is welcome!**

# What is Cozy?

![Cozy Logo](https://raw.github.com/mycozycloud/cozy-setup/gh-pages/assets/images/happycloud.png)

[Cozy](http://cozy.io) is a platform that brings all your web services in the
same private space.  With it, your web apps and your devices can share data
easily, providing you
with a new experience. You can install Cozy on your own hardware where no one
profiles you. You install only the applications you want. You can build your
own one too.

## Community 

You can reach the Cozy community via various support:

* IRC #cozycloud on irc.freenode.net
* Post on our [Forum](https://groups.google.com/forum/?fromgroups#!forum/cozy-cloud)
* Post issues on the [Github repos](https://github.com/mycozycloud/)
* Via [Twitter](http://twitter.com/mycozycloud)
