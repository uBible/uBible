import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import "ubuntu-ui-extras" as Extra

Extra.Sidebar {
    //color: "lightgray"

    color: themeOption.value === "Light"
           ? "transparent"
           : Qt.rgba(0.2,0.2,0.2,0.5)

    Column {
        anchors.fill: parent

        Empty {
            TextField {
                id: searchField

                primaryItem: Image {
                    source: getIcon("search")
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
            text: "Verse of the Day"
            visible: showVerseOption.value
        }

        BibleVerse {
            visible: showVerseOption.value
            verse: "Proverbs 3:5-6"
            //contents: "Trust in the Lord with all thine heart; and lean not unto thine own understanding. In all thy ways acknowledge him, and he shall direct thy paths."
        }

        Header {
            text: "Reading Plan"
            visible: showReadingPlanOption.value
        }

        BibleVerse {
            visible: showReadingPlanOption.value
            verse: "Matthew 6"
            //contents: "Take heed that ye do not your alms before men, to be seen of them: otherwise ye have no reward of your Father which is in heaven. "
        }

        Header {
            text: "Recent"
            visible: recentReadingsOption.value.length > 0
        }

        Repeater {
            model: recentReadingsOption.value

            delegate: BibleVerse {
                verse: modelData
                removable: true
            }
        }
    }
}
