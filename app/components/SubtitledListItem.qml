/*
 * Taskly - A simple tasks app for Ubuntu Touch
 *
 * Copyright (C) 2014 Michael Spencer
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem

ListItem.SingleValue {
    id: listItem

    property alias text: titleLabel.text
    property alias subText: subLabel.text

    height: labels.height + units.gu(2)

    Column {
        id: labels

        spacing: units.gu(0.1)

        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: units.dp(-1)
            left: parent.left
            leftMargin: 0
            rightMargin: units.gu(2)
            right: parent.right
        }

        Label {
            id: titleLabel

            width: parent.width
            elide: Text.ElideRight
            maximumLineCount: 1
            color: listItem.selected ? UbuntuColors.orange : UbuntuColors.midAubergine
        }

        Label {
            id: subLabel
            width: parent.width

            //color:  Theme.palette.normal.backgroundText
            maximumLineCount: 5
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.weight: Font.Light
            fontSize: "small"
            visible: text !== ""
            elide: Text.ElideRight
            color: listItem.selected ? UbuntuColors.orange : Theme.palette.selected.backgroundText
        }
    }
}
