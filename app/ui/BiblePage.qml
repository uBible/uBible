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

import uBible 1.0
import "../components"

Page {
    id: root
    title: currentRegion.title

    property alias location: currentRegion.location

    onLocationChanged: bibleView.goTo()

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
        }
    ]

    property Location currentRegion: Location {
        id: currentRegion
    }

    property Location selectedRegion: Location {
        id: selectedRegion
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

    flickable: sidebar.expanded ? null : bibleView.flickable

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

    Component {
        id: versePopover

        ActionSelectionPopover {
            id: popover

            grabDismissAreaEvents: true

            property int verse
            property string text

            actions: ActionList {
                Action {
                    text: bookmarkIndex === -1 ? i18n.tr("Bookmark") : i18n.tr("Remove bookmark")
                    property int bookmarkIndex: bookmarksOption.value.indexOf(verseToString(verse))
                    onTriggered: {
                        var list = bookmarksOption.value

                        if (bookmarkIndex === -1) {
                            list.push(verseToString(verse))
                        } else {
                            list.splice(bookmarkIndex, 1)
                        }
                        list.sort()
                        bookmarksOption.value = list
                    }
                }
                Action{
                    text: i18n.tr("Copy Verse")
                    onTriggered: Clipboard.push(verseToString(verse)+ " " + bible.verse(currentRegion.book, currentRegion.chapter, verse))
                }


//                Action {
//                    text: verse.highlighted
//                          ? i18n.tr("Remove Highlight")
//                          : i18n.tr("Highlight")
//                    onTriggered: {
//                        verse.highlighted = !verse.highlighted
//                    }
//                }

//                Action {
//                    text: i18n.tr("Notes")
//                    onTriggered: PopupUtils.open(Qt.resolvedUrl("NotesDialog.qml"), root, {
//                                                     title: bookChapter + ":" + (index + 1),
//                                                     notes: verse.notes
//                                                 })
//                }

//                Action {
//                    text: i18n.tr("Share")
//                }
                Action {
                    text: fullscreen ? i18n.tr("Exit Fullscreen") : i18n.tr("Fullscreen")

                    onTriggered: fullscreen = !fullscreen
                }
            }
        }
    }
}
