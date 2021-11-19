#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::NewStuff" for configuration "Release"
set_property(TARGET KF5::NewStuff APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::NewStuff PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::KIOCore;KF5::KIOWidgets;KF5::Completion;KF5::I18n;KF5::ItemViews;KF5::IconThemes;KF5::TextWidgets"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5NewStuff.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5NewStuff.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::NewStuff )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::NewStuff "${_IMPORT_PREFIX}/lib/libKF5NewStuff.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
