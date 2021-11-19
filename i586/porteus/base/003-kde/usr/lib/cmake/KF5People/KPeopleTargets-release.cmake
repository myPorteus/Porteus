#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::PeopleWidgets" for configuration "Release"
set_property(TARGET KF5::PeopleWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::PeopleWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::ItemViews;KF5::WidgetsAddons;KF5::PeopleBackend;KF5::CoreAddons;KF5::Service"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5PeopleWidgets.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5PeopleWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::PeopleWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::PeopleWidgets "${_IMPORT_PREFIX}/lib/libKF5PeopleWidgets.so.5.45.0" )

# Import target "KF5::PeopleBackend" for configuration "Release"
set_property(TARGET KF5::PeopleBackend APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::PeopleBackend PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5PeopleBackend.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5PeopleBackend.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::PeopleBackend )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::PeopleBackend "${_IMPORT_PREFIX}/lib/libKF5PeopleBackend.so.5.45.0" )

# Import target "KF5::People" for configuration "Release"
set_property(TARGET KF5::People APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::People PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Sql;Qt5::DBus;KF5::I18n;KF5::CoreAddons;KF5::PeopleBackend;KF5::Service"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5People.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5People.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::People )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::People "${_IMPORT_PREFIX}/lib/libKF5People.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
