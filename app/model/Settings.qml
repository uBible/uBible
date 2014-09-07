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
        if (bible == null || bible.name != bibleVersion)
            bible = bibleManager.getBible(bibleVersion)
    }

    onLoaded: {
        print("Bible: ", bibleVersion, JSON.stringify(availableBibles))

        bible = bibleManager.getBible(bibleVersion)

        if (bible == null) {
            bible = bibleManager.installedBibles[0]

            if (bible != null)
                bibleVersion = bible.name
        }

        qDebug() << "Bible: " << bible;

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

    property Bible bible: Bible {}
    property alias availableBibles: bibleManager.installedBibles

    BibleManager {
        id: bibleManager
    }

    property alias bibleManager: bibleManager
}
