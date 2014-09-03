#include "searchtask.h"

#include <QtConcurrent/QtConcurrent>

SearchTask::SearchTask(QObject *parent) :
    QObject(parent)
{
}

void SearchTask::search(const QString &query)
{
    QFuture<void> future = QtConcurrent::run(this, &SearchTask::run, query);
}

void SearchTask::run(const QString &query) {
    setBusy(true);

    // Clear the list immediately
    m_results = QStringList();

    m_results = this->bible()->search(query);

    setBusy(false);
    resultsChanged(m_results);
}
