import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import uBible 1.0


Item {
    property var modelVar:{
        if(searchPage.searchText != "" )
        {modelVar = search(searchPage.searchText)}
        else{modelVar = {}}}
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
        ListView {

            id: list
            model: modelVar
            snapMode: ListView.SnapToItem

            /*
             * Used for extra padding to make a 1 gu margin around
             * all the edges of the view. (The left and right already
             * have 1 gu, and the top and bottom of each verse have
             * 0.25 gu, so the extra 0.75 gu at the very top and bottom
             * make a total of 1 gu.)
             */
            header: Item { width: list.width; height: units.gu(0.75) }
            footer: Item { width: list.width; height: units.gu(0.75) }

            delegate: BibleVerse {
                text: modelData

            }
        }
    }
}
