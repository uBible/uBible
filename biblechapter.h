#ifndef BIBLECHAPTER_H
#define BIBLECHAPTER_H

#include <QObject>
#include <QAbstractListModel>

#include <sword/swmodule.h>
#include <sword/versemgr.h>

class BibleChapter : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(QString chapter READ chapter WRITE setChapter NOTIFY chapterChanged)

public:
    explicit BibleChapter(const QString &chapter, QObject *parent = 0);
    
    int rowCount(const QModelIndex &parent = QModelIndex()) const {

    }

    QString chapter() { return m_chapter; }

signals:
    void chapterChanged(const QString& chapter);
    
public slots:
    void setChapter(const QString& chapter) {
        m_chapter = chapter;

        emit chapterChanged(chapter);
    }
    

private:
    QString m_chapter;
    sword::SWModule *m_bible;
};

#endif // BIBLECHAPTER_H
