#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "kpmcore" for configuration "Release"
set_property(TARGET kpmcore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(kpmcore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Gui;qca-qt5;KF5::I18n;KF5::CoreAddons;KF5::WidgetsAddons;KF5::AuthCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libkpmcore.so.4.0.0"
  IMPORTED_SONAME_RELEASE "libkpmcore.so.8"
  )

list(APPEND _IMPORT_CHECK_TARGETS kpmcore )
list(APPEND _IMPORT_CHECK_FILES_FOR_kpmcore "${_IMPORT_PREFIX}/lib64/libkpmcore.so.4.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
