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
import Ubuntu.Components.Pickers 0.1
import uBible 1.0
import "ubuntu-ui-extras" as Extra

UbuntuShape {
    color: Qt.rgba(0.5,0.5,0.5,0.4)

    width: units.gu(55)
    height: units.gu(18)
    property alias location: pointer.location
    property alias selectedIndex: bookSpinner.selectedIndex
    Location {
        id: pointer

        location: "Matthew " + 1
    }

    function getLocation() {
        console.log("inside getLocation() :" + bible.books[bookSpinner.selectedIndex]+ " " + (1+chapterSpinner.selectedIndex) + " selected index: " + selectedIndex)
        return bible.books[bookSpinner.selectedIndex] + " " + (1+chapterSpinner.selectedIndex)
    }

    Bible {
        id: bible
    }

    Item {
        id: rectangle
        //color: Qt.rgba(0.2,0.2,0.2,0.2)

        anchors {
            fill: parent
            //left: parent.left
            //right: parent.right
            //top: header.bottom
        }

        Picker {
            id: bookSpinner
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                right: divider1.horizontalCenter
                margins: units.gu(1)
            }
            model: bible.books
            width: units.gu(25)
            delegate: PickerDelegate {
                    Label {
                        anchors.centerIn: parent
                        id: bookLabel
                        text: modelData
                    }
                }
            selectedIndex: 1
            onSelectedIndexChanged: {
                    print("selected book: " + selectedIndex);
                    print(bible.books[selectedIndex])

                }
        }

        Extra.VerticalDivider {
            id: divider1
            anchors.horizontalCenter: chapterItem.left
        }

        Item {
            id: chapterItem
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            width: parent.width/3
            Picker {
                id: chapterSpinner
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    //margins: units.gu(1)
                }
                model: (bible.chapterCount(bookSpinner.selectedIndex))
                width: units.gu(25)
                delegate: PickerDelegate {
                        Label {
                            anchors.centerIn: parent
                            id: chapterLabel
                            text: 1 + modelData
                        }
                    }
                selectedIndex: 1
                onSelectedIndexChanged: {
                        print("selected chapter: " + (selectedIndex+1));

                }
            }
        }
    }
}
