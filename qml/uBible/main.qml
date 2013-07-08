/*
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers. See the
 * COPYRIGHT file at the top-level directory of this distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
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

    width: units.gu(50)
    height: units.gu(75)

    function icon(name) {
        return "/usr/share/icons/ubuntu-mobile/actions/scalable/" + name + ".svg"
    }

    property variant tabs: tabs
    property variant tabsPage: tabsPage
    property variant homePage: homePage
    property variant biblePage: biblePage
    property variant searchPage: searchPage

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

    function search(text) {
        searchPage.searchText = (text || "")
        // TODO: Better way to do this???
        tabs.selectedTabIndex = 2
        searchPage.search()
    }
}
