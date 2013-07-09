#include "bible.h"

#include <QDebug>
#include <QSharedPointer>

Bible::Bible(const QString& name, QObject *parent) :
    Module(name, parent),
    m_bookList(0), m_hasOT(false), m_hasNT(false), m_boundsInitialized(false)
{
}

QStringList Bible::books() {
    // Code taken from BibleTime
    if (!m_bookList) {
        qDebug() << "Creating book list...";
        m_bookList = new QStringList();

        // Initialize m_hasOT and m_hasNT
        if (!m_boundsInitialized)
            initBounds();

        int min = 1; // 1 = OT
        int max = 2; // 2 = NT

        if (!m_hasOT)
            min++; // min == 2

        if (!m_hasNT)
            max--; // max == 1

        if (min > max) {
            qWarning("Bible (%s) no OT and not NT! Check your config!", module()->Name());
        } else {
            QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
            key->setPosition(sword::TOP);

            for (key->setTestament(min); !key->Error() && key->getTestament() <= max; key->setBook(key->getBook() + 1)) {
                m_bookList->append( QString::fromUtf8(key->getBookName()) );
            }
        }
    }

    return *m_bookList;
}

void Bible::initBounds() {
    // Code taken from BibleTime
    Q_ASSERT(!m_boundsInitialized);

    sword::SWModule *m = module();
    const bool oldStatus = m->getSkipConsecutiveLinks();
    m->setSkipConsecutiveLinks(true);

    m->setPosition(sword::TOP); // position to first entry
    sword::VerseKey key(module()->getKeyText());
    m_hasOT = (key.getTestament() == 1);

    m->setPosition(sword::BOTTOM);
    key = module()->getKeyText();
    m_hasNT = (key.getTestament() == 2);

    m->setSkipConsecutiveLinks(oldStatus);

    m_lowerBound = (m_hasOT ? "Genesis 1:1" : "Matthew 1:1");
    m_upperBound = (!m_hasNT ? "Malachi 4:6" : "Revelation of John 22:21");

    m_boundsInitialized = true;
}

unsigned int Bible::bookNumber(const QString &book) const {
    // Code taken from BibleTime
    unsigned int bookNumber = 0;

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    key->setBookName(book.toUtf8().constData());

    bookNumber = ((key->getTestament() > 1) ? key->BMAX[0] : 0) + key->getBook();

    qDebug() << book << "is number" << bookNumber;
    return bookNumber;
}

unsigned int Bible::chapterCount(int bookNumber) const {
    // Code taken from BibleTime
    int result = 0;

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    // works for old and new versions
    key->setBook(bookNumber);
    key->setPosition(sword::MAXCHAPTER);
    result = key->getChapter();

    qDebug() << bookNumber << "has" << result << "chapters";
    return result;
}

unsigned int Bible::verseCount(int book, int chapter) const {
    // Code taken from BibleTime
    unsigned int result = 0;

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    // works for old and new versions
    key->setBook(book);
    key->setChapter(chapter);
    key->setPosition(sword::MAXVERSE);
    result = key->getVerse();

    qDebug() << book << chapter << "has" << result << "verses";
    return result;
}
