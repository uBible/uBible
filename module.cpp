#include "module.h"

#include <QDebug>

#include <sword/swmgr.h>

Module::Module(const QString &name, QObject *parent) :
    QObject(parent)
{
    qDebug() << "Creating a new module:" << name;
    sword::SWMgr *library = new sword::SWMgr();
    m_module = library->getModule(qPrintable(name));
    Q_ASSERT(m_module != 0);
    qDebug() << "Module" << name << m_module->Name();
}
