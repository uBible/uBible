/*
 * Whatsoever ye do in word or deed, do all in the name of the
 * Lord Jesus, giving thanks to God and the Father by him.
 * - Colossians 3:17
 *
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem
import uBible 1.0
import "../components"

Page {
    id: page

    title: i18n.tr("Search")

    property alias searchText: searchField.text

    head.actions: [
        Action {
            iconName: "search"
            onTriggered: search()
        }
    ]

    head.contents: TextField {
        id: searchField
        placeholderText: i18n.tr("Search...")
        width: parent ? parent.width : 0

        onTriggered: search()
    }

    UbuntuListView {
        anchors.fill: parent
        model: model

        section.property: "book"
        section.delegate: ListHeader {
            text: section
        }

        delegate: BibleVerse {
            verse: model.verse
            highlight: actualQuery
        }
    }

    Column {
        anchors.centerIn: parent
        visible: searchTask.busy
        spacing: units.gu(1)

        ActivityIndicator {
            anchors.horizontalCenter: parent.horizontalCenter
            running: searchTask.busy
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: i18n.tr("Searching...")
            fontSize: "large"
        }
    }

    Column {
        anchors.centerIn: parent
        visible: model.count == 0 && !searchTask.busy
        spacing: units.gu(0.5)

        Icon {
            name: "search"
            opacity: 0.5
            width: units.gu(10)
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            width: parent.width
            height: units.gu(2)
        }

        Label {
            fontSize: "large"
            anchors.horizontalCenter: parent.horizontalCenter
            width: page.width - units.gu(8)
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            opacity: 0.5

            text: {
                if (actualQuery != "") {
                    return i18n.tr("No results found")
                } else {
                    return i18n.tr("Enter a search query and tap the search icon")
                }
            }
        }
    }

    Scrollbar {
        flickableItem: flickable
    }

    property string actualQuery

    function search() {
        actualQuery = searchText
        if (searchText !== "")
            searchTask.search(searchText)
    }

    ListModel {
        id: model
    }

    SearchTask {
        id: searchTask
        bible: settings.bible

        onResultsChanged: {
            model.clear()

            if (!busy) {
                searchTask.results.forEach(function(verse) {
                    var array = verse.split(" ")
                    var book

                    if (verse.indexOf("I") == 0) {
                        book = array[0] + " " + array[1]
                    } else {
                        book = array[0]
                    }

                    model.append({
                                  verse: verse,
                                  book: book
                              })
                })
            }
        }
    }
}
