#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::JobWidgets" for configuration "Release"
set_property(TARGET KF5::JobWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::JobWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::WidgetsAddons;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5JobWidgets.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5JobWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::JobWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::JobWidgets "${_IMPORT_PREFIX}/lib/libKF5JobWidgets.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
