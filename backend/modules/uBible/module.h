/*
 * Whatsoever ye do in word or deed, do all in the name of the
 * Lord Jesus, giving thanks to God and the Father by him.
 * - Colossians 3:17
 *
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef MODULE_H
#define MODULE_H

#include <QObject>

#include <sword/swmodule.h>

class Module : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool exists READ exists NOTIFY existsChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    explicit Module(const QString &name, QObject *parent = 0);
    
    sword::SWModule *module() const { return m_module; }

    bool exists() { return m_exists; }
    QString name() { return m_name; }

signals:
    void existsChanged(bool exists);
    void nameChanged(const QString& name);
    
public slots:

    void setName(const QString &name);
    
private:
    sword::SWModule *m_module;
    bool m_exists;
    QString m_name;
};

#endif // MODULE_H
