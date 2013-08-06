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

Dialog {
    id: root

    title: i18n.tr("Go To Location")

    text: i18n.tr("Enter a chapter/verse to go to:")

    TextField {
        id: locationField

        inputMethodHints: Qt.ImhNoAutoUppercase

        text: fileView.path

        placeholderText: i18n.tr("Location...")

        onAccepted: goButton.clicked()
    }

    Button {
        id: goButton
        objectName: "goButton"

        gradient: Gradient {
            GradientStop {
                position: 0
                color: "green"//Qt.rgba(0,0.7,0,1)
            }

            GradientStop {
                position: 1
                color: Qt.rgba(0.3,0.7,0.3,1)
            }
        }

        text: i18n.tr("Go")
        enabled: locationField.acceptableInput && locationField.valid

        onClicked: {
            print("User switched to:", locationField.text)
            goTo(locationField.text)
            PopupUtils.close(root)
        }
    }

    Button {
        objectName: "cancelButton"
        text: i18n.tr("Cancel")

        gradient: Gradient {
            GradientStop {
                position: 0
                color: "gray"
            }

            GradientStop {
                position: 1
                color: "lightgray"
            }
        }

        onClicked: {
            PopupUtils.close(root)
        }
    }
}
