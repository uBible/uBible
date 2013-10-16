# Add more folders to ship with the application, here
folder_01.source = qml/uBible
folder_01.target = qml
#folder_02.source = qml/uBible/ubuntu-ui-extras
#folder_02.target = qml/ubuntu-ui-extras
DEPLOYMENTFOLDERS = folder_01 #folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    bibleapp.cpp \
    biblechapter.cpp \
    bible.cpp \
    module.cpp

INCLUDEPATH += /usr/include/sword/
LIBS        += -lsword


# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    bibleapp.h \
    biblechapter.h \
    bible.h \
    module.h

OTHER_FILES += \
    README.md \
    COPYING \
    COPYRIGHT \
    qml/uBible/SetttingsPage.qml

RESOURCES += \
    resources.qrc
