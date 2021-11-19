#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Plasma" for configuration "Release"
set_property(TARGET KF5::Plasma APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Plasma PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Sql;Qt5::Svg;Qt5::DBus;KF5::Archive;KF5::GuiAddons;KF5::I18n;KF5::KIOCore;KF5::KIOWidgets;KF5::WindowSystem;KF5::Declarative;KF5::XmlGui;KF5::GlobalAccel;KF5::Notifications;KF5::IconThemes;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5Plasma.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5Plasma.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Plasma )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Plasma "${_IMPORT_PREFIX}/lib64/libKF5Plasma.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
