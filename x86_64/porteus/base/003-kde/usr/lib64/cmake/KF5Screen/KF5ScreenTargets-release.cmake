#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Screen" for configuration "Release"
set_property(TARGET KF5::Screen APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Screen PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5Screen.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libKF5Screen.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Screen )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Screen "${_IMPORT_PREFIX}/lib64/libKF5Screen.so.5.12.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
