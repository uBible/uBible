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

#ifndef BIBLE_H
#define BIBLE_H

#include "module.h"

#include <QObject>
#include <QStringList>

#include <sword/swmodule.h>
#include <sword/versekey.h>

class Bible : public Module
{
    Q_OBJECT

    Q_PROPERTY(QStringList books READ books)

public:
    explicit Bible(const QString &name = "KJV", QObject *parent = 0);

    Q_INVOKABLE unsigned int chapterCount(const QString &book) const {
        return chapterCount(bookNumber(book));
    }

    Q_INVOKABLE unsigned int chapterCount(int book) const;

    Q_INVOKABLE unsigned int verseCount(const QString &book, int chapter) const {
        return verseCount(bookNumber(book), chapter);
    }

    Q_INVOKABLE unsigned int verseCount(int book, int chapter) const;

    Q_INVOKABLE unsigned int bookNumber(const QString &book) const;

    Q_INVOKABLE QStringList books();

    Q_INVOKABLE QString verse(const QString &book, int chapter, int verse) {
        return this->verse(bookNumber(book), chapter, verse);
    }

    Q_INVOKABLE QString verse(int book, int chapter, int verse);

    Q_INVOKABLE QStringList search(const QString &phrase);

    Q_INVOKABLE QString verse(const QString &verse);

signals:
    
public slots:

private slots:
    void onNameChanged(const QString &name);

private:
    void initBounds();

    QStringList *m_bookList;
    bool m_hasOT;
    bool m_hasNT;
    sword::VerseKey m_lowerBound;
    sword::VerseKey m_upperBound;

    bool m_boundsInitialized;
};

#endif // BIBLE_H
