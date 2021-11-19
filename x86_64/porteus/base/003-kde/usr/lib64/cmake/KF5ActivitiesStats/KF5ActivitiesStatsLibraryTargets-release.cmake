#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::ActivitiesStats" for configuration "Release"
set_property(TARGET KF5::ActivitiesStats APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::ActivitiesStats PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Sql;KF5::Activities;KF5::ConfigCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5ActivitiesStats.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5ActivitiesStats.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ActivitiesStats )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ActivitiesStats "${_IMPORT_PREFIX}/lib64/libKF5ActivitiesStats.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
