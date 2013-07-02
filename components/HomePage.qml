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
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    margins: units.gu(1)
                }

                text: "Go"
            }
        }

//        Header {
//            text: "Verse of the Day"
//        }

//        Empty {
//            BibleVerse {
//                anchors {
//                    left: parent.left
//                    right: parent.right

//                    margins: units.gu(1)
//                }

//                verse: "In the beginning God created the heaven and the earth."
//                link: "Genesis 1:1"
//            }
//        }

        Subtitled {
            text: "Genesis 1:1"
            subText: "In the beginning God created the heaven and the earth."
            progression: true
        }

        Standard {
            text: "Read the Bible"
            progression: true
        }
    }
}
