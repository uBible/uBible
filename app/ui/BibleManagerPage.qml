import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

Page {
    title: "Bible Manager"

    head.actions: Action {
        iconName: "save-to"
        text: i18n.tr("Install/Remove")
        onTriggered: pageStack.push(Qt.resolvedUrl("BibleInstallerPage.qml"))
    }

    ListView {
        id: listView
        anchors.fill: parent

        model: settings.availableBibles
        delegate: ListItem.Standard {
            text: modelData.name
            selected: modelData.name == settings.bibleVersion
            onClicked: settings.bibleVersion = modelData.name

            Icon {
                name: "tick"
                width: units.gu(2.5)
                height: width
                visible: selected
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
}
