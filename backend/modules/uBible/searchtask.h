#ifndef SEARCHTASK_H
#define SEARCHTASK_H

#include <QObject>
#include "bible.h"

class SearchTask : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool busy READ busy NOTIFY busyChanged)

    Q_PROPERTY(Bible *bible READ bible WRITE setBible NOTIFY bibleChanged)

    Q_PROPERTY(QStringList results READ results NOTIFY resultsChanged)

public:
    explicit SearchTask(QObject *parent = 0);

    bool busy() const
    {
        return m_busy;
    }

    Bible * bible() const
    {
        return m_bible;
    }

    QStringList results() const
    {
        return m_results;
    }

public slots:

    void search(const QString &query);

    void setBible(Bible * arg)
    {
        if (m_bible != arg) {
            m_bible = arg;
            emit bibleChanged(arg);
        }
    }

signals:

    void busyChanged(bool arg);

    void bibleChanged(Bible * arg);

    void resultsChanged(QStringList arg);

protected slots:

    void setBusy(bool arg)
    {
        if (m_busy != arg) {
            m_busy = arg;
            emit busyChanged(arg);
        }
    }

private:

    void run(const QString &query);

    bool m_busy = false;
    Bible * m_bible = nullptr;
    QStringList m_results;
    QString m_query;
};

#endif // SEARCHTASK_H
