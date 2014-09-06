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
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0
import uBible 1.0

import "../components"
import "../ubuntu-ui-extras" as Extra

Page {
    id: root
    title: "uBible"

    head.actions: [
        Action {
            iconName: "location"
            text: i18n.tr("Go To")
            onTriggered: PopupUtils.open(Qt.resolvedUrl("GoToDialog.qml"))
        },

        Action {
            iconName: "settings"
            text: i18n.tr("Settings")
            onTriggered: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
        }
    ]

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

            // Use our own custom component so the divider goes full width
            ListHeader {
                text: i18n.tr("Verse of the Day")
            }

            BibleVerse {
                verse: "Proverbs 3:5-6"
                //contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
            }

            // Use our own custom component so the divider goes full width
            ListHeader {
                text: i18n.tr("Reading Plan")
                visible: settings.showReadingPlan
            }

            // TODO: Use real reading plan backend
            BibleVerse {
                visible: settings.showReadingPlan
                verse: "1 John 3"
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }
}
