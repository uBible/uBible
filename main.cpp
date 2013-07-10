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

#include <QtGui/QGuiApplication>
#include <QtQml/QQmlContext>
#include <QtQml>
#include "qtquick2applicationviewer.h"

#include <QDebug>

#include "bibleapp.h"
#include "bible.h"
#include "biblechapter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<Bible>("uBible", 1, 0, "Bible");
    qmlRegisterType<BibleChapter>("uBible", 1, 0, "BibleChapter");

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("App", new BibleApp());
    viewer.setMainQmlFile(QStringLiteral("qml/uBible/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
