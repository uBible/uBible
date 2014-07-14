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
import Ubuntu.Components.ListItems 0.1
import uBible 1.0
import "../ubuntu-ui-extras" as Extra

Page {
    id: root
    title: i18n.tr("Resources")

    property var quickverses: {
        "Creation": "Genesis 1",
        "Christ's Work": {

        },
        "How to be Saved": {
            "John 3:16":"John 3:16",
            "By faith alone": "Romans 10:9-10",
            "Saved by faith, not works": "Ephesians 2:8-9"
        },
        "The Return of Christ": {

        },
        "Judgement": {
            "The wages of sin is death": "Romans 6:23"
        },
        "Eternal Life": {
            "Christ has destroyed the power of death": "1 Corinthians 15:50-57"
        }
    }

    Column {
        anchors.fill: parent

        Standard {
            text: i18n.tr("Quick Reference")
            progression: true

            onClicked: {
                pageStack.push(Qt.resolvedUrl("QuickReferencePage.qml"), {
                                   ref: quickverses,
                                   title: i18n.tr("Quick Reference")
                               })
            }
        }
    }
}
