#include "biblechapter.h"

#include <QDebug>

BibleChapter::BibleChapter(Bible *bible, const QString &book, int chapter, QObject *parent) :
    QAbstractListModel(parent),
    m_bible(bible), m_book(book), m_chapter(chapter)
{
    qDebug() << "BIBLE:" << m_bible;
}
