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

signals:
    
public slots:

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
