#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::ModemManagerQt" for configuration "Release"
set_property(TARGET KF5::ModemManagerQt APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::ModemManagerQt PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5ModemManagerQt.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5ModemManagerQt.so.6"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ModemManagerQt )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ModemManagerQt "${_IMPORT_PREFIX}/lib/libKF5ModemManagerQt.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
