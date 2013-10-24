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
import "ubuntu-ui-extras" as Extra

Page {
    id: quickrefPage

    property var ref

    property var keys: {
        var list = []
        for(var prop in ref) {
            list.push(prop)
        }
        return list
    }

    ListView {
        anchors.fill: parent
        model: quickrefPage.keys

        delegate: SingleValue {
            text: modelData
            value: progression || quickrefPage.ref[modelData] === modelData ? "" : quickrefPage.ref[modelData]
            progression: typeof(quickrefPage.ref[modelData]) !== "string"

            onClicked: {
                if (progression) {
                    pageStack.push(Qt.resolvedUrl("QuickReferencePage.qml"), {
                                       title: modelData,
                                       ref: quickrefPage.ref[modelData]
                                   })
                } else {
                    goTo(quickrefPage.ref[modelData])
                }
            }
        }
    }

    tools: ToolbarItems {
        locked: wideAspect
        opened: wideAspect

        onLockedChanged: opened = wideAspect
    }
}
