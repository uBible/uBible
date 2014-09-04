file(GLOB MODEL_QML_JS_FILES *.qml *.js)

# make the files visible in the qtcreator tree
add_custom_target(ubible_model_QMlFiles ALL SOURCES ${MODEL_QML_JS_FILES})

install(FILES ${MODEL_QML_JS_FILES} DESTINATION ${UBIBLE_APP_DIR}/model)
