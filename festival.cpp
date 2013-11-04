/*
 * Whatsoever ye do in word or deed, do all in the name of the
 * Lord Jesus, giving thanks to God and the Father by him.
 * - Colossians 3:17
 *
 * uBible - Bible application for Ubuntu Touch
 * Copyright (C) 2013 The uBible Developers.
 *
 * Special Thanks to Jospeh Mills for the framework for accessing system programs
 *  https://launchpad.net/~josephjamesmills
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
#include "bibleapp.h"
#include "festival.h"
#include    <QProcess>
//later add --language and a language variable, once we implement other languages
ScriptLauncher::ScriptLauncher(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}
void ScriptLauncher::launchScript(QString echo, QString bverse, QString program, QString argum)
{
    QString festContent;
    festContent.append(echo);
    festContent.append(bverse);
    festContent.append(program);
    festContent.append(argum);
    //m_process->start(festContent);
    m_process->start("echo \"  The Revelation of Jesus Christ, which God gave unto him, to shew unto his servants things which must shortly come to pass; and he sent and signified it by his angel unto his servant John:  \" | /usr/bin/festival  --tts ");
}
void ScriptLauncher::stopScript(){
    //m_process->kill();  not sure how to do this
}
