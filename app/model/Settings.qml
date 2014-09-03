import QtQuick 2.0
import uBible 1.0

import "../udata"

Document {
    id: settings

    _type: "Settings"
    _id: "settings"

    _properties: [
        "showStrongs", "showReadingPlan",
        "bibleVersion", "bookmarks",
        "history"
    ]

    property bool showStrongs: false
    property bool showReadingPlan: true
    property string bibleVersion
    property var bookmarks: []
    property var history: []

    onBibleVersionChanged: {
        print("New version!")
        internalBible.name = bibleVersion
    }

    onLoaded: {
        print("Bible: ", bibleVersion, JSON.stringify(internalBible.availableBibles()))
        if (!bibleVersion === "" && !containsBible(bibleVersion)) {
            if (internalBible.availableBibles().length > 0)
                bibleVersion = internalBible.availableBibles()[0].name
            else
                bibleVersion = ""
        } else if (bibleVersion === "" && internalBible.availableBibles().length > 0) {
            bibleVersion = internalBible.availableBibles()[0].name
        }

        print("Setting bible version", bibleVersion)
        internalBible.name = bibleVersion
    }

    function containsBible(name) {
        for (var i = 0; i < internalBible.availableBibles().length; i++) {
            var bibleInfo = internalBible.availableBibles()[i]

            if (bibleInfo.name == name)
                return true
        }

        return false
    }

    property Bible bible

    Bible {
        id: internalBible
        onNameChanged: {
            print("Name changed:", name)
            bible = null
            bible = internalBible
        }
    }
}
