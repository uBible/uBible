#ifndef BIBLEAPP_H
#define BIBLEAPP_H

#include <QObject>

class BibleApp : public QObject
{
    Q_OBJECT

public:
    explicit BibleApp(QObject *parent = 0);

    Q_INVOKABLE QString verse(const QString &verse);
    
signals:
    
public slots:
    
};

#endif // BIBLEAPP_H
