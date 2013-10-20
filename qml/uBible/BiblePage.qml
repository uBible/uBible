/*
 * Whatsoever ye do in word or deed, do all in the name of the
 * Lord Jesus, giving thanks to God and the Father by him.
 * - Colossians 3:17
 *
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Layouts 0.1
import uBible 1.0

Page {
    id: root
    title: bookChapter

    property string location: "Genesis 1:1"

    property string verse: {
        print ("Updating verse")
        if (location.lastIndexOf(':') !== -1) {
            return location.substring(location.lastIndexOf(':') + 1)
        } else {
            return 1
        }
    }

    property int startVerse: {
        if (verse.lastIndexOf('-') !== -1) {
            print(verse.substring(0, verse.lastIndexOf('-')))
            return verse.substring(0, verse.lastIndexOf('-'))
        } else {
            return verse
        }
    }

    property int endVerse: {
        if (verse.lastIndexOf('-') !== -1) {
            print(verse.substring(verse.lastIndexOf('-') + 1))
            return verse.substring(verse.lastIndexOf('-') + 1)
        } else {
            return verse
        }
    }

    property string book: {
        print ("Updating book")
        if (location.lastIndexOf(' ') !== -1) {
            return location.substring(0, location.lastIndexOf(' '))
        } else {
            return location
        }
    }
    property int chapter: {
        print ("Updating chapter")
        if (bookChapter.lastIndexOf(' ') !== -1) {
            return bookChapter.substring(location.lastIndexOf(' ') + 1)
        } else {
            return bookChapter
        }
    }

    property string bookChapter: {
        print ("Updating bookChapter")
        if (location.lastIndexOf(':') !== -1) {
            return location.substring(0, location.lastIndexOf(':'))
        } else {
            return location
        }
    }

    function goTo(verse) {
        tabs.selectedTabIndex = wideAspect ? 0 : 1
        root.location = verse
        print("Book:", root.book)
        print("Chapter:", root.chapter)
        print("Verse:", root.startVerse)
        bibleView.goTo()
    }

    BibleChapter {
        id: bibleChapter

        book: root.book
        chapter: root.chapter
        version: bibleVersionOption.value
    }

    function verseToString(index) {
        return book + " " + chapter + ":" + (index + 1)
    }

    flickable: sidebar.expanded ? null : bibleView.flickable

    onFlickableChanged: {
        var margin
        if (sidebar.expanded) {
            margin = 0
        } else {
            margin = units.gu(9.5)
        }

        bibleView.flickable.topMargin = Qt.binding(function() { return audioPanel.height + audioPanel.y + margin})
    }

    Sidebar {
        id: sidebar
        objectName: "sidebar"

        expanded: wideAspect && !fullscreen
        onExpandedChanged: tools.opened = sidebar.expanded
    }

    Item {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: sidebar.right
            right: parent.right
            leftMargin: units.gu(1/8)
        }

        clip: true

        BibleView {
            id: bibleView
            objectName: "bibleView"

//            anchors {
//                top: audioPanel.bottom
//                bottom: parent.bottom
//                left: parent.left
//                right: parent.right
//            }

            anchors.fill: parent
            topMargin: audioPanel.height + audioPanel.y

            clip: true

            currentVerse: audioPanel.playing ? audioPanel.currentVerse : -1
        }

        AudioPanel {
            id: audioPanel

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }
    }

    onActiveChanged: tools.opened = sidebar.expanded

    tools: ToolbarItems {
        locked: sidebar.expanded
        opened: sidebar.expanded

        ToolbarButton {
            id: goToButton
            iconSource: getIcon("location")
            text: i18n.tr("Go To")
            onTriggered: {
                PopupUtils.open(Qt.resolvedUrl("GoToDialog.qml"), goToButton)
            }
        }

        ToolbarButton {
            id: bookmarksButton
            iconSource: getIcon("favorite-selected")
            text: i18n.tr("Bookmarks")
            //enabled: bookmarksOption.value.length > 0
            onTriggered: PopupUtils.open(bookmarksPopover, bookmarksButton)
        }

        ToolbarButton {
            visible: !wideAspect
            iconSource: getIcon("search")
            text: i18n.tr("Search")
            onTriggered: search()
        }

        ToolbarButton {
            iconSource: getIcon("speaker")
            text: i18n.tr("Listen")
            onTriggered: audioPanel.play()
            enabled: !audioPanel.playing
        }

        ToolbarButton {
            visible: wideAspect
            text: fullscreen ? i18n.tr("Restore") : i18n.tr("Fullscreen")
            iconSource: fullscreen ? getIcon("view-restore") : getIcon("view-fullscreen")

            onTriggered: fullscreen = !fullscreen
        }
    }

    Component {
        id: bookmarksPopover

        BookmarksPopover {}
    }
}
