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
    this->m_query = query;

    // Clear the list immediately
    m_results = QStringList();
    resultsChanged(m_results);

    QStringList results = this->bible()->search(query);

    if (query == this->m_query) {
        m_results = results;

        setBusy(false);
        resultsChanged(m_results);
    }
}
