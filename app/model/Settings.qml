import QtQuick 2.0
import uBible 1.0

import "../udata"

Document {
    id: settings

    _type: "Settings"
    _id: "settings"

    _properties: [
        "showStrongs", "showRecent",
        "theme", "bibleVersion", "bookmarks",
        "showVerse", "showReadingPlan"
    ]

    property bool showStrongs: false
    property bool showRecent: true
    property string theme: "Suru"
    property string bibleVersion
    property var bookmarks: []
    property bool showVerse: true
    property bool showReadingPlan: true

    onLoaded: {
        print("Bible: ", bibleVersion, JSON.stringify(bible.availableBibles()))
        if (!bibleVersion === "" && bible.availableBibles().indexOf(bibleVersion) === -1) {
            if (App.availableBibles().length > 0)
                bibleVersion = bible.availableBibles()[0]
            else
                bibleVersion = ""
        } else if (bibleVersion === "" && bible.availableBibles().length > 0) {
            bibleVersion = bible.availableBibles()[0]
        }
    }

    property Bible bible: Bible {
        onNameChanged: print("Name changed:", name)
    }
}
