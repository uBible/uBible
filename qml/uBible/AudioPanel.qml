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
import Ubuntu.Components.Popups 0.1

Rectangle {
    id: root

    property bool expanded: playing

    property bool playing: false

    property int currentVerse: 0
    property string echo: "echo"
    property string program: "/usr/bin/festival"
    property string argum: "--tts"
    property string bverse: bibleChapter

    color: Qt.rgba(0.6,0.5,0.6,0.9)

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        topMargin: expanded ? 0 : -root.height

        Behavior on topMargin {
            UbuntuNumberAnimation { }
        }
    }


    height: child.height + divider.height

    default property alias contents: child.data

    Item {
        id: child

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: divider.top
        }

        Label {
            anchors.centerIn: parent
            text: "Audio is still in development. This is just for testing."
        }

        height: units.gu(6)
    }

    ThinDivider {
        id: divider
        rotation: 180

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    function play() {
        playing = true
        counter.start()
        scriptLauncher.launchScript(echo, bverse, program, argum)
    }
    function stop(){
        playing = false
        counter.stop()
    }
    /*
     * This is a temporary test to highlight the currently
     * playing verse
     */
    Timer {
        id: counter
        repeat: true
        interval: 2000 // 2 seconds
        onTriggered: currentVerse++
    }
}
