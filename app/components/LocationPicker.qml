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
import Ubuntu.Components.Pickers 0.1
import uBible 1.0
import "../ubuntu-ui-extras"

/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

StyledItem {
    id: datePicker

    property alias location: pointer.location
    property int selectedIndex: 0//bookSpinner.selectedIndex
    Location {
        id: pointer

        location: biblePage.location
    }

    function getLocation() {
        return location
    }

    property var bible: settings.bible

    /*!
      \qmlproperty bool moving
      \readonly
      The property holds whether the component's pickers are moving.
      \sa Picker::moving
      */
    readonly property alias moving: positioner.moving

    implicitWidth: units.gu(36)
    implicitHeight: units.gu(20)


    Component.onCompleted: {
        internals.completed = true;
        tumblerModel.setPickerModel(bookModel, "BookPicker", 0)
        tumblerModel.setPickerModel(chapterModel, "ChapterPicker", 1)
        for (var i = 0; i < tumblerModel.count; i++) {
            var model = tumblerModel.get(i).pickerModel
            var pickerItem = model.pickerItem;
            pickerItem.resetPicker();
            pickerItem.positionViewAtIndex(model.indexOf(), PathView.Center);
        }
    }

    style: SuruDatePickerStyle {}

    Binding {
        target: __styleInstance
        property: "view"
        value: positioner
    }
    Binding {
        target: __styleInstance
        property: "pickerModels"
        value: tumblerModel
    }

    PickerModelBase {
        id: bookModel
        circular: false
        pickerWidth: units.gu(20)
        property int selectedIndex

        onSelectedIndexChanged: {
            pointer.location = "%1 %2".arg(get(selectedIndex).book).arg(pointer.chapter)
            chapterModel.reset()
        }

        function reset() {
            resetting = true;

            clear();
            var list = bible.books
            for (var i = 0; i < list.length; i++) {
                append({"book": list[i]});
            }

            if (list.length == 0)
                append({"book": "EMPTY"})

            resetting = false;
        }

        function text(modelData) {
            return modelData
        }

        function indexOf() {
            print("INDEX OF")
            print(pointer.book)
            print(bible.books.indexOf(pointer.book))
            return bible.books.indexOf(pointer.book)
        }

        mainComponent: datePicker
        pickerCompleted: internals.completed

    }

    PickerModelBase {
        id: chapterModel
        circular: false
        pickerWidth: units.gu(5)

        property int selectedIndex

        onSelectedIndexChanged: {
            pointer.location = "%1 %2".arg(pointer.book).arg(get(selectedIndex).chapter)
        }

        function reset() {
            resetting = true;

            clear();
            var count = bible.chapterCount(pointer.book)
            for (var i = 0; i < count; i++) {
                append({"chapter": i + 1});
            }

            if (count == 0)
                append({"chapter": "EMPTY"})

            resetting = false;
        }

        function text(modelData) {
            return modelData
        }

        function indexOf() {
            return pointer.chapter - 1
        }

        mainComponent: datePicker
        pickerCompleted: internals.completed
    }

    // tumbler positioner
    PickerRow {
        id: positioner
        parent: (datePicker.__styleInstance && datePicker.__styleInstance.hasOwnProperty("tumblerHolder")) ?
                    datePicker.__styleInstance.tumblerHolder : datePicker
        mainComponent: datePicker
        model: tumblerModel
        margins: internals.margin
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    ListModel {
        /*
              Model to hold tumbler order for repeaters.
              Roles:
              - pickerModel
              - pickerName
              */
        id: tumblerModel

        /*
          Signal triggered when the model is about to remove a picker. We cannot rely on
          rowAboutToBeRemoved, as by the time the signal is called the list element is
          already removed from the model.
          */
        signal pickerRemoved(int index)

        // the function checks whether a pickerModel was added or not
        // returns the index of the model object the pickerModel was found
        // or -1 on error.
        function pickerModelIndex(name) {
            for (var i = 0; i < count; i++) {
                if (get(i).pickerName === name) {
                    return i;
                }
            }
            return -1;
        }

        // the function checks whether a pickerModel is present in the list;
        // moves the existing one to the given index or inserts it if not present
        function setPickerModel(model, name, index) {
            var idx = pickerModelIndex(name);
            if (idx >= 0) {
                move(idx, index, 1);
            } else {
                print(name)
                print(model.count)
                append({"pickerModel": model, "pickerName": name});
            }
            print("Done")
        }

        // removes the given picker
        function removePicker(name) {
            var idx = pickerModelIndex(name);
            if (idx >= 0) {
                pickerRemoved(idx);
                remove(idx);
            }
        }
    }

    // component to calculate text fitting
    Label { id: textSizer; visible: false }
    QtObject {
        id: internals
        property bool completed: false
        property real margin: units.gu(1.5)
    }
}
