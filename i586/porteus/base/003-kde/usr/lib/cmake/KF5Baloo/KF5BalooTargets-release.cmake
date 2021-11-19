#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Baloo" for configuration "Release"
set_property(TARGET KF5::Baloo APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Baloo PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::ConfigCore;Qt5::DBus;KF5::Solid;KF5::BalooEngine"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5Baloo.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5Baloo.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Baloo )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Baloo "${_IMPORT_PREFIX}/lib/libKF5Baloo.so.5.45.0" )

# Import target "KF5::BalooEngine" for configuration "Release"
set_property(TARGET KF5::BalooEngine APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::BalooEngine PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5BalooEngine.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5BalooEngine.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::BalooEngine )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::BalooEngine "${_IMPORT_PREFIX}/lib/libKF5BalooEngine.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
