#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KExiv2" for configuration "Release"
set_property(TARGET KF5::KExiv2 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KExiv2 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KExiv2.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libKF5KExiv2.so.15.0.0"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KExiv2 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KExiv2 "${_IMPORT_PREFIX}/lib64/libKF5KExiv2.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
