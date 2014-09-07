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
#include <QDebug>

#include <sword/swmodule.h>
#include <sword/swmgr.h>

class BibleManager;

class Module : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(QString language READ language NOTIFY languageChanged)
    Q_PROPERTY(QString source READ source NOTIFY sourceChanged)
    Q_PROPERTY(bool installed READ installed NOTIFY installedChanged)

public:
    explicit Module(QObject *parent = nullptr) : QObject(parent) {}

    explicit Module(sword::SWModule *module, BibleManager *parent);

    QString name() const
    {
        return m_name;
    }

    QString description() const
    {
        return m_description;
    }

    bool installed() const
    {
        return m_installed;
    }

    QString language() const
    {
        return m_language;
    }

    QString source() const
    {
        return m_source;
    }

    sword::SWModule *module() const {
        qDebug() << "Module: " << m_module;
        return m_module;
    }

signals:

    void nameChanged(QString arg);

    void descriptionChanged(QString arg);

    void installedChanged(bool arg);

    void languageChanged(QString arg);

    void sourceChanged(QString arg);

public slots:

    void install();
    void uninstall();

    void setName(QString arg)
    {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged(arg);
        }
    }
    void setDescription(QString arg)
    {
        if (m_description != arg) {
            m_description = arg;
            emit descriptionChanged(arg);
        }
    }
    void setInstalled(bool arg)
    {
        if (m_installed != arg) {
            m_installed = arg;
            emit installedChanged(arg);
        }
    }

    void setLanguage(QString arg)
    {
        if (m_language != arg) {
            m_language = arg;
            emit languageChanged(arg);
        }
    }

    void setSource(QString arg)
    {
        if (m_source != arg) {
            m_source = arg;
            emit sourceChanged(arg);
        }
    }

private slots:

    void finished();

private:

    void install_background();

    QString m_name = "";

    QString m_description = "";
    BibleManager *m_manager = nullptr;

    bool m_installed = false;

    QString m_language;
    QString m_source;

public:
    sword::SWModule *m_module = nullptr;
};

#endif // MODULE_H
