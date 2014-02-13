import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1

Item {
    property bool loading: false

    Column {
        anchors.centerIn: parent
        visible: loading
        spacing: units.gu(1)

        ActivityIndicator {
            running: loading
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "Searching..."
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Column {
        anchors.fill: parent
        visible: !loading

        Header {
            text: "Search Results"
        }
    }
}
