import QtQuick 2.0
import "internal" as Internal

import uBible 1.0

Internal.Settings {
    onLoaded: {
        bibleVersion = bible.availableBibles().length > 0 ? bible.availableBibles()[0] : ""
    }

    property Bible bible: Bible {
        onNameChanged: print("Name changed:", name)
    }
}
