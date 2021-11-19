#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::PlasmaQuick" for configuration "Release"
set_property(TARGET KF5::PlasmaQuick APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::PlasmaQuick PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::KIOWidgets;KF5::I18n;KF5::IconThemes;KF5::Service;KF5::CoreAddons;KF5::XmlGui;KF5::Declarative;KF5::QuickAddons;KF5::WaylandClient;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5PlasmaQuick.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5PlasmaQuick.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::PlasmaQuick )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::PlasmaQuick "${_IMPORT_PREFIX}/lib/libKF5PlasmaQuick.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
