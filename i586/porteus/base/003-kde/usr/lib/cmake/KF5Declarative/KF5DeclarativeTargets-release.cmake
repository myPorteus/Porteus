#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Declarative" for configuration "Release"
set_property(TARGET KF5::Declarative APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Declarative PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Quick;KF5::I18n;KF5::KIOWidgets;KF5::IconThemes"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5Declarative.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5Declarative.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Declarative )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Declarative "${_IMPORT_PREFIX}/lib/libKF5Declarative.so.5.45.0" )

# Import target "KF5::QuickAddons" for configuration "Release"
set_property(TARGET KF5::QuickAddons APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::QuickAddons PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::Declarative;KF5::ConfigGui"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5QuickAddons.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5QuickAddons.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::QuickAddons )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::QuickAddons "${_IMPORT_PREFIX}/lib/libKF5QuickAddons.so.5.45.0" )

# Import target "KF5::CalendarEvents" for configuration "Release"
set_property(TARGET KF5::CalendarEvents APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::CalendarEvents PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5CalendarEvents.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5CalendarEvents.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::CalendarEvents )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::CalendarEvents "${_IMPORT_PREFIX}/lib/libKF5CalendarEvents.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
