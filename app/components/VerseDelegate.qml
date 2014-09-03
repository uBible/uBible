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
import "../ubuntu-ui-extras" as Extra

Empty {
    id: verseDelegate

    property string fontsize: "large"
    property int verse: index + 1
    property string text: model.verse

    height: units.gu(0.5) + verse.height
    selected: selectedRegion.inRange(index + 1)
    property bool current: currentRegion.inRange(index + 1)

    property bool bookmarked: settings.bookmarks.indexOf(verseToString(verseDelegate.verse)) !== -1

    onClicked: {
        PopupUtils.open(versePopover, verseDelegate,
                        {
                            text: verseDelegate.text,
                            verse: verseDelegate.verse
                        })
    }

    /*
     * TODO: When playing the current verse, replace
     * the number with an audio symbol
     */
    PinchArea{
        anchors.fill: parent
        onPinchUpdated: { //TODO: does this work?
            var pinchVar = pinch.scale
            if (pinchVar === 1.0){
                fontsize = "large"
            }
            else if (pinchVar === 2.0){
                fontsize = "x-large"
            }
            else if (pinchVar >= -1.0 && pinchVar >= 1.0){
                fontsize = "medium"
            }
        }
    Label {
        id: number
        text: verseDelegate.verse
        color: textColor
        font.bold: true
        visible: !bookmarked

        anchors {
            left: parent.left
            leftMargin: units.gu(1)
            top: verse.top
            //topMargin: units.gu(0.5)
        }
    }

    ColorizedImage {
        anchors {
            left: parent.left
            leftMargin: units.gu(0.5)
            verticalCenter: number.verticalCenter
        }
        visible: bookmarked
        color: textColor
        width: units.gu(2)
        height: width
        source: getIcon("starred")
    }

    Rectangle {
        anchors {
            fill: verse
            leftMargin: units.gu(-0.5)
            bottomMargin: units.gu(-0.4)
            topMargin: units.gu(-0.1)
        }
        color: Qt.rgba(0.2,0.2,0.2,0.5)
        visible: selectedRegion.inRange(verse)
    }

    Label {
        id: verse

        anchors {
            left: parent.left
            leftMargin: units.gu(4)
            right: parent.right
            rightMargin: units.gu(1)
            top: parent.top
            topMargin: units.gu(0.25)
        }

        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        /*
         * FIXME: When using textFormat: Text.RichText,
         * the label doesn't redraw itself when the width
         * increases, so this is needed to trick it into
         * redrawing.
         *
         * This is probably a bug in Qt's QtQuick.Text
         * component.
         */
        onWidthChanged: {
            //text = ""
            //text = Qt.binding(function() { return model.verse })
        }

        text: verseDelegate.text
        textFormat: Text.PlainText
        //font.family: userFont //change this in settings
        fontSize: fontsize //have this change with pinch gesture
        color: currentRegion.inRange(verseDelegate.verse) ? selectionColor : textColor

        Behavior on color {
            ColorAnimation { duration: 500 }
        }
    }
}
    showDivider: false
}

