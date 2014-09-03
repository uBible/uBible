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

import "../components"
import "../ubuntu-ui-extras"

Dialog {
    id: root

    title: i18n.tr("Go To Chapter")

    text: i18n.tr("Enter a book and chapter to go to:")

    property alias location: locationPicker.location

    LocationPicker {
        id: locationPicker
    }

    Item {
        width: parent.width
        height: childrenRect.height

        Button {
            objectName: "cancelButton"
            text: i18n.tr("Cancel")

            anchors {
                left: parent.left
                right: parent.horizontalCenter
                rightMargin: units.gu(1)
            }

            onClicked: {
                PopupUtils.close(root)
            }
        }

        Button {
            id: okButton
            objectName: "okButton"

            anchors {
                left: parent.horizontalCenter
                right: parent.right
                leftMargin: units.gu(1)
            }

            color: UbuntuColors.orange
            text: i18n.tr("Go")

            onClicked: {
                PopupUtils.close(root)
                goTo(locationPicker.getLocation())
            }
        }
    }
}
