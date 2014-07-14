import QtQuick 2.0
import "../../udata"
import ".."

// Automatically generated from a uData model
Document {
    id: object

    _id: "settings"
    _created: true
    _type: "Settings"

    property bool showStrongs: false
    onShowStrongsChanged: _set("showStrongs", showStrongs)

    property bool showRecent: true
    onShowRecentChanged: _set("showRecent", showRecent)

    property string theme: "Suru"
    onThemeChanged: _set("theme", theme)

    property string bibleVersion
    onBibleVersionChanged: _set("bibleVersion", bibleVersion)

    property var bookmarks: []
    onBookmarksChanged: _set("bookmarks", bookmarks)

    property bool showVerse: true
    onShowVerseChanged: _set("showVerse", showVerse)

    property bool showReadingPlan: true
    onShowReadingPlanChanged: _set("showReadingPlan", showReadingPlan)

    onCreated: {
        _set("showStrongs", showStrongs)
        _set("showRecent", showRecent)
        _set("theme", theme)
        _set("bibleVersion", bibleVersion)
        _set("bookmarks", bookmarks)
        _set("showVerse", showVerse)
        _set("showReadingPlan", showReadingPlan)
        _loaded = true
        _created = true
    }

    onLoaded: {
        showStrongs = _get("showStrongs", false)
        showRecent = _get("showRecent", true)
        theme = _get("theme", "Suru")
        bibleVersion = _get("bibleVersion", "")
        bookmarks = _get("bookmarks", [])
        showVerse = _get("showVerse", true)
        showReadingPlan = _get("showReadingPlan", true)
    }

    _properties: ["_type", "_version", "showStrongs", "showRecent", "theme", "bibleVersion", "bookmarks", "showVerse", "showReadingPlan"]
}
