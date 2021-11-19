#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::BluezQt" for configuration "Release"
set_property(TARGET KF5::BluezQt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::BluezQt PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Network"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5BluezQt.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5BluezQt.so.6"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::BluezQt )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::BluezQt "${_IMPORT_PREFIX}/lib/libKF5BluezQt.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
