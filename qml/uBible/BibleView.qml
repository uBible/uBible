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
import uBible 1.0

Item {
    id: root

    property variant flickable: list

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
        selectionAnimation.restart()
        list.positionViewAtIndex(root.startVerse - 1, ListView.Beginning)
        // A hack because the header covers the content
        //flickable.contentY += -units.gu(9.5)
    }

    property color selectionColor: "orange"

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    SequentialAnimation {
        id: selectionAnimation
        PropertyAnimation {
            target: root
            property: "selectionColor"
            to: "orange"
        }

        PauseAnimation { duration: 5000 }

        ColorAnimation {
            target: root
            property: "selectionColor"
            from: UbuntuColors.orange; to: UbuntuColors.coolGrey; duration: 2000
        }
    }

    Component {
        id: versePopover

        ActionSelectionPopover {
            id: popover

            grabDismissAreaEvents: true

            property variant verse
            property variant index

            actions: ActionList {
                Action {
                    text: i18n.tr("Bookmark")
                }

                Action {
                    text: verse.highlighted
                          ? i18n.tr("Remove Highlight")
                          : i18n.tr("Highlight")
                    onTriggered: {
                        verse.highlighted = !verse.highlighted
                    }
                }

                Action {
                    text: i18n.tr("Notes")
                    onTriggered: PopupUtils.open(Qt.resolvedUrl("NotesDialog.qml"), root, {
                                                     title: root.bookChapter + ":" + (index + 1),
                                                     notes: verse.notes
                                                 })
                }

                Action {
                    text: i18n.tr("Share")
                }
            }
        }
    }

    ListView {
        id: list
        anchors.fill: parent

        model: BibleChapter {
            book: root.book
            chapter: root.chapter
        }

        delegate: Empty {
            id: verseDelegate

            width: list.width
            height: units.gu(0.5) + verse.height
            //selected: model.highlighted

            onClicked: {
                PopupUtils.open(versePopover, verseDelegate,
                                {
                                    verse: model,
                                    index: index
                                })
            }

            Label {
                id: number
                text: (index + 1)
                color: UbuntuColors.coolGrey
                font.bold: true

                anchors {
                    left: parent.left
                    leftMargin: units.gu(1)
                    top: verse.top
                    //topMargin: units.gu(0.5)
                }
            }

            Label {
                id: verse

                anchors {
                    left: parent.left
                    leftMargin: units.gu(4)
                    right: parent.right
                    rightMargin: units.gu(1)
                    top: parent.top
                    topMargin: units.gu(0.25)
                }

                wrapMode: Text.Wrap

                text: model.verse
                textFormat: Text.RichText
                font.family: "Liberation Serif"
                fontSize: "large"
                color: index + 1 >= startVerse && index + 1 <= endVerse ? selectionColor : UbuntuColors.coolGrey
            }
            showDivider: false
        }
    }

    Scrollbar {
        flickableItem: list
    }
}
