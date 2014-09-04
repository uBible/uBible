project(uBible C CXX)
cmake_minimum_required(VERSION 2.8.9)

set (UBUNTU_PROJECT_TYPE "ClickApp" CACHE INTERNAL "Tells QtCreator this is a Click application project")
set (CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fno-permissive -pedantic -Wall -Wextra")

find_package(Qt5Core)
find_package(Qt5Qml)
find_package(Qt5Quick)
find_package(Qt5Concurrent)
#find_package(ubuntu-sdk-libs)

#automatically create moc files
set(CMAKE_AUTOMOC ON)

option(INSTALL_TESTS "Install the tests on make install" on)
option(CLICK_MODE "Build as a click package" on)

set(APP_NAME                uBible)
set(APP_HARDCODE            uBible)
set(MAIN_QML                ${APP_HARDCODE}.qml)
set(ICON                    ubible-app)
SET(AUTOPILOT_DIR           ubible_app)

# Standard install paths
include(GNUInstallDirs)

#set install paths
if(CLICK_MODE)
  set(CMAKE_INSTALL_PREFIX "/")
  set(UBIBLE_APP_DIR    "${CMAKE_INSTALL_DATADIR}/qml")

  set(QT_IMPORTS_DIR "${CMAKE_INSTALL_LIBDIR}")
  set(EXEC "qmlscene $@ ${UBIBLE_APP_DIR}/${MAIN_QML}")
  set(MODULE_PATH ${QT_IMPORTS_DIR})
else(CLICK_MODE)
  set(UBIBLE_APP_DIR "${CMAKE_INSTALL_DATADIR}/ubible-app")
  execute_process(
    COMMAND qmake -query QT_INSTALL_QML
            OUTPUT_VARIABLE QT_IMPORTS_DIR
            OUTPUT_STRIP_TRAILING_WHITESPACE
    )
set(MODULE_PATH ${QT_IMPORTS_DIR}/uBible)
endif(CLICK_MODE)

if(${CLICK_MODE})
  message("-- Configuring manifest.json")
  configure_file(manifest.json manifest.json)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/manifest.json DESTINATION ${CMAKE_INSTALL_PREFIX})
  install(FILES "${APP_HARDCODE}.json" DESTINATION ${CMAKE_INSTALL_PREFIX})
else(CLICK_MODE)
  set(EXEC "qmlscene $@ -I ${MODULE_PATH}  ${CMAKE_INSTALL_PREFIX}/${UBIBLE_APP_DIR}/${MAIN_QML}")
endif()

install(FILES ${URLS_FILE} DESTINATION "${CMAKE_INSTALL_DATADIR}/url-dispatcher/urls")

file(GLOB_RECURSE I18N_SRC_FILES
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/po
    *.qml *.js)
list(SORT I18N_SRC_FILES)

add_subdirectory(app)
add_subdirectory(backend)
add_subdirectory(po)
if(NOT CLICK_MODE)
  add_subdirectory(tests)
endif(NOT CLICK_MODE)

add_custom_target("autopilot" chmod +x ${CMAKE_SOURCE_DIR}/tests/autopilot/run
                    COMMAND ${CMAKE_SOURCE_DIR}/tests/autopilot/run
                    WORKING_DIRECTORY ./app)

enable_testing()
add_test(NAME basic
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/app
  COMMAND /usr/bin/qmltestrunner -input ${CMAKE_SOURCE_DIR}/tests/unit -import ${CMAKE_BINARY_DIR}/backend
)

add_custom_target("run" /usr/bin/qmlscene -I ${CMAKE_BINARY_DIR}/backend  ${CMAKE_SOURCE_DIR}/app/uBible.qml
                    WORKING_DIRECTORY ./app)
