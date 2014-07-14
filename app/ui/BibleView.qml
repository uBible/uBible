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

import "../ubuntu-ui-extras"
import "../components"

Item {
    id: root

    property variant flickable: list

    function goTo() {
        list.positionViewAtIndex(currentRegion.startVerse - 1, ListView.Beginning)
    }

    Rectangle {
        anchors.fill: parent
        color: "#fefefe"//themeOption.value === "Light" ? "#f0f0f0" : "transparent"
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
              ? i18n.tr("<b>No Bibles are installed!</b><p>Open the Bible manager to install a Bible.")
              : i18n.tr("<b>The %1 Bible is not installed!</b><p>Open the Bible manager to install the Bible or choose a different version in Settings.").arg(bibleChapter.version)
        width: Math.min(implicitWidth, parent.width - units.gu(2))
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        visible: !bibleChapter.bible.exists
    }

    ListView {
        id: list
        anchors.fill: parent

        model: bibleChapter.bible.exists ? bibleChapter : null
        snapMode: ListView.SnapToItem

        /*
         * Used for extra padding to make a 1 gu margin around
         * all the edges of the view. (The left and right already
         * have 1 gu, and the top and bottom of each verse have
         * 0.25 gu, so the extra 0.75 gu at the very top and bottom
         * make a total of 1 gu.)
         */
        header: Item { width: list.width; height: units.gu(0.75) }
        footer: Item { width: list.width; height: units.gu(0.75) }

        delegate: VerseDelegate {

        }

        property bool __goToNext: false
        property bool __goToPrev: false

        onContentYChanged: {
            if (atEnd) {
                if (diff > units.gu(6)) {
                    __goToNext = true;
                }
                else if (dragging) {
                    __goToNext = false;
                }
            } else {
                __goToNext = false
            }

            if (atBeginning) {
                if (diff > units.gu(6)) {
                    __goToPrev = true;
                }
                else if (dragging) {
                    __goToPrev = false;
                }
            } else {
                __goToPrev = false
            }
        }
        onMovementEnded: {
            if (__goToNext) {
                if (bibleChapter.nextChapter !== "") {
                    notification.show(bibleChapter.nextChapter)
                    location = bibleChapter.nextChapter
                }
                __goToNext = false
            }

            if (__goToPrev) {
                if (bibleChapter.previousChapter !== "") {
                    notification.show(bibleChapter.previousChapter)
                    location = bibleChapter.previousChapter
                }
                __goToPrev = false
            }
        }
    }


    property int diff: atBeginning ? startY - list.contentY : atEnd ? list.contentY - endY : 0
    property int endY
    property int startY

    property bool atEnd: list.atYEnd
    property bool atBeginning: list.atYBeginning

    onAtEndChanged: {
        if (atEnd) {
            endY = list.contentY
        } else {
            endY = -1
        }
    }

    onAtBeginningChanged: {
        if (atBeginning) {
            startY = list.contentY
        } else {
            startY = -1
        }
    }

    ColorizedImage {
        height: pullDownLabel.height
        width: height
        color: pullDownLabel.color
        source: getIcon("go-down")
        anchors {
            verticalCenter: pullDownLabel.verticalCenter
            right: pullDownLabel.left
            margins: units.gu(1)
        }

        rotation: diff > units.gu(6) ? 180 : 0
        visible: pullDownLabel.visible

        Behavior on rotation {
            UbuntuNumberAnimation {}
        }
    }

    ColorizedImage {
        height: pullDownLabel.height
        width: height
        color: pullDownLabel.color
        source: getIcon("go-down")
        anchors {
            verticalCenter: pullDownLabel.verticalCenter
            left: pullDownLabel.right
            margins: units.gu(1)
        }

        rotation: diff > units.gu(6) ? 180 : 0
        visible: pullDownLabel.visible

        Behavior on rotation {
            UbuntuNumberAnimation {}
        }
    }

    ColorizedImage {
        height: pullDownLabel.height
        width: height
        color: pullDownLabel.color
        source: getIcon("go-down")
        anchors {
            verticalCenter: pullUpLabel.verticalCenter
            right: pullUpLabel.left
            margins: units.gu(1)
        }

        rotation: diff > units.gu(6) ? 0 : 180
        visible: pullUpLabel.visible

        Behavior on rotation {
            UbuntuNumberAnimation {}
        }
    }

    ColorizedImage {
        height: pullDownLabel.height
        width: height
        color: pullDownLabel.color
        source: getIcon("go-down")
        anchors {
            verticalCenter: pullUpLabel.verticalCenter
            left: pullUpLabel.right
            margins: units.gu(1)
        }

        rotation: diff > units.gu(6) ? 0 : 180
        visible: pullUpLabel.visible

        Behavior on rotation {
            UbuntuNumberAnimation {}
        }
    }

    Label {
        id: pullDownLabel
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: (atBeginning ? diff > units.gu(4) ? units.gu(1) : diff - units.gu(3) : -units.gu(3)) + list.topMargin
        }

        fontSize: "large"
        text: bibleChapter.previousChapter
        visible: atBeginning && text !== ""
    }

    Label {
        opacity: pullDownLabel.visible && diff > units.gu(6) ? 0.5 : 0
        text: i18n.tr("Release to load")
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: pullDownLabel.bottom
        }

        Behavior on opacity {
            UbuntuNumberAnimation {}
        }
    }

    Label {
        id: pullUpLabel
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: atEnd ? diff > units.gu(4) ? units.gu(1) : diff - units.gu(3) : -units.gu(3)
        }

        fontSize: "large"
        text: bibleChapter.nextChapter
        visible: atEnd && text !== ""
    }

    Label {
        opacity: pullUpLabel.visible && diff > units.gu(6) ? 0.5 : 0
        text: i18n.tr("Release to load")
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: pullUpLabel.top
        }

        Behavior on opacity {
            UbuntuNumberAnimation {}
        }
    }

    Scrollbar {
        flickableItem: list
    }
}
