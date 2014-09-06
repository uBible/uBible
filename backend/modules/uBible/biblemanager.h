#ifndef BIBLEMANAGER_H
#define BIBLEMANAGER_H

#include <QObject>

#include <sword/swmgr.h>
#include <sword/swmodule.h>
#include <sword/installmgr.h>

class BibleManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList installedBibles READ installedBibles NOTIFY installedBiblesChanged)

    Q_PROPERTY(bool confirmedPermission READ confirmedPermission WRITE setConfirmedPermission NOTIFY confirmedPermissionChanged)

    Q_PROPERTY(bool busy READ busy NOTIFY busyChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)

public:
    explicit BibleManager(QObject *parent = 0);

    virtual ~BibleManager();

    QVariantList installedBibles() const
    {
        return m_installedBibles;
    }

    bool confirmedPermission() const
    {
        return m_confirmedPermission;
    }

    bool busy() const
    {
        return m_busy;
    }

    QString status() const
    {
        return m_status;
    }

signals:

    void installedBiblesChanged(QVariantList arg);

    void confirmedPermissionChanged(bool arg);

    void busyChanged(bool arg);

    void statusChanged(QString arg);

public slots:

    void refresh();

    void setConfirmedPermission(bool arg)
    {
        if (m_confirmedPermission != arg) {
            m_confirmedPermission = arg;
            emit confirmedPermissionChanged(arg);
        }
    }

    void setBusy(bool arg)
    {
        if (m_busy != arg) {
            m_busy = arg;
            emit busyChanged(arg);
        }
    }

    void setStatus(const QString &arg)
    {
        if (m_status != arg) {
            m_status = arg;
            emit statusChanged(arg);
        }
    }

protected slots:
    void setInstalledBibles(QVariantList installedBibles) {
        m_installedBibles = installedBibles;
        emit installedBiblesChanged(installedBibles);
    }

private:
    void loadAvailableBibles();
    QVariantList loadRemoteBibles(sword::SWMgr *library);
    void run();

    QVariantList m_installedBibles;

    sword::InstallMgr *m_installManager;
    sword::SWMgr *m_manager;
    bool m_confirmedPermission;
    bool m_busy;
    QString m_status;
};

#endif // BIBLEMANAGER_H
