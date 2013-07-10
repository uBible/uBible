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

#ifndef BIBLECHAPTER_H
#define BIBLECHAPTER_H

#include <QObject>
#include <QAbstractListModel>
#include <QDebug>

#include <sword/swmodule.h>
#include <sword/versemgr.h>

#include "bible.h"

class BibleChapter : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int chapter READ chapter WRITE setChapter NOTIFY chapterChanged)
    Q_PROPERTY(QString book READ book WRITE setBook NOTIFY bookChanged)

    enum BibleVerseRoles {
        VerseRole = Qt::UserRole + 1
    };

public:
    explicit BibleChapter(Bible *bible, const QString &book, int chapter, QObject *parent = 0);
    explicit BibleChapter(QObject *parent = 0): BibleChapter(new Bible("KJV"), "Genesis", 1, parent) {}

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const {
        //qDebug() << "LENGTH!";
        if (bible() == 0)
            return 0;
        return bible()->verseCount(book(), chapter());
    }

    virtual QHash<int,QByteArray> roleNames() const {
        QHash<int, QByteArray> roles;
        roles[VerseRole] = "verse";
        //qDebug() << "ROLES:" << roles;
        return roles;
    }

    virtual QVariant data(const QModelIndex &index, int role) const {
        //qDebug() << "Data" << index.row() << role;
        return QVariant(bible()->verse(book(), chapter(), index.row() + 1));
    }

    int chapter() const { return m_chapter; }
    QString book() const { return m_book; }
    Bible *bible() const { return m_bible; }

signals:
    void chapterChanged(int chapter);
    void bookChanged(const QString& book);
    
public slots:
    void setChapter(int chapter) {
        beginResetModel();
        m_chapter = chapter;
        endResetModel();

        emit chapterChanged(chapter);
    }
    
    void setBook(const QString& book) {
        beginResetModel();
        m_book = book;
        endResetModel();

        emit bookChanged(book);
    }

private:
    int m_chapter;
    QString m_book;
    Bible *m_bible;
};

#endif // BIBLECHAPTER_H
