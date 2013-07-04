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
    title: "Genesis 1"

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    ListModel {
        id: chapterModel
        ListElement {
            verse: "In the beginning God created the heaven and the earth."
        }

        ListElement {
            verse: "And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters."
        }

        ListElement {
            verse: "And God said, Let there be light: and there was light."
        }
    }

    Component {
        id: versePopover

        ActionSelectionPopover {
            id: popover

            actions: ActionList {
                Action {
                    text: "Bookmark"
                }

                Action {
                    text: "Highlight"
                }

                Action {
                    text: "Add Note"
                }

                Action {
                    text: "Share"
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

                    onClicked: {
                        PopupUtils.open(versePopover, verseDelegate,
                                        {
                                            verse: model
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
        ToolbarButton {
            iconSource: icon("location")
            text: "Go To"
            onTriggered: {
                PopupUtils.open(Qt.resolvedUrl("GoToPopover.qml"), caller)
            }
        }

        ToolbarButton {
            iconSource: icon("search")
            text: "Search"
        }

        ToolbarButton {
            iconSource: icon("settings")
            text: "Settings"
        }
    }
}
