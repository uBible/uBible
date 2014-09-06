#include "biblemanager.h"

#include <QVariantList>
#include <QVariantMap>
#include <QDebug>
#include <QtConcurrent/QtConcurrent>

using namespace sword;

class CustomInstallManager: public InstallMgr
{
public:
    explicit CustomInstallManager(BibleManager *manager) {
        m_manager = manager;
    }

    virtual bool isUserDisclaimerConfirmed() const {
        return m_manager->confirmedPermission();
    }

private:
    BibleManager *m_manager;
};

BibleManager::BibleManager(QObject *parent) :
    QObject(parent)
{
    this->loadAvailableBibles();

    m_manager = new SWMgr();
    m_installManager = new CustomInstallManager(this);
}

BibleManager::~BibleManager() {
    delete m_installManager;
}

void BibleManager::refresh() {
    QtConcurrent::run(this, &BibleManager::run);
}

void BibleManager::run() {
    setStatus("Refreshing sources....");
    setBusy(true);

    qDebug() << "Loading remote sources..." << m_installManager->isUserDisclaimerConfirmed();
    int result = m_installManager->refreshRemoteSourceConfiguration();
    qDebug() << "Done: " << result;

    InstallSourceMap sources = m_installManager->sources;

    for (std::pair<SWBuf, InstallSource *> pair : sources) {
        qDebug() << pair.second->caption;
        setStatus(QString("Refreshing ") + QString(pair.second->caption));
        m_installManager->refreshRemoteSource(pair.second);
        SWMgr *source = pair.second->getMgr();

        std::map<SWModule *, int> mods = InstallMgr::getModuleStatus(*m_manager, *source);
        for (std::map<SWModule *, int>::iterator it = mods.begin(); it != mods.end(); it++) {
                SWModule *module = it->first;
                SWBuf version = module->getConfigEntry("Version");
                SWBuf status = " ";
                if (it->second & InstallMgr::MODSTAT_NEW) status = "*";
                if (it->second & InstallMgr::MODSTAT_OLDER) status = "-";
                if (it->second & InstallMgr::MODSTAT_UPDATED) status = "+";

                if (true || status == "*" || status == "+") {
                    qDebug() << status << "[" << module->getName() << "]  \t(" << version << ")  \t- " << module->getDescription() << "\n";
                }
        }

    }

    setBusy(false);
}

QVariantList BibleManager::loadRemoteBibles(SWMgr *library) {
    QVariantList list;
    ModMap modules = library->Modules;
    ModMap::iterator it;
    SWModule *curMod = 0;

    for (it = modules.begin(); it != modules.end(); it++) {
        curMod = (*it).second;
        if (!strcmp(curMod->getType(), "Biblical Texts")) {
            QVariantMap json;
            json.insert("name", QVariant(curMod->getName()));
            json.insert("description", QVariant(curMod->getDescription()));

            list.append(json);
        } else if (!strcmp(curMod->getType(), "Commentaries")) {
            // do RenderTextsomething with curMod
        } else if (!strcmp(curMod->getType(), "Lexicons / Dictionaries")) {
            // do something with curMod
        }
    }

    return list;
}


void BibleManager::loadAvailableBibles() {
    QVariantList list;

    SWMgr library;
    ModMap modules = library.Modules;
    ModMap::iterator it;
    SWModule *curMod = 0;

    for (it = modules.begin(); it != modules.end(); it++) {
        curMod = (*it).second;
        if (!strcmp(curMod->getType(), "Biblical Texts")) {
            QVariantMap json;
            json.insert("name", QVariant(curMod->getName()));
            json.insert("description", QVariant(curMod->getDescription()));

            list.append(json);
        } else if (!strcmp(curMod->getType(), "Commentaries")) {
            // do RenderTextsomething with curMod
        } else if (!strcmp(curMod->getType(), "Lexicons / Dictionaries")) {
            // do something with curMod
        }
    }

    setInstalledBibles(list);
}
