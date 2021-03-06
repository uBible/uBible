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

#include "bible.h"

#include <QDebug>
#include <QSharedPointer>

#include <sword/gbfplain.h>
#include <swmgr.h>
#include <swmodule.h>
#include <swfilter.h>
#include <versekey.h>
#include <sword/gbfredletterwords.h>

using namespace sword;

Bible::Bible(SWModule *module, BibleManager *parent)
    : Module(module, parent)
{
    sword::GBFRedLetterWords *option = new sword::GBFRedLetterWords();
    option->setOptionValue("On");
    module->AddRenderFilter(option);

    qDebug() << "In constructor" << this << m_module;
}

QStringList Bible::books() {
    // Code taken from BibleTime
    if (m_bookList.size() == 0) {
        qDebug() << "Creating book list...";

        // Initialize m_hasOT and m_hasNT
        if (!m_boundsInitialized)
            initBounds();

        if (module() == nullptr) {
            qWarning("Bible not found: %s", qPrintable(name()));
            return m_bookList;
        }

        int min = 1; // 1 = OT
        int max = 2; // 2 = NT

        if (!m_hasOT)
            min++; // min == 2

        if (!m_hasNT)
            max--; // max == 1

        if (min > max) {
            qWarning("Bible (%s) no OT and no NT! Check your config!", module()->Name());
        } else {
            QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
            key->setPosition(sword::TOP);

            for (key->setTestament(min); !key->Error() && key->getTestament() <= max; key->setBook(key->getBook() + 1)) {
                m_bookList.append( QString::fromUtf8(key->getBookName()) );
            }
        }
    }

    return m_bookList;
}

void Bible::initBounds() {
    // Code taken from BibleTime
    Q_ASSERT(!m_boundsInitialized);

    qDebug() << "Initializing bounds...";

    sword::SWModule *m = module();

    if (m == NULL) {
        return;
    }

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

    qDebug() << this;
    qDebug() << "Book" << book << m_module;

    if (book == 0 || book.isEmpty() || module() == nullptr) {
        return 0;
    }

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    key->setBookName(book.toUtf8().constData());

    bookNumber = ((key->getTestament() > 1) ? key->BMAX[0] : 0) + key->getBook();

    //qDebug() << book << "is number" << bookNumber;
    return bookNumber;
}

unsigned int Bible::chapterCount(int bookNumber) const {
    // Code taken from BibleTime
    int result = 0;

    if (module() == 0) return 0;

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    // works for old and new versions
    key->setBook(bookNumber);
    key->setPosition(sword::MAXCHAPTER);
    result = key->getChapter();

    //qDebug() << bookNumber << "has" << result << "chapters";
    return result;
}

unsigned int Bible::verseCount(int book, int chapter) const {
    // Code taken from BibleTime
    unsigned int result = 0;

    if (module() == 0) return 0;

    QSharedPointer<sword::VerseKey> key((sword::VerseKey *)module()->CreateKey());
    key->setPosition(sword::TOP);

    // works for old and new versions
    key->setBook(book);
    key->setChapter(chapter);
    key->setPosition(sword::MAXVERSE);
    result = key->getVerse();

    //qDebug() << book << chapter << "has" << result << "verses";
    return result;
}

QString Bible::verse(int book, int chapter, int verse) {
    sword::VerseKey key;
    key.setPosition(sword::TOP);
    key.setBook(book);
    key.setChapter(chapter);
    key.setVerse(verse);

    qDebug() << "In verse()";

    if (module() == nullptr) {
        qWarning() << "Module is null!";
        return "No Bibles installed";
    }
    qDebug() << "Not null";


    module()->setKey(key);
    module()->addRenderFilter(new GBFPlain());
    QString contents(module()->renderText());

    if (contents == "")
        return "Module not supported: " + name();
    else
        return contents;
}

QStringList Bible::search(const QString &phrase) {
    qDebug() << "Doing search...";
    sword::SWMgr *library = new sword::SWMgr();

    sword::SWModule *module = library->getModule(this->module()->getName());

    sword::ListKey searchResults = module->search(qPrintable(phrase), 2);

    qDebug() << "Setting key...";
    module->setKey(searchResults);
    module->addRenderFilter(new GBFPlain()); //search results

    QStringList results;
    for (searchResults = TOP; !searchResults.popError(); searchResults++) {
        module->setKey(searchResults);

        results.append(QString((const char *) searchResults));
    }

    qDebug() << "List: " << results;

    delete module;

    return results;
}

QString Bible::verse(const QString &verse) {
    qDebug() << "Getting verse" << verse;

    if (module() == nullptr) {
        return "No Bibles installed.";
    }

    SWKey key(qPrintable(verse));

    qDebug() << "Setting key" << qPrintable(verse);

    module()->setKey(key);
    module()->addRenderFilter(new GBFPlain());
    qDebug() << "Returning result";
    QString contents(module()->renderText());

    if (contents == "")
        return "Module not supported: " + name();
    else
        return contents;

}

