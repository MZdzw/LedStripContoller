cmake_minimum_required(VERSION 3.16)

project(LedStripContoller VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appLedStripContoller
    main.cpp
)

qt_add_qml_module(appLedStripContoller
    URI LedStripContoller
    QML_FILES Main.qml
    QML_FILES HomePage.qml
    QML_FILES SettingsPage.qml
    QML_FILES MyComponents/SideButton.qml
    QML_FILES MyComponents/ToggleButton.qml
    SOURCES tcpclient.h tcpclient.cpp
)

qt_add_resources(appLedStripContoller imageresources
    FILES
        Images/toggle.png
        Images/LedStrip.png
        Images/settings.png
        Images/LedStripModel2.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appLedStripContoller PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appLedStripContoller
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLedStripContoller
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appLedStripContoller
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
