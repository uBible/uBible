import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1
import "ubuntu-ui-extras" as Extra

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

                text: i18n.tr("<b>No verses have been bookmarked.</b><p>To bookmark a verse, click on it and choose \"Bookmark\".")
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
