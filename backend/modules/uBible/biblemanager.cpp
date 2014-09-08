#include "biblemanager.h"

#include <QVariantList>
#include <QVariantMap>
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QStandardPaths>
#include <swlog.h>
#include <QFile>

#include "module.h"
#include "bible.h"

using namespace sword;

class CustomInstallManager: public InstallMgr
{
public:
    explicit CustomInstallManager(BibleManager *manager, QString configPath)
        : InstallMgr(qPrintable(configPath)) {
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
    SWLog::getSystemLog()->setLogLevel(SWLog::LOG_DEBUG);

    QString dataPath(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
    QString configPath = dataPath + "/Databases/library/";

    qDebug() << configPath << QDir(configPath).mkpath("modules");
    qDebug() << QDir(configPath).mkpath("mods.d");

    m_manager = new SWMgr(qPrintable(configPath));

    if (m_manager->config == nullptr) {
        qFatal("SWORD configuration file not found!");
    }

    m_installManager = new CustomInstallManager(this, dataPath + "/remote_sources");

    qDebug() << "Loading bibles...";
    this->loadInstalledBibles();

    qDebug() << "Bibles loaded";
}

BibleManager::~BibleManager() {
    delete m_installManager;
}

void BibleManager::refresh(bool force) {
    setAvailableBibles(QVariantList());

    if (force || m_installManager->sources.size() == 0) {
        setStatus("Refreshing sources....");
        setBusy(true);

        QFuture<void> future = QtConcurrent::run(this, &BibleManager::run);
        QFutureWatcher<void> *watcher = new QFutureWatcher<void>(this);

        connect(watcher, SIGNAL(finished()), this, SLOT(loadRemoteSources()));
        watcher->setFuture(future);
    } else {
        loadRemoteSources();
    }
}

Bible *BibleManager::getBible(const QString &name)
{
    SWModule *module = m_manager->getModule(qPrintable(name));

    if (module == nullptr)
        return nullptr;

    Bible *bible = new Bible(module, this);
    bible->setInstalled(true);
    bible->setName(module->getName());
    bible->setDescription(module->getDescription());
    bible->setLanguage(module->getLanguage());

    return bible;
}

void BibleManager::installModule(QString sourceName, QString moduleName) {
    setBusy(true);
    setStatus("Installing " + moduleName);

    InstallSourceMap::iterator source = m_installManager->sources.find(qPrintable(sourceName));
    if (source == m_installManager->sources.end()) {
        qWarning() << "Couldn't find remote source" << sourceName;
        return;
    }
    InstallSource *is = source->second;
    SWMgr *rmgr = is->getMgr();
    SWModule *module;
    ModMap::iterator it = rmgr->Modules.find(qPrintable(moduleName));
    if (it == rmgr->Modules.end()) {
        qWarning() << "Couldn't find module in remote source" << moduleName;
        return;
    }
    module = it->second;

    int error = m_installManager->installModule(m_manager, 0, module->getName(), is);
    if (error) {
        qDebug() << "Error installing module: [" << module->getName() << "] (write permissions?)\n";
    } else {
        qDebug() << "Installed module: [" << module->getName() << "]" << m_manager->prefixPath;
    }

    loadInstalledBibles();

    setBusy(false);
}

void BibleManager::loadRemoteSources() {
    QVariantList list;
    InstallSourceMap sources = m_installManager->sources;

    for (std::pair<SWBuf, InstallSource *> pair : sources) {
        qDebug() << pair.second->caption;
        SWMgr *source = pair.second->getMgr();

        std::map<SWModule *, int> mods = InstallMgr::getModuleStatus(*m_manager, *source);
        for (std::pair<SWModule *, int> modPair : mods) {
            SWModule *module = modPair.first;
            QString version = module->getConfigEntry("Version");

            // It's not a Bible, let's skip it for now
            if (strcmp(module->getType(), "Biblical Texts") != 0)
                continue;

            Module *bible = new Module(module, this);
            bible->setInstalled(!(modPair.second & InstallMgr::MODSTAT_NEW));
            bible->setName(module->getName());
            bible->setDescription(module->getDescription());
            bible->setLanguage(module->getLanguage());
            bible->setSource(QString(pair.second->caption));

            list.append(QVariant::fromValue(bible));
        }
    }

    setAvailableBibles(list);

    setBusy(false);
}

void BibleManager::run() {
    qDebug() << "Loading remote sources..." << m_installManager->isUserDisclaimerConfirmed();
    int result = m_installManager->refreshRemoteSourceConfiguration();
    qDebug() << "Done: " << result;

    InstallSourceMap sources = m_installManager->sources;

    for (std::pair<SWBuf, InstallSource *> pair : sources) {
        qDebug() << pair.second->caption;
        setStatus(QString("Refreshing ") + QString(pair.second->caption));
        m_installManager->refreshRemoteSource(pair.second);
    }
}

void BibleManager::loadInstalledBibles() {
    QVariantList list;

    ModMap modules = m_manager->Modules;
    ModMap::iterator it;
    SWModule *module = 0;

    for (it = modules.begin(); it != modules.end(); it++) {
        module = (*it).second;
        if (!strcmp(module->getType(), "Biblical Texts")) {

            Bible *bible = new Bible(module, this);
            bible->setInstalled(true);
            bible->setName(module->getName());
            bible->setDescription(module->getDescription());
            bible->setLanguage(module->getLanguage());

            qDebug() << bible->books();

            list.append(QVariant::fromValue(bible));

        } else if (!strcmp(module->getType(), "Commentaries")) {
            // do RenderTextsomething with module
        } else if (!strcmp(module->getType(), "Lexicons / Dictionaries")) {
            // do something with module
        }
    }

    qDebug() << list;

    setInstalledBibles(list);
}
