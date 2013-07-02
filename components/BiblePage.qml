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

Page {
    id: root
    title: "Genesis 1"

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        anchors.margins: units.gu(1)
        contentWidth: width; contentHeight: label.height

        //flickableDirection:
        Label {
            id: label
            text: "<b>1</b> In the beginning God created the heaven and the earth.<p>" +
                  "<b>2</b> And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters.<p>" +
                  "<b>3</b> And God said, Let there be light: and there was light.<p>" +
                  "<b>4</b> And God saw the light, that it was good: and God divided the light from the darkness.<p>" +
                  "<b>5</b> And God called the light Day, and the darkness he called Night. And the evening and the morning were the first day.<p>"
            width: parent.width
            wrapMode: Text.Wrap
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
