import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../components"

Page {
    id: page

    title: page.width < units.gu(50) ? i18n.tr("Install/Remove")
                                     : i18n.tr("Install/Remove Bibles")

    head.actions: [
        Action {
            iconName: "reload"
            text: i18n.tr("Refresh")
            visible: currentIndex == 1
            onTriggered: settings.bibleManager.refresh(true)
        }
    ]

    Column {
        anchors.centerIn: parent
        visible: settings.bibleManager.busy && listView.count == 0
        spacing: units.gu(1)

        ActivityIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
            running: parent.visible
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            fontSize: "large"
            text: settings.bibleManager.status
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: settings.bibleManager.availableBibles

        section.property: "modelData.source"
        section.delegate: ListItem.Header {
            text: section
        }

        delegate: SubtitledListItem {
            text: modelData.name
            subText: modelData.description
            onClicked: {
                modelData.install()
                showInstallDialog(modelData.name)
            }

            Icon {
                name: "save-to"
                width: units.gu(2.5)
                height: width
                visible: modelData.installed
                anchors {
                    rightMargin: units.gu(2)
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    Scrollbar {
        flickableItem: listView
    }

    Component {
        id: installDialog

        Dialog {
            id: dialog

            title: i18n.tr("Installing Bible")
            text: i18n.tr("Installing module: <b>%1</b>").arg(module)

            ProgressBar {
                indeterminate: true
            }

            Connections {
                target: settings.bibleManager
                onBusyChanged: if (!settings.bibleManager.busy && dialog.visible) PopupUtils.close(dialog)
            }
        }
    }

    function showInstallDialog(moduleName) {
        module = moduleName
        PopupUtils.open(installDialog)
    }
}
