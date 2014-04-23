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
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import U1db 1.0 as U1db
//import uBible 1.0
import "ubuntu-ui-extras" as Extra

MainView {
    id: root

    //////////// PROPERTY ASIGNMENTS ////////////

    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    /*
     * Note: applicationName needs to match the "name" field of
     * the click manifest
     *
     * TODO: What will be the actual name here?
     */
    applicationName: "com.ubuntu.developer.ubible.ubible"

    /*
     * This property enables the application to change orientation
     * when the device is rotated. The default is false.
     */
    automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    headerColor: (themeOption.value === "" || themeOption.value === "Suru") ? "#57365E" : backgroundColor
    backgroundColor: (themeOption.value === "" || themeOption.value === "Suru")
                     ? "#A55263"
                     : themeOption.value === "Dark" ? Qt.rgba(0.3,0.3,0.3,1) : "#EDEDED"
    footerColor: (themeOption.value === "" || themeOption.value === "Suru") ? "#D75669" : backgroundColor

    states: [
        State {
            when: toolbar.tools.opened && toolbar.tools.locked

            PropertyChanges {
                target: tabs
                anchors.bottomMargin: -root.toolbar.triggerSize
            }
        }
    ]

    //////////// PROPERTY DEFINITIONS ////////////

    // TODO: Use color from theme!
    property color textColor: themeOption.value === "Light" ? UbuntuColors.coolGrey : "white"

    property color selectionColor: UbuntuColors.orange

    /*
     * True if the app is wide enough and should display its
     * tablet/desktop interface
     */
    property bool wideAspect: width >= units.gu(80)

    //////////// SIGNAL DEFINITIONS ////////////

    //////////// SIGNAL HANDLERS ////////////

    Component.onDestruction: {
        saveRecentReadings()
        recentReadingsOption.saveValue()
    }

    Component.onCompleted: {
//        if (wideAspect) {
//            tabs.selectedTabIndex = 1
//        }
    }

    //////////// FUNCTION DEFINITIONS ////////////

    function removeBookmark(name) {
        var list = bookmarksOption.value
        list.splice(list.indexOf(name), 1)
        bookmarksOption.value = list
    }

    function addBookmark(name) {
        var list = bookmarksOption.value
        list.push(name)
        list.sort()
        bookmarksOption.value = list
    }

    // TODO: Package local copies of the icons?
    function getIcon(name, type) {
        if (type === undefined)
            type = "actions"

        return "/usr/share/icons/ubuntu-mobile/" + type + "/scalable/" + name + ".svg"
    }

    function search(text) {
        //searchPage.searchText = (text || "")
        // TODO: Better way to do this???
        //searchPage.search()
        //var result =
        tabs.selectedTabIndex = 3
        return Bible.search(text)
    }

    function goTo(verse) {
        biblePage.location = verse //
        tabs.selectedTabIndex = 1//wideAspect ? 0 : 1
        while (pageStack.depth > 1)
            pageStack.pop()
    }

    function saveRecentReadings() {
        recentReadingsOption.value = [biblePage.currentRegion.title]
        print("Recent readings:", recentReadingsOption.value)
    }

    //////////// CHILD OBJECTS ////////////

    property bool fullscreen: false

    property var pageStack: pageStack

    PageStack {
        id: pageStack

        Tabs {
            id: tabs

            Tab {
                title: page.title
                page: HomePage {
                    id: homePage
                    objectName: "homePage"
                }
            }

            Tab {
                title: page.title
                page: BiblePage {
                    id: biblePage
                    objectName: "biblePage"
                }
            }

            Tab {
                title: page.title
                page: ResourcesPage {
                    id: resourcesPage
                    objectName: "resourcesPage"
                }
            }
            Tab {
                 title: page.title
                 page: SearchPage {
                     id: searchPage
                     objectName: "searchPage"
                 }
                }
            Tab {
                 title: page.title
                 page: SettingsPage {
                     id: settingsPage
                     objectName: "settingsPage"
                 }
                }


            visible: false
        }

        Component.onCompleted: pageStack.push(tabs)
    }

    // TODO: When this actually gets merged into the Ubuntu UI Toolkit,
    // Remove the 'Extra.' prefix from this all all the Option objects
    Extra.Settings {
        Extra.Option {
            id: showVerseOption
            name: "showVerse"
            defaultValue: true
        }
        Extra.Option {
            id: strongsOption
            name: "showStrongs"
            defaultValue: false
            onValueChanged: {
                if (true){

                }
            }
        }
        Extra.Option {
            id: fontOption
            name: "userFont"
            defaultValue: "Liberation Serif"
        }
        Extra.Option {
            id: bibleVersionOption
            name: "bibleVersion"
            defaultValue: "KJV"

            onValueChanged: {
                if (value === "")
                    return

                if (App.availableBibles().indexOf(value) === -1) {
                    if (App.availableBibles().length > 0)
                        value = App.availableBibles()[0]
                    else
                        value = ""
                }
            }
        }

        Extra.Option {
            id: showReadingPlanOption
            name: "showReadingPlan"
            defaultValue: true
        }

        Extra.Option {
            id: recentReadingsOption
            name: "recentReadings"
            defaultValue: []
        }

        Extra.Option {
            id: showSidebarOption
            name: "showSidebar"
            defaultValue: true
        }

        Extra.Option {
            id: themeOption
            name: "theme"
            defaultValue: "Suru"
        }

        Extra.Option {
            id: bookmarksOption
            name: "bookmarks"
            defaultValue: []
        }
    }

    Extra.SettingsStorage {
        id: settingsStorage
    }
}
