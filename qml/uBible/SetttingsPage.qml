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
import Ubuntu.Components.Popups 0.1

// TODO: Update the switches and value selectors to use
// the action property with the actual option instead of
// having to manually sync the values
Page {
    id: root
    title: i18n.tr("Settings")

    Column {
        anchors.fill: parent

        ValueSelector {
            id: bibleVersionSelector
            text: i18n.tr("Bible Version")
            values: App.availableBibles()//["KJV", "ESV"]
            selectedIndex: values.indexOf(bibleVersionOption.value)
            onSelectedIndexChanged: {
                bibleVersionOption.value = values[selectedIndex]
            }
        }

        Standard {
            text: i18n.tr("Verse of the Day")

            control: Switch {
                id: showVerseSwitch
                checked: showVerseOption.value
                onCheckedChanged: {
                    showVerseOption.value = showVerseSwitch.checked
                }
            }
        }

        Standard {
            text: i18n.tr("Reading Plan")

            control: Switch {
                id: showReadingPlanSwitch
                checked: showReadingPlanOption.value
                onCheckedChanged: {
                    showReadingPlanOption.value = showReadingPlanSwitch.checked
                }
            }
        }

//        Standard {
//            text: i18n.tr("Sidebar in Desktop layout")
//            control: Switch {
//                id: showSidebarSwitch
//                checked: showSidebar
//            }
//        }
    }
}
