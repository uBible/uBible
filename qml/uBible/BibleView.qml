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
    property int currentVerse: -1
    property alias topMargin: list.topMargin

    function goTo() {
        list.positionViewAtIndex(startVerse - 1, ListView.Beginning)
    }

    onCurrentVerseChanged: {
        list.positionViewAtIndex(currentVerse, ListView.Center)
    }

    Rectangle {
        anchors.fill: parent
        color: themeOption.value === "Light" ? "white" : "transparent"
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
                    text: bookmarkIndex === -1 ? i18n.tr("Bookmark") : i18n.tr("Remove bookmark")
                    property int bookmarkIndex: bookmarksOption.value.indexOf(verseToString(index))
                    onTriggered: {
                        var list = bookmarksOption.value

                        if (bookmarkIndex === -1) {
                            list.push(verseToString(index))
                        } else {
                            list.splice(bookmarkIndex, 1)
                        }
                        list.sort()
                        bookmarksOption.value = list
                    }
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

    Label {
        anchors.centerIn: parent

        fontSize: "large"

        /*
         * TODO: Once a module manager is created, remove
         * the references to SWORD and modules (extra unneeded
         * details) and add a button/link to the module manager
         */
        text: bibleChapter.version == ""
              ? i18n.tr("No SWORD Bible modules are installed!")
              : i18n.tr("The SWORD module containing the %1 Bible is not installed!").arg(bibleChapter.version)
        width: Math.min(implicitWidth, parent.width - units.gu(2))
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        visible: !bibleChapter.bible.exists
    }

    ListView {
        id: list
        anchors.fill: parent

        model: bibleChapter.bible.exists ? bibleChapter : null

        /*
         * Used for extra padding to make a 1 gu margin around
         * all the edges of the view. (The left and right already
         * have 1 gu, and the top and bottom of each verse have
         * 0.25 gu, so the extra 0.75 gu at the very top and bottom
         * make a total of 1 gu.)
         */
        header: Item { width: list.width; height: units.gu(0.75) }
        footer: Item { width: list.width; height: units.gu(0.75) }

        delegate: Empty {
            id: verseDelegate

            height: units.gu(0.5) + verse.height
            //selected: model.highlighted

            onClicked: {
                PopupUtils.open(versePopover, verseDelegate,
                                {
                                    verse: model,
                                    index: index
                                })
            }

            /*
             * TODO: When playing the current verse, replace
             * the number with an audio symbol
             */
            Label {
                id: number
                text: (index + 1)
                color: textColor
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

                wrapMode: Text.WrapAtWordBoundaryOrAnywhere

                /*
                 * FIXME: When using textFormat: Text.RichText,
                 * the label doesn't redraw itself when the width
                 * increases, so this is needed to trick it into
                 * redrawing.
                 *
                 * This is probably a bug in Qt's QtQuick.Text
                 * component.
                 */
                onWidthChanged: {
                    text = ""
                    text = Qt.binding(function() { return model.verse })
                }

                text: model.verse
                textFormat: Text.RichText
                font.family: "Liberation Serif"
                fontSize: "large"
                color: (index === currentVerse || (currentVerse === -1 && index + 1 >= startVerse && index + 1 <= endVerse)) ? selectionColor : textColor

                Behavior on color {
                    ColorAnimation { duration: 500 }
                }
            }
            showDivider: false
        }
    }

    Scrollbar {
        flickableItem: list
    }
}
