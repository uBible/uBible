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
        "history",
        "permissionConfirmed"
    ]

    property bool showStrongs: false
    property bool showReadingPlan: true
    property string bibleVersion
    property var bookmarks: []
    property var history: []
    property bool permissionConfirmed

    onPermissionConfirmedChanged: {
        bibleManager.confirmedPermission = permissionConfirmed
    }

    onBibleVersionChanged: {
        print("New version!")
        internalBible.name = bibleVersion
    }

    onLoaded: {
        print("Bible: ", bibleVersion, JSON.stringify(availableBibles))
        if (!bibleVersion === "" && !containsBible(bibleVersion)) {
            if (availableBibles.length > 0)
                bibleVersion = availableBibles[0].name
            else
                bibleVersion = ""
        } else if (bibleVersion === "" && availableBibles.length > 0) {
            bibleVersion = availableBibles[0].name
        }

        print("Setting bible version", bibleVersion)
        internalBible.name = bibleVersion
        bible = internalBible

        bibleManager.confirmedPermission = permissionConfirmed
    }

    function containsBible(name) {
        for (var i = 0; i < availableBibles.length; i++) {
            var bibleInfo = availableBibles[i]

            if (bibleInfo.name == name)
                return true
        }

        return false
    }

    property Bible bible
    property alias availableBibles: bibleManager.installedBibles

    Bible {
        id: internalBible
        onNameChanged: {
            print("Name changed:", name)
            bible = null
            bible = internalBible
        }
    }

    BibleManager {
        id: bibleManager
    }

    property alias bibleManager: bibleManager
}
