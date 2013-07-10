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

Popover {
    Bible {
        id: bible
    }

    Column {
        id: contents
        //height: 500

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Flickable {
            clip: true
            width: parent.width
            height: Math.min(contentHeight, 300)
            contentWidth: width
            contentHeight: selector.height

            ValueSelector {
                id: selector
                text: "Book"
                values: bible.books
            }
        }

        Standard {
            text: "Chapter"
            control: Slider {
                id: chapterSlider
                width: 200
                value: 1

                minimumValue: 1
                maximumValue: bible.chapterCount(selector.values[selector.selectedIndex])
            }
        }

        Standard {
            text: "Verse"
            control: Slider {
                width: 200
                value: 1
                minimumValue: 1
                maximumValue: bible.verseCount(selector.values[selector.selectedIndex], chapterSlider.value.toFixed(0))
            }
        }
    }
}
