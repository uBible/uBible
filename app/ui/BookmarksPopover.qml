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
import "../ubuntu-ui-extras" as Extra

Popover {
    id: root
    Column {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Item {
            width: parent.width
            height: noneLabel.height + units.gu(4)

            visible: list.count === 0

            Label {
                id: noneLabel
                anchors.centerIn: parent

                width: parent.width - units.gu(4)
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter

                text: i18n.tr("<b>No verses have been bookmarked</b><p>To bookmark a verse, click on it and choose \"Bookmark\".")
                color: Theme.palette.normal.overlayText
            }
        }

        Repeater {
            id: list

            model: bookmarksOption.value

            delegate: Standard {
                property string name: modelData

                Label {
                    anchors.left: parent.left
                    anchors.leftMargin: units.gu(2)
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: selected ? UbuntuColors.orange : Theme.palette.normal.overlayText
                }

                onClicked: {
                    PopupUtils.close(root)
                    goTo(modelData)
                }

                showDivider: index < (list.count - 1)

                removable: true
                backgroundIndicator: Extra.ListItemBackground {
                    state: swipingState
                    text: i18n.tr("Remove")
                    fontColor: Theme.palette.normal.overlayText
                    iconSource: getIcon("clear")
                }

                onItemRemoved: {
                    removeBookmark(modelData)
                }
            }
        }
    }
}
