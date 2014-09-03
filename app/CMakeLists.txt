file(GLOB QML_JS_FILES *.qml *.js)

# make the files visible on qtcreator
add_custom_target(ubible_QMlFiles ALL SOURCES ${QML_JS_FILES})

#substitute variables in the desktop file
set(DESKTOP_FILE "${CMAKE_PROJECT_NAME}.desktop")
configure_file(${DESKTOP_FILE}.in ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${DESKTOP_FILE} DESTINATION ${DESKTOP_DIR})
install(FILES ${QML_JS_FILES} DESTINATION ${UBIBLE_DIR})

add_subdirectory(components)
add_subdirectory(ui)
