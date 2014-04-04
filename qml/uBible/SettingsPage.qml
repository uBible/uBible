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
import "ubuntu-ui-extras" as Extra

// TODO: Update the switches and value selectors to use
// the action property with the actual option instead of
// having to manually sync the values
//TODO: add in font, and fontsize for VerseDelegate,
ComposerSheet {
    id: sheet
    title: i18n.tr("Settings")

    Component.onCompleted: {
        sheet.__leftButton.text = i18n.tr("Close")
        sheet.__leftButton.gradient = UbuntuColors.greyGradient
        sheet.__rightButton.text = i18n.tr("Confirm")
        sheet.__rightButton.color = sheet.__rightButton.__styleInstance.defaultColor
        sheet.__foreground.style = Theme.createStyleComponent(Qt.resolvedUrl("SuruSheetStyle.qml"), sheet)
    }

    onConfirmClicked: {
        bibleVersionOption.value = bibleVersionSelector.values[bibleVersionSelector.selectedIndex]
        showVerseOption.value = showVerseSwitch.checked
        showReadingPlanOption.value = showReadingPlanSwitch.checked
        themeOption.value = themeSelector.values[themeSelector.selectedIndex]
        strongsOption.value = strongsSwitch.checked
    }

    Flickable {
        id: flickable
        anchors {
            fill: parent
            margins: units.gu(-1)
        }
        clip: true
        contentHeight: column.height
        contentWidth: width
        interactive: contentHeight > height

        Column {
            id: column
            anchors.fill: parent

            Standard {
                id: versionText
                text: i18n.tr("Bible Version")
            }
            Extra.ValuesSpinner  {
                id: bibleVersionSelector
                values: App.availableBibles()
                selectedIndex: values.indexOf(bibleVersionOption.value)
                height: units.gu(15)
                anchors.right: column.horizontalCenter
            }

            Standard {
                text: i18n.tr("Verse of the Day")

                control: Switch {
                    id: showVerseSwitch
                    checked: showVerseOption.value
                }
            }

            Standard {
                text: i18n.tr("Reading Plan")

                control: Switch {
                    id: showReadingPlanSwitch
                    checked: showReadingPlanOption.value
                }
            }
            /*Standard {
                text: i18n.tr("Strongs Numbers")

                control: Switch {
                    id: strongsSwitch
                    checked: strongsOption.value
                }
            }*/
            ValueSelector {
                id: themeSelector
                text: i18n.tr("Theme")
                values: ["Suru", "Dark", "Light"]
                selectedIndex: values.indexOf(themeOption.value)
            }

        }
    }
}
