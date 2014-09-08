import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import Ubuntu.Components.ListItems 1.0 as ListItem

import "../ubuntu-ui-extras"
import "../components"

Walkthough {
    title: currentIndex == 0 ? i18n.tr("Welcome!")
                             : i18n.tr("Install Bibles")
    showSkipButton: false
    showFooter: false
    swipingEnabled: false

    head.actions: [
        Action {
            iconName: "reload"
            text: i18n.tr("Refresh")
            visible: currentIndex == 1
            onTriggered: settings.bibleManager.refresh(true)
        }
    ]

    Component.onCompleted: {
        if (settings.permissionConfirmed) {
            currentIndex = 1
            settings.bibleManager.refresh()
        }
    }

    model: [
        Component {
            Item {
                anchors.fill: parent

                Label {
                    anchors.fill: parent
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    text: disclaimer
                }

                DialogButtonRow {
                    anchors.bottom: parent.bottom

                    rejectText: i18n.tr("Reject")
                    acceptText: i18n.tr("Accept")

                    onRejected: {
                        settings.permissionConfirmed = false
                        Qt.quit()
                    }

                    onAccepted: {
                        settings.permissionConfirmed = true
                        currentIndex++
                        settings.bibleManager.refresh()
                    }
                }
            }
        },

        Component {
            Item {
                anchors.fill: parent

                Column {
                    anchors.centerIn: parent
                    visible: settings.bibleManager.busy && listView.count == 0
                    spacing: units.gu(1)

                    ActivityIndicator {
                        anchors.horizontalCenter: parent.horizontalCenter
                        running: parent.visible
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        fontSize: "large"
                        text: settings.bibleManager.status
                    }
                }

                ListView {
                    id: listView
                    anchors.fill: parent
                    anchors.margins: -units.gu(2)
                    model: settings.bibleManager.availableBibles

                    section.property: "modelData.source"
                    section.delegate: ListItem.Header {
                        text: section
                    }

                    delegate: SubtitledListItem {
                        text: modelData.name
                        subText: modelData.description
                        onClicked: {
                            modelData.install()
                            showInstallDialog(modelData.name)
                        }

                        Icon {
                            name: "save-to"
                            width: units.gu(2.5)
                            height: width
                            visible: modelData.installed
                            anchors {
                                rightMargin: units.gu(2)
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }

                Scrollbar {
                    flickableItem: listView
                }
            }
        }

    ]

    Component {
        id: installDialog

        Dialog {
            id: dialog

            title: i18n.tr("Installing Bible")
            text: i18n.tr("Installing module: %1").arg(module)

            ActivityIndicator {
                running: dialog.visible
            }
        }
    }

    function showInstallDialog(moduleName) {
        module = moduleName
        PopupUtils.open(installDialog)
    }

    Connections {
        target: settings.bibleManager
        onBusyChanged: if (!settings.bibleManager.busy && installDialog.visible) installDialog.hide()
    }

    property string module

    property string disclaimer: "uBible allows you to download Bibles from the internet. " +
                                "While this is a useful feature, it also allows you to be potentially tracked.<br/><br/>" +
                                "IF YOU LIVE IN A PERSECUTED COUNTRY AND DO NOT WISH TO RISK DETECTION," +
                                "YOU SHOULD <b>NOT</b> USE UBIBLE'S REMOTE SOURCE FEATURES.<br/><br/>" +
                                "Also, Remote Sources other than CrossWire may contain less than " +
                                "quality modules, modules with unorthodox content, or even modules " +
                                "which are not legitimately distributable. Many repositories " +
                                "contain wonderfully useful content. These repositories simply " +
                                "are not reviewed or maintained by CrossWire and CrossWire " +
                                "cannot be held responsible for their content.<br/><br/><br/>" +
                                "If you do not accept these terms, do not use the app."
}
