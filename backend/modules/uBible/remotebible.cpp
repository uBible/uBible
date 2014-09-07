#include "remotebible.h"

#include <QtConcurrent/QtConcurrent>

#include "biblemanager.h"

RemoteBible::RemoteBible(BibleManager *parent) :
    QObject(parent)
{
    m_manager = parent;
}

void RemoteBible::install() {
    QFuture<void> future = QtConcurrent::run(this, &RemoteBible::install_background);
    QFutureWatcher<void> *watcher = new QFutureWatcher<void>(this);

    connect(watcher, SIGNAL(finished()), this, SLOT(finished()));
    watcher->setFuture(future);
}

void RemoteBible::install_background() {
    m_manager->installModule(this->source(), this->name());
}

void RemoteBible::finished() {
    setInstalled(true);
}
