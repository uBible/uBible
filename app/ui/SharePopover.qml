/**
 * This file was originally a part of SaucyBacon.
 *
 * Copyright 2013 (C) Giulio Collura <random.cpp@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/
import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.OnlineAccounts 0.1
import Friends 0.2
import "../ubuntu-ui-extras" as Extra

Popover {
    id: popover

    property string message

    Column {
        id: containerLayout
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }

        Item {
            width: parent.width
            height: noneLabel.height + units.gu(4)

            visible: accounts.count === 0

            Label {
                id: noneLabel
                anchors.centerIn: parent

                width: parent.width - units.gu(4)
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter

                text: i18n.tr("<b>No accounts set up for sharing</b><p>To configure accounts, go to System Settings and choose \"Online Accounts\".")
                color: Theme.palette.normal.overlayText
            }
        }

//        ListItem.Header { text: i18n.tr("Export") }
//        ListItem.Standard {
//            text: i18n.tr("As pdf")
//            icon: mainView.icon("64/export-pdf", true)

//            onTriggered: {
//                hide();
//                toolbar.opened = false;
//                recipe.exportAsPdf();
//            }
//        }
        ListItem.Header {
            text: i18n.tr("Share")
            visible: accountsRepeater.count > 0
        }
        Repeater {
            id: accountsRepeater

            model: accounts
            ListItem.Subtitled {
                text: serviceName
                subText: displayName
                icon: getIcon(serviceName.toLowerCase().replace(".",""), "app")

                onClicked: {
                    PopupUtils.close(popover)
                    friends.sendForAccountAsync(accountId, message);
                }
            }
        }
    }

    FriendsDispatcher {
        id: friends
        onSendComplete: {
            if (success) {
                console.log("Send completed successfully");
            } else {
                console.log("Send failed: " + errorMessage.split("str: str:")[1]);
                // TODO: show some error dialog/widget
            }
        }
        onUploadComplete: {
            if (success) {
                console.log("Upload completed successfully");
            } else {
                console.log("Upload failed: " + errorMessage);
                // TODO: show some error dialog/widget
            }
        }
    }

    AccountServiceModel {
        id: accounts
        serviceType: "microblogging"
    }
}
