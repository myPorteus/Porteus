#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Notifications" for configuration "Release"
set_property(TARGET KF5::Notifications APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Notifications PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::CoreAddons;KF5::ConfigCore;KF5::WindowSystem;KF5::Codecs;Phonon::phonon4qt5;Phonon::phonon4qt5experimental;Qt5::X11Extras;dbusmenu-qt5"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5Notifications.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5Notifications.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Notifications )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Notifications "${_IMPORT_PREFIX}/lib64/libKF5Notifications.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
