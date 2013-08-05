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
* Ubuntu Mobile icon theme from the `ubuntu-mobile-icons` package

Currently, there is no module manager, so you will need the KJV Bible SWORD module, which can be installed using another SWORD program's module manager or using the `sword-text-kjv` package. If you want, you can also install the ESV SWORD module from another SWORD program's module manager (this is not available from the Ubuntu repositories).

To run/build, just open the `.pro` file in Qt Creator.
