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

#ifndef BIBLEAPP_H
#define BIBLEAPP_H

#include <QObject>
#include <QStringList>

class BibleApp : public QObject
{
    Q_OBJECT

private:
    Q_DISABLE_COPY(BibleApp)
    explicit BibleApp(QObject* parent = 0);


public:
    static BibleApp& instance() {
        static BibleApp instance;
        return instance;
    }

    Q_INVOKABLE QString verse(const QString &verse);
    Q_INVOKABLE QStringList availableBibles();
    
signals:
    
public slots:
    
};

#endif // BIBLEAPP_H
