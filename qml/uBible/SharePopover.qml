import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Friends 0.1
import "ubuntu-ui-extras" as Extra

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
