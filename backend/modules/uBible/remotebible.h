#ifndef REMOTEBIBLE_H
#define REMOTEBIBLE_H

#include <QObject>

class BibleManager;

class RemoteBible : public QObject
{
    Q_OBJECT


    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(QString language READ language NOTIFY languageChanged)
    Q_PROPERTY(QString source READ source NOTIFY sourceChanged)
    Q_PROPERTY(bool installed READ installed NOTIFY installedChanged)

public:
    explicit RemoteBible(BibleManager *parent);

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
};

#endif // REMOTEBIBLE_H
