#include "biblechapter.h"

BibleChapter::BibleChapter(const QString &chapter, QObject *parent) :
    QAbstractListModel(parent)
{
    setChapter(chapter);
}
