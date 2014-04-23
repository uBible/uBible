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

Object {
    property string location: "Genesis 1:1"
    property string title: book + " " + chapter

    property string verse: {
        print ("Updating verse")
        if (location.lastIndexOf(':') !== -1) {
            return location.substring(location.lastIndexOf(':') + 1)
        } else {
            return ""
        }
    }

    property int startVerse: {

        if (verse === "") {
            return -1
        } else if (verse.lastIndexOf('-') !== -1) {
            print(verse.substring(0, verse.lastIndexOf('-')))
            return verse.substring(0, verse.lastIndexOf('-'))
        } else {
            return verse
        }
    }

    property int endVerse: {
        if (verse === "") {
            return -1
        } else if (verse.lastIndexOf('-') !== -1) {
            print(verse.substring(verse.lastIndexOf('-') + 1))
            return verse.substring(verse.lastIndexOf('-') + 1)
        } else {
            return verse
        }
    }

    property string book: {
        print ("Updating book")
        if (location.lastIndexOf(' ') !== -1) {
            return location.substring(0, location.lastIndexOf(' '))
        } else {
            return location
        }
    }
    property int chapter: {
        print ("Updating chapter")

        var bookChapter = ""

        if (location.lastIndexOf(':') === -1) {
            bookChapter = location
        } else {
            bookChapter = location.substring(0, location.lastIndexOf(':'))
        }

        if (bookChapter.lastIndexOf(' ') === -1) {
            return 1
        } else {
            return bookChapter.substring(bookChapter.lastIndexOf(' ') + 1)
        }
    }

    function inRange(verse) {
        return verse >= startVerse && verse <= endVerse
    }
}
