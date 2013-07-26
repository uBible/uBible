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
        tabs.selectedTabIndex = 1
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
    }

    property color selectionColor: "orange"

    flickable: layouts.currentLayout == "phone" ? bibleView.flickable : null

    Layouts {
        id: layouts
        anchors.fill: parent

        layouts: [
            ConditionalLayout {
                name: "phone"
                when: !wideAspect

                ItemLayout {
                    item: "bibleView"
                    anchors.fill: parent
                }
            },

            ConditionalLayout {
                name: "wide"
                when: wideAspect

                Item {
                    anchors.fill: parent

                    Sidebar {
                        id: sidebarItem

                        anchors {
                            top: parent.top
                            //topMargin: root.flickable.topMargin
                            left: parent.left
                            bottom: parent.bottom
                            bottomMargin: units.gu(-2)
                        }
                    }

                    ItemLayout {
                        item: "bibleView"

                        anchors {
                            top: parent.top
                            bottom: parent.bottom
                            bottomMargin: units.gu(-2)
                            left: sidebarItem.right
                            right: parent.right
                        }
                    }
                }
            }

        ]

        BibleView {
            id: bibleView
            objectName: "bibleView"

            Layouts.item: "bibleView"
            clip: true
        }
    }

    states: [
        State {
            name: "wide"
            when: wideAspect
            PropertyChanges {
                target: tools
                locked: true
                opened: true
            }
        }
    ]

    tools: ToolbarItems {
        back: ToolbarButton {
            iconSource: icon("favorite-selected")
            text: i18n.tr("Home")
            onTriggered: {
                tabs.selectedTabIndex = 0
            }
        }

        ToolbarButton {
            iconSource: icon("location")
            text: i18n.tr("Go To")
            onTriggered: {
                PopupUtils.open(Qt.resolvedUrl("GoToDialog.qml"), caller)
            }
        }

        ToolbarButton {
            visible: !wideAspect
            iconSource: icon("search")
            text: i18n.tr("Search")
            onTriggered: search()
        }

        ToolbarButton {
            iconSource: icon("speaker")
            text: i18n.tr("Listen")
        }

        ToolbarButton {
            iconSource: icon("settings")
            text: i18n.tr("Settings")
            onTriggered: {
                showSettings()
            }
        }
    }
}
