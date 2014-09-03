import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

Page {
    title: "Bible Manager"

    ListView {
        id: listView
        anchors.fill: parent

        model: settings.bible.availableBibles()
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
