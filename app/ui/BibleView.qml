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
import Ubuntu.Components.ListItems 0.1
import uBible 1.0

import "../components"

Item {
    id: root

    property variant flickable: list

    function goTo() {
        list.positionViewAtIndex(currentRegion.startVerse - 1, ListView.Beginning)
    }

    Rectangle {
        anchors.fill: parent
        color: themeOption.value === "Light" ? "white" : "transparent"
    }

    Label {
        anchors.centerIn: parent

        fontSize: "large"

        /*
         * TODO: Once a module manager is created, remove
         * the references to SWORD and modules (extra unneeded
         * details) and add a button/link to the module manager
         */
        text: bibleChapter.version == ""
              ? i18n.tr("<b>No Bibles are installed!</b><p>Open the Bible manager to install a Bible.")
              : i18n.tr("<b>The %1 Bible is not installed!</b><p>Open the Bible manager to install the Bible or choose a different version in Settings.").arg(bibleChapter.version)
        width: Math.min(implicitWidth, parent.width - units.gu(2))
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        visible: !bibleChapter.bible.exists
    }

    ListView {
        id: list
        anchors.fill: parent

        model: bibleChapter.bible.exists ? bibleChapter : null
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

        delegate: VerseDelegate {

        }
    }

    Scrollbar {
        flickableItem: list
    }
}
