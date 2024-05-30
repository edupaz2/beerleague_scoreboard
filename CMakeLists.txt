cmake_minimum_required(VERSION 3.16)

project(beerleague VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia)

qt_standard_project_setup()

qt_add_resources(SOUNDS_RCC "res/sounds/sounds.qrc")
qt_add_resources(FONTS_RCC "res/fonts/fonts.qrc")

include_directories(src)

qt_add_executable(appbeerleague
    main.cpp
    ${SOUNDS_RCC}
    ${FONTS_RCC}
)

qt_add_qml_module(appbeerleague
    URI BeerLeague
    VERSION 1.0
    QML_FILES
        Main.qml
        src/Score.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appbeerleague PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appbeerleague
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appbeerleague
    PRIVATE Qt6::Quick Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appbeerleague
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
