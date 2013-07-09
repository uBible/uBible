#ifndef MODULE_H
#define MODULE_H

#include <QObject>

#include <sword/swmodule.h>

class Module : public QObject
{
    Q_OBJECT
public:
    explicit Module(const QString &name, QObject *parent = 0);
    
    sword::SWModule *module() const { return m_module; }

signals:
    
public slots:
    
private:
    sword::SWModule *m_module;
};

#endif // MODULE_H
