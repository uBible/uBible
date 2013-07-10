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

Page {
    id: root
    title: bookChapter

    property string verse: "Genesis 1:1"
    property string book: {
        if (verse.lastIndexOf(' ') !== -1) {
            return verse.substring(0, verse.lastIndexOf(' '))
        } else {
            return verse
        }
    }
    property string chapter: {
        if (verse.lastIndexOf(' ') !== -1) {
            return verse.substring(verse.lastIndexOf(' ') + 1)
        } else {
            return verse
        }
    }

    property string bookChapter: {
        if (verse.lastIndexOf(':') !== -1) {
            return verse.substring(0, verse.lastIndexOf(':'))
        } else {
            return verse
        }
    }

    function goTo(verse) {
        root.verse = verse
        // A hack because the header covers the content
        flickable.contentY = -units.gu(10)
        tabs.selectedTabIndex = 1
    }

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Component {
        id: versePopover

        ActionSelectionPopover {
            id: popover

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
                                                     title: root.chapter + ":" + (index + 1),
                                                     notes: verse.notes
                                                 })
                }

                Action {
                    text: i18n.tr("Share")
                }
            }
        }
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: width; contentHeight: contents.height

        Column {
            id: contents
            anchors {
                left: parent.left
                right: parent.right
            }

            Repeater {
                model: BibleChapter {
                    book: root.book
                    chapter: root.chapter
                }

                delegate: Empty {
                    id: verseDelegate

                    width: contents.width
                    height: units.gu(0.5) + verse.height
                    selected: model.highlighted

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
                        font.family: "Liberation Serif"
                        fontSize: "large"
                        color: model.highlighted ? "orange" : "black"
                    }
                    showDivider: false
                }
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }

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
        }
    }
}
