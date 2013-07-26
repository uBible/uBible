import QtQuick 2.0
import Ubuntu.Components 0.1

UbuntuShape {
    radius: "medium"
    width: units.gu(8)
    height: units.gu(8)
    color: "#3E3EFF"
    image: Image {

    }

    Behavior on color {
        ColorAnimation { duration: 200 }
    }

    Label {
        color: "white"
        anchors.centerIn: parent
        text: "Read"
    }

    MouseArea {
        anchors.fill: parent

        onPressed: parent.color = Qt.darker("#3E3EFF", 1.5)
        onReleased: parent.color = "#3E3EFF"
        onClicked: goTo("Genesis 1:1")
    }
}

