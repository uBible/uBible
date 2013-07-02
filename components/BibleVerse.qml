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

UbuntuShape {
    id: root

    property alias verse: verse.text
    property string link

    color: "white"

    height: verse.height + link.height + 3 * verse.anchors.margins

    Label {
        id: verse

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: units.gu(1)
        }

        wrapMode: Text.Wrap
    }

    Label {
        id: link

        font.italic: true
        property string url: "http://www.biblegateway.com/passage/?search=" + root.link.replace(" ", "%20") + "&version=KJV"
        text: "<a href=\"" + url + "\">" + root.link + "</a>"

        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: units.gu(1)
        }

        onLinkActivated: {
            Qt.openUrlExternally(url)
        }
    }
}
