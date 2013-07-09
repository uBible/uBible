#include "bibleapp.h"

#include <QDebug>

#include <swmgr.h>
#include <swmodule.h>
#include <swfilter.h>
#include <gbfplain.h>
#include <versekey.h>

using namespace sword;

BibleApp::BibleApp(QObject *parent) :
    QObject(parent)
{
}

QString BibleApp::verse(const QString &verse) {
    SWMgr library;
    SWModule *kjv = library.getModule("KJV");
    kjv->AddRenderFilter(new GBFPlain());
    kjv->setKey(qPrintable(verse));
    return kjv->RenderText();
}
