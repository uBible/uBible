#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "bible.h"
#include "bibleapp.h"
#include "biblechapter.h"

void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("uBible"));

    // @uri uBible
    qmlRegisterUncreatableType<BibleApp>(uri, 1, 0, "App", "Main utilities for the app");
    qmlRegisterType<Bible>(uri, 1, 0, "Bible");
    qmlRegisterType<BibleChapter>(uri, 1, 0, "BibleChapter");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
