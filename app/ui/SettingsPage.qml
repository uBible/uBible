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
import "../ubuntu-ui-extras" as Extra

import uBible 1.0

// TODO: Update the switches and value selectors to use
// the action property with the actual option instead of
// having to manually sync the values
Page {
    id: sheet
    title: i18n.tr("Settings")

    Flickable {
        id: flickable
        anchors.fill: parent

        clip: true
        contentHeight: column.height
        contentWidth: width
        interactive: contentHeight > height

        Column {
            id: column
            width: flickable.width

            ValueSelector  {
                id: bibleVersionSelector
                text: "Bible Version"
                values: settings.bible.availableBibles()
                selectedIndex: values.indexOf(settings.bible.name)

                onSelectedIndexChanged: {
                    settings.bible.name = values[selectedIndex]
                }
            }

            Standard {
                text: i18n.tr("Strongs Numbers")

                control: Switch {
                    id: strongsSwitch
                    //checked: strongsOption.value
                }
            }
        }
    }
}

