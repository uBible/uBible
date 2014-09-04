if(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
  file(GLOB QML_JS_FILES *.qml *.js)
  add_custom_target(ubible_QMlFiles ALL SOURCES ${QML_JS_FILES})
endif(NOT "${CMAKE_CURRENT_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")


if(CLICK_MODE)
  set(ICON "${ICON}@30.png")
  install(FILES ${ICON} DESTINATION ${CMAKE_INSTALL_PREFIX})
endif(CLICK_MODE)

# substitute variables in the desktop file
set(DESKTOP_FILE "ubible.desktop")
message("-- Configuring ubible.desktop.in")
configure_file(${DESKTOP_FILE}.in ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE}
    DESTINATION ${CMAKE_INSTALL_DATADIR}/applications)
install(FILES ${MAIN_QML} DESTINATION ${UBIBLE_APP_DIR})

set(APP_DIR ${UBIBLE_APP_DIR})

add_subdirectory(ui)
add_subdirectory(components)
add_subdirectory(model)
add_subdirectory(udata)
add_subdirectory(qml-extras)
add_subdirectory(ubuntu-ui-extras)
