uBible
======

#### uBible is a Bible application for Ubuntu Touch ####

> All scripture is given by inspiration of God, and is profitable for doctrine, for reproof, for correction, for instruction in righteousness: that the man of God may be perfect, throughly furnished unto all good works.
> [2 Timothy 3:16-17](http://www.biblegateway.com/passage/?search=2%20Timothy%203:16-17&version=KJV)

> For we have not followed cunningly devised fables, when we made known unto you the power and coming of our Lord Jesus Christ, but were eyewitnesses of his majesty. ... knowing this first, that no prophecy of the scripture is of any private interpretation. For the prophecy came not in old time by the will of man: but holy men of God spake as they were moved by the Holy Ghost.
> [2 Peter 1:16,20-21](http://www.biblegateway.com/passage/?search=2%20Peter%201:16-21&version=KJV)

### Building from Source

**You will need the following dependencies:**

* [Ubuntu SDK](http://developer.ubuntu.com/get-started/)
* SWORD library from the `libsword-dev` package
* U1db library from the `qtdeclarative5-u1db-plugin` package
* U1db library in [Trusty] is the `qtdeclarative5-u1db1.0` package
* Ubuntu Mobile icon theme from the `ubuntu-mobile-icons` package
* ubuntu-ui-extras is required from https://github.com/iBeliever/ubuntu-ui-extras. Copy or link this into `app/`
* uData is required from https://github.com/iBeliever/udata. Copy or link this into `app/`

Currently, there is no module manager, so you will need to install Bibles using another SWORD program or from the Ubuntu repositories. For example, the KJV Bible is available from the `sword-text-kjv` package.

To run/build, just open the `CMakeLists.txt` file in Qt Creator.
