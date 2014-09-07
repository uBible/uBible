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
#include <QStandardPaths>
#include <QDir>
#include <QtConcurrent/QtConcurrent>

#include <sword/swmgr.h>

#include "biblemanager.h"

Module::Module(sword::SWModule *module, BibleManager *parent) :
    QObject()
{
    m_module = module;
    m_manager = parent;
}

void Module::install() {
    QFuture<void> future = QtConcurrent::run(this, &Module::install_background);
    QFutureWatcher<void> *watcher = new QFutureWatcher<void>(this);

    connect(watcher, SIGNAL(finished()), this, SLOT(finished()));
    watcher->setFuture(future);
}

void Module::install_background() {
    m_manager->installModule(this->source(), this->name());
}

void Module::finished() {
    setInstalled(true);
}
