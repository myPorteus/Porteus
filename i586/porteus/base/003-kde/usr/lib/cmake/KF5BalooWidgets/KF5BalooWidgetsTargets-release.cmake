#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::BalooWidgets" for configuration "Release"
set_property(TARGET KF5::BalooWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::BalooWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::FileMetaData;KF5::WidgetsAddons;KF5::Baloo;KF5::ConfigGui"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5BalooWidgets.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libKF5BalooWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::BalooWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::BalooWidgets "${_IMPORT_PREFIX}/lib/libKF5BalooWidgets.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
