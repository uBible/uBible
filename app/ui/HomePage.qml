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
import Ubuntu.Components.ListItems 0.1
import uBible 1.0
import "../components"
import "../ubuntu-ui-extras" as Extra
//import Ubuntu.Components.Pickers 0.1

Page {
    id: root
    title: "uBible"

    flickable: flickable

    Flickable {
        id: flickable
        //clip: true

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        contentWidth: width
        contentHeight: content.height

        Column {
            id: content
            width: root.width


            Empty {
                TextField {
                    id: searchField

                    placeholderText: i18n.tr("Search...")

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: searchButton.left
                        margins: units.gu(2)
                    }

                    focus: true
                    Keys.onPressed: {
                            if ( event.key === Qt.Key_Return ) {
                                search(searchField.text)
                                print("Return Pressed")
                            }
                            else{event.accepted = false}

                    }
                }

                Button {
                    id: searchButton

                    anchors {
                        top: searchField.top
                        bottom: searchField.bottom
                        right: parent.right
                        rightMargin: units.gu(2)
                    }

                    text: i18n.tr("Search")

                    onClicked: search(searchField.text)
                }
            }

            Header {
                text: i18n.tr("Verse of the Day")
                visible: showVerseOption.value
            }

            BibleVerse {
                visible: showVerseOption.value
                verse: "Proverbs 3:5-6"
                //contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
            }

            Header {
                text: i18n.tr("Reading Plan")
                visible: showReadingPlanOption.value
            }

            // TODO: Use real reading plan backend
            BibleVerse {
                visible: showReadingPlanOption.value
                verse: "Matthew 6"
                //contents: "Take heed that ye do not your alms before men, to be seen of them: otherwise ye have no reward of your Father which is in heaven. "
            }

            Header {
                text: i18n.tr("Recent")
                visible: recentReadingsOption.value.length > 0
            }

            Repeater {
                model: recentReadingsOption.value

                delegate: BibleVerse {
                    verse: modelData
                    removable: true
                }
            }
            Header {
                text: i18n.tr("Choose")
            }

            property alias location: locationPicker.location


            Row{
                LocationPicker {

                    anchors.margins: units.gu(1)
                    id: locationPicker
                }
                Button {
                    //anchors.top: textLabel.bottom
                    anchors.verticalCenter: locationPicker.verticalCenter
                    id: goButton
                    objectName: "goToButton"
                text: i18n.tr("Go")

                    onClicked: {
                        //print("User switched to:", locationField.text)
                        goTo(locationPicker.getLocation())
                        PopupUtils.close(root)
                    }
                }
            }


        }

    }

    Scrollbar {
        flickableItem: flickable
    }
}
