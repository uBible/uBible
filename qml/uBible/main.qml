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

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the .desktop filename
    applicationName: "uBible"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    automaticOrientation: true

    property bool wideAspect: width >= units.gu(80)

    width: units.gu(100)
    height: units.gu(75)

    property string bibleVersion: "ESV"
    property bool showVerse: true
    property bool showReadingPlan: false
    property var recentReadings: []
    property bool showSidebar: true

    property variant tabs: tabs
    property variant tabsPage: tabsPage
    property variant homePage: homePage
    property variant biblePage: biblePage
    property variant searchPage: searchPage

    property bool fullscreen: false

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
            page: SearchPage {
                id: searchPage
                objectName: "searchPage"
            }
        }
    }

    Component {
        id: settingsSheet

        SetttingsSheet {
            objectName: "settingsSheet"
        }
    }

    function icon(name) {
        return "/usr/share/icons/ubuntu-mobile/actions/scalable/" + name + ".svg"
    }

    function search(text) {
        searchPage.searchText = (text || "")
        // TODO: Better way to do this???
        tabs.selectedTabIndex = 2
        searchPage.search()
    }

    function goTo(verse) {
        biblePage.goTo(verse)
    }

    function showSettings() {
        PopupUtils.open(settingsSheet)
    }

    function saveSetting(name, value) {
        if (getSetting(name) !== value) {
            print(name, "=>", value)
            var tempContents = {}
            tempContents = settings.contents
            tempContents[name] = value
            settings.contents = tempContents

            reloadSettings()
        }
    }

    function reloadSettings() {
        showVerse = getSetting("showVerse") === "true" ? true : false
        print("showVerse <=", showVerse)

        bibleVersion = getSetting("bibleVersion")
        if (App.availableBibles().indexOf(bibleVersion) === -1) {
            if (App.availableBibles().length > 0)
                bibleVersion = App.availableBibles()[0]
            else
                bibleVersion = ""
        }
        print("bibleVersion <=", bibleVersion)

        showReadingPlan = getSetting("showReadingPlan") === "true" ? true : false
        print("showReadingPlan <=", showReadingPlan)

        recentReadings = JSON.parse(getSetting("recentReadings"))
        print("recentReadings <=", recentReadings)

        //TODO: Remove setting or uncomment???
        showSidebar = true//getSetting("showSidebar") === "true" ? true : false
        print("showSidebar <=", showSidebar)
    }

    function saveRecentReadings() {
        recentReadings = [biblePage.bookChapter]

        saveSetting("recentReadings", JSON.stringify(recentReadings))
    }

    Component.onDestruction: {
        saveRecentReadings()
    }

    U1db.Database {
        id: storage
        path: "ubible"
    }

    U1db.Document {
        id: settings

        database: storage
        docId: 'settings'
        create: true

        defaults: {
            "showVerse": "true",
            "bibleVersion": "KJV",
            "showReadingPlan": "true",
            "recentReadings": JSON.stringify([]),
            "showSidebar": "true"
        }
    }

    function getSetting(name) {
        var tempContents = {};
        tempContents = settings.contents
        return tempContents.hasOwnProperty(name) ? tempContents[name] : settings.defaults[name]
    }

    Component.onCompleted: {
        if (wideAspect) {
            tabs.selectedTabIndex = 1
        }


        reloadSettings()
    }
}
