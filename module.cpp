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
