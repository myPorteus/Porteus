#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Runner" for configuration "Release"
set_property(TARGET KF5::Runner APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Runner PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Gui;Qt5::Widgets;KF5::ConfigCore;KF5::Service;KF5::I18n;KF5::ThreadWeaver;KF5::CoreAddons;KF5::KIOCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5Runner.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5Runner.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Runner )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Runner "${_IMPORT_PREFIX}/lib/libKF5Runner.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
