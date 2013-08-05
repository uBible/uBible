import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1

Item {
    //color: "lightgray"

    Rectangle {
        color: "lightgray"

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        width: 1
    }

    width: units.gu(30)

    Column {
        anchors.fill: parent
        anchors.rightMargin: 1

        Empty {
            TextField {
                id: searchField

                primaryItem: Image {
                    source: icon("search")
                    height: parent.height - units.gu(1.5)
                    width: height
                    anchors.centerIn: parent
                }

                placeholderText: "Search..."


                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    margins: units.gu(1)
                }

                onAccepted: search(searchField.text)
            }

            onClicked: search(searchField.text)
        }

        Header {
            text: "<b>Verse of the Day<b>"
            visible: showVerse
        }

        BibleVerse {
            visible: showVerse
            verse: "Proverbs 3:5-6"
            //contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
        }

        Header {
            text: "<b>Reading Plan<b>"
            visible: showReadingPlan
        }

        BibleVerse {
            visible: showReadingPlan
            verse: "Matthew 6"
            //contents: "Take heed that ye do not your alms before men, to be seen of them: otherwise ye have no reward of your Father which is in heaven. "
        }

        Header {
            text: "<b>Recent</b>"
            visible: recentReadings.length > 0
        }

        Repeater {
            model: recentReadings

            delegate: BibleVerse {
                verse: modelData
                removable: true
            }
        }
    }
}
