project(uBible C CXX)
cmake_minimum_required(VERSION 2.8.9)

set (UBUNTU_PROJECT_TYPE "ClickApp" CACHE INTERNAL "Tells QtCreator this is a Click application project")
set (CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

find_package(Qt5Core)
find_package(Qt5Qml)
find_package(Qt5Quick)
find_package(Qt5Concurrent)
#find_package(ubuntu-sdk-libs)

#automatically create moc files
set(CMAKE_AUTOMOC ON)

# components PATH
execute_process(
    COMMAND dpkg-architecture -qDEB_HOST_MULTIARCH
    OUTPUT_VARIABLE ARCH_TRIPLET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(QT_IMPORTS_DIR "lib/${ARCH_TRIPLET}")

option(INSTALL_TESTS "Install the tests on make install" on)

set(APP_NAME          uBible)
set(UBIBLE_DIR "share/qml/uBible")
set(MAIN_QML          "uBible.qml")
set(ICON              "grapics/toolbarIcon@8.png")

#set install paths
set(CMAKE_INSTALL_PREFIX /usr/share/uBible)
set(DATA_DIR /usr/share/uBible)
set(DESKTOP_DIR ${DATA_DIR})
set(ICON ".${DATA_DIR}/${ICON}")

set(EXEC "qmlscene $@ ${UBIBLE_DIR}/${MAIN_QML}")

install(FILES manifest.json DESTINATION ${CMAKE_INSTALL_PREFIX})
install(DIRECTORY "app/graphics" DESTINATION ${DATA_DIR})
install(DIRECTORY "app/icons" DESTINATION ${DATA_DIR})
install(FILES "${CMAKE_PROJECT_NAME}.json" DESTINATION ${DATA_DIR})

add_subdirectory(app)
add_subdirectory(backend)

add_custom_target("autopilot" chmod +x ${CMAKE_SOURCE_DIR}/app/tests/autopilot/run
                    COMMAND ${CMAKE_SOURCE_DIR}/app/tests/autopilot/run
                    DEPENDS uBiblebackend uBiblebackend-qmldir
                    WORKING_DIRECTORY ./app)

add_custom_target("check" /usr/bin/qmltestrunner -input ${CMAKE_SOURCE_DIR}/app/tests/unit -import ${CMAKE_BINARY_DIR}/backend
                    DEPENDS uBiblebackend uBiblebackend-qmldir
                    WORKING_DIRECTORY ./app)

add_custom_target("run" /usr/bin/qmlscene -I ${CMAKE_BINARY_DIR}/backend  ${CMAKE_SOURCE_DIR}/app/uBible.qml
                    DEPENDS uBiblebackend uBiblebackend-qmldir
                    WORKING_DIRECTORY ./app)
