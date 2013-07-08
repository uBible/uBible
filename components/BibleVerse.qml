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

Subtitled {
    id: root

    property string verse
    property string contents

    text: "<b>" + verse + "</b>"
    subText: contents

    height: implicitHeight + units.gu(1)

    onClicked: {
        biblePage.goTo(root.verse)
    }

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
