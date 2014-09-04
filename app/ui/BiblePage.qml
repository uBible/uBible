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
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0
import Ubuntu.Layouts 1.0
import Ubuntu.Content 0.1

import uBible 1.0
import "../components"

Page {
    id: root
    title: currentRegion.title

    property alias location: currentRegion.location

    onLocationChanged:selectedRegion = []

    head.actions: [
        Action {
            iconName: "location"
            text: i18n.tr("Go To")
            onTriggered: {
                PopupUtils.open(Qt.resolvedUrl("GoToDialog.qml"), root, {location: location})
            }
        },

        Action {
            iconName: "search"
            text: i18n.tr("Search")
            onTriggered: pageStack.push(Qt.resolvedUrl("SearchPage.qml"))
        }
    ]

    property Location currentRegion: Location {
        id: currentRegion
    }

    property var selectedRegion: []

    onSelectedRegionChanged: print("changing")

    property string selectionTitle: {
        var list = JSON.parse(JSON.stringify(selectedRegion))
        list = list.sort(function(a,b) { return Number(a) - Number(b) })

        var result = []
        var start = -1; var end = -9;
        for (var i = 0; i < list.length; i++) {
            var verse = list[i];
            print(verse, start, end)
            if (verse == end + 1) {
                end = verse
            } else {
                if (start != -1) {
                    if (start == end)
                        result.push(start)
                    else
                        result.push(start + "-" + end)
                }

                start = verse
                end = verse
            }

            print("--> ", verse, start, end)
        }

        if (start != -1) {
            if (start == end)
                result.push(start)
            else
                result.push(start + "-" + end)
        }

        return currentRegion.book + " " + currentRegion.chapter + ":" + result.join(", ")
    }

    property string selectionContents: {
        var list = JSON.parse(JSON.stringify(selectedRegion))
        list = list.sort(function(a,b) { return Number(a) - Number(b) })

        var result = []
        for (var i = 0; i < list.length; i++) {
            var verseNumber = list[i]
            result.push(bible.verse(currentRegion.book, currentRegion.chapter, verseNumber))
        }

        return result.join("\n")
    }

    BibleChapter {
        id: bibleChapter

        book: currentRegion.book
        chapter: currentRegion.chapter
        version: settings.bibleVersion

        onVersionChanged: print("VERSION:", version)
    }

    function verseToString(verse) {
        return currentRegion.book + " " + currentRegion.chapter + ":" + verse
    }

    // FIXME: This is caused by an SDK bug
    onFlickableChanged: {
        var margin
        if (sidebar.expanded) {
            margin = 0
        } else {
            margin = units.gu(9.5)
        }

        bibleView.flickable.topMargin = Qt.binding(function() { return margin + audioPanel.y + audioPanel.height })
    }


    BibleView {
        id: bibleView
        objectName: "bibleView"

        anchors.fill: parent

        clip: true
    }

    Component {
        id: bookmarksPopover

        BookmarksPopover {}
    }

    property var bible: settings.bible

    property int verseNumber: selectedRegion.length > 0 ? selectedRegion[0] : -1

    ActionPanel {
        opened: selectedRegion.length > 0

        onOpenedChanged: print("Opened", opened)

        tools: ToolbarItems {
            locked: true

            back: ToolbarButton {
                action: Action {
                    iconName: "close"
                    text: "Close"
                    onTriggered: selectedRegion = []
                }
                style: ActionButton {}
            }

            ToolbarButton {
                action: Action {
                    iconName: "note"
                    text: "Notes"
                }
                style: ActionButton {}
            }

            // You can only bookmark a single verse
            ToolbarButton {
                width: units.gu(8)
                action: Action {
                    iconName: bookmarkIndex == -1 ? "non-starred" : "starred"
                    enabled: selectedRegion.length == 1

                    text: bookmarkIndex === -1 ? i18n.tr("Bookmark") : i18n.tr("Unbookmark")

                    property int bookmarkIndex: settings.bookmarks.indexOf(verseToString(verseNumber))

                    onTriggered: {
                        var list = settings.bookmarks

                        if (bookmarkIndex === -1) {
                            list.push(verseToString(verseNumber))
                        } else {
                            list.splice(bookmarkIndex, 1)
                        }
                        list.sort()
                        settings.bookmarks = list
                    }
                }
                style: ActionButton {}
            }


            ToolbarButton {
                action: Action {
                    iconName: "edit-copy"
                    text: i18n.tr("Copy")
                    onTriggered: Clipboard.push(selectionTitle + "\n" + selectionContents)
                }
                style: ActionButton {}
            }

            ToolbarButton {
                action: Action {
                    iconName: "share"
                    text: "Share"
                    onTriggered: pageStack.push(sharePicker)
                }
                style: ActionButton {}
            }
        }
    }

    Component {
        id: sharePicker

        Page {
            ContentPeerPicker {
                objectName: "sharePicker"
                anchors.fill: parent
                visible: parent.active
                contentType: ContentType.Text
                handler: ContentHandler.Share

                onPeerSelected: {
                    pageStack.pop()

                    var curTransfer = peer.request();
                    if (curTransfer.state === ContentTransfer.InProgress)
                    {
                        curTransfer.items = [ contentItemComp.createObject(parent, {"url": viewerWrapper.media.path}) ];
                        curTransfer.state = ContentTransfer.Charged;
                    }
                }
                onCancelPressed: pageStack.pop()
            }
        }
    }

}
