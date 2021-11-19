#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::newstuffqmlplugin" for configuration "Release"
set_property(TARGET KF5::newstuffqmlplugin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::newstuffqmlplugin PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/lib/qt5/qml/org/kde/newstuff/libnewstuffqmlplugin.so"
  IMPORTED_SONAME_RELEASE "libnewstuffqmlplugin.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::newstuffqmlplugin )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::newstuffqmlplugin "/usr/lib/qt5/qml/org/kde/newstuff/libnewstuffqmlplugin.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
