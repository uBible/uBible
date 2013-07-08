/*
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Project Developers. See the
 * COPYRIGHT file at the top-level directory of this distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
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

Page {
    id: root
    title: chapter

    property string verse: "Genesis 1:1"
    property string chapter: {
        if (verse.lastIndexOf(':') !== -1) {
            return verse.substring(0, verse.lastIndexOf(':'))
        } else {
            return verse
        }
    }

    function goTo(verse) {
        root.verse = verse
        tabs.selectedTabIndex = 1
    }

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: chapterModel
        ListElement {
            verse: "In the beginning God created the heaven and the earth."
            notes: "The creation of the world."
            highlighted: true
        }

        ListElement {
            verse: "And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters."
            highlighted: false
        }

        ListElement {
            verse: "And God said, Let there be light: and there was light."
            highlighted: false
        }
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
                model: chapterModel
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
                PopupUtils.open(Qt.resolvedUrl("GoToPopover.qml"), caller)
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
