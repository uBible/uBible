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
import Ubuntu.Components.ListItems 0.1

Page {
    id: root
    title: "uBible"

    Column {
        anchors.fill: parent

        Empty {
            TextField {
                id: searchField

                placeholderText: "Search..."

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: searchButton.left
                    margins: units.gu(1)
                }
            }

            Button {
                id: searchButton

                anchors {
                    top: searchField.top
                    bottom: searchField.bottom
                    right: parent.right
                    rightMargin: units.gu(1)
                }

                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "green"
                    }

                    GradientStop {
                        position: 1
                        color: Qt.rgba(0.3,0.7,0.3,1)
                    }
                }

                text: "Search"
            }
        }

        Header {
            text: "Verse of the Day"
        }

        Subtitled {
            text: "<b>Proverbs 3:5-6</b>"
            subText: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
            height: implicitHeight + units.gu(1)
        }

        Header {
            text: "Previous Reading"
        }

        Subtitled {
            text: "<b>John 1</b>"
            subText: "In the beginning was the Word, and the Word was with God, and the Word was God. The same was in the beginning with God. All things were made by him; and without him was not any thing made that was made."
            height: implicitHeight + units.gu(1)
            removable: true

            backgroundIndicator: Rectangle {
                anchors.fill: parent
                color: "darkgray"
                clip: true

                Image {
                    source: "/usr/share/icons/ubuntu-mobile/actions/scalable/clear.svg"
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        margins: units.gu(1.5)
                    }

                    width: height
                }
            }
        }

        Subtitled {
            text: "<b>Genesis 1</b>"
            subText: "In the beginning God created the heaven and the earth. And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters. And God said, Let there be light: and there was light."
            height: implicitHeight + units.gu(1)
            removable: true

            backgroundIndicator: Rectangle {
                anchors.fill: parent
                color: "darkgray"
                clip: true

                Image {
                    source: "/usr/share/icons/ubuntu-mobile/actions/scalable/clear.svg"
                    anchors {
                        top: parent.top
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        margins: units.gu(1.5)
                    }

                    width: height
                }
            }
        }
    }
}
