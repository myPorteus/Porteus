#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Bookmarks" for configuration "Release"
set_property(TARGET KF5::Bookmarks APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Bookmarks PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::CoreAddons;KF5::Codecs;KF5::ConfigCore;KF5::ConfigWidgets;KF5::XmlGui;KF5::IconThemes"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5Bookmarks.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5Bookmarks.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Bookmarks )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Bookmarks "${_IMPORT_PREFIX}/lib/libKF5Bookmarks.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
