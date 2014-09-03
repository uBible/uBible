uBible
======

#### uBible is a Bible application for Ubuntu Touch ####

> All scripture is given by inspiration of God, and is profitable for doctrine, for reproof, for correction, for instruction in righteousness: that the man of God may be perfect, throughly furnished unto all good works.
> [2 Timothy 3:16-17](http://www.biblegateway.com/passage/?search=2%20Timothy%203:16-17&version=KJV)

> For we have not followed cunningly devised fables, when we made known unto you the power and coming of our Lord Jesus Christ, but were eyewitnesses of his majesty. ... knowing this first, that no prophecy of the scripture is of any private interpretation. For the prophecy came not in old time by the will of man: but holy men of God spake as they were moved by the Holy Ghost.
> [2 Peter 1:16,20-21](http://www.biblegateway.com/passage/?search=2%20Peter%201:16-21&version=KJV)

### Building from Source

To build uBible from source, you need to be on Ubuntu 14.10 to get the latest and great Ubuntu SDK. The SDK team is not updating 14.04 with the latest Ubuntu SDK.

**You will need the following dependencies:**

* [Ubuntu SDK](http://developer.ubuntu.com/get-started/)
* SWORD library from the `libsword-dev` package
* Suru icon theme from the `suru-icon-theme` package

uBible no longer uses U1db, as we are using [uData](https://github.com/sonrisesoftware/udata) for a stronly-typed persistent storage framework.

**Submodule Dependencies**

In addition to the above packages, uBible requires several GitHub libraries, which are referenced as Git Submodules. If you're unfamiliar with how submodules work, check out [the chapter of the Git book on submodules](http://git-scm.com/book/en/Git-Tools-Submodules). Basically, check out the Taskly repository, then run

    git submodule init

Now, any time you do a `git pull` in the uBible repository, and you see a change to the files `udata`, `qml-extras`, or `ubuntu-ui-extras`, that means the versions of those submodules have been changed. Now, you need to update the submodules using this command:

    git submodule update


Currently, there is no module manager, so you will need to install Bibles using another SWORD program or from the Ubuntu repositories. For example, the KJV Bible is available from the `sword-text-kjv` package.

To run/build, just open the `CMakeLists.txt` file in Qt Creator.
