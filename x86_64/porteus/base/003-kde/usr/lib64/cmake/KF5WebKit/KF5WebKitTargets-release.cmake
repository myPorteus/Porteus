#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::WebKit" for configuration "Release"
set_property(TARGET KF5::WebKit APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::WebKit PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::CoreAddons;KF5::Wallet;KF5::KIOWidgets;KF5::Parts"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5WebKit.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5WebKit.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::WebKit )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::WebKit "${_IMPORT_PREFIX}/lib64/libKF5WebKit.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
