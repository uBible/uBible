/*
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers. See the
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

    Flickable {
        id: flickable
        anchors {
            fill: parent
        }

        contentWidth: content.width
        contentHeight: content.height

        Column {
            id: content
            width: root.width


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

                    onClicked: search(searchField.text)
                }
            }

            Header {
                text: "<b>Verse of the Day<b>"
            }

            BibleVerse {
                verse: "Proverbs 3:5-6"
                contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
            }

            Header {
                text: "<b>Reading Plan<b>"
            }

            BibleVerse {
                verse: "Matthew 6"
                contents: "Take heed that ye do not your alms before men, to be seen of them: otherwise ye have no reward of your Father which is in heaven. "
            }

            Header {
                text: "<b>Recent</b>"
            }

            BibleVerse {
                verse: "John 1"
                contents: "In the beginning was the Word, and the Word was with God, and the Word was God."
                removable: true
            }

            BibleVerse {
                verse: "Genesis 1"
                contents: "In the beginning God created the heaven and the earth."
                removable: true
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }
}
