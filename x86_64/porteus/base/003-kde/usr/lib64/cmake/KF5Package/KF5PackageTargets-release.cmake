#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Package" for configuration "Release"
set_property(TARGET KF5::Package APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Package PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::Archive;KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5Package.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5Package.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Package )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Package "${_IMPORT_PREFIX}/lib64/libKF5Package.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
