#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KHtml" for configuration "Release"
set_property(TARGET KF5::KHtml APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KHtml PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Phonon::phonon4qt5;Phonon::phonon4qt5experimental;Qt5::PrintSupport;KF5::Archive;KF5::SonnetCore;KF5::WidgetsAddons;KF5::WindowSystem;KF5::Wallet;KF5::IconThemes;KF5::Notifications;KF5::Bookmarks;KF5::KIOWidgets;KF5::GlobalAccel;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KHtml.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5KHtml.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KHtml )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KHtml "${_IMPORT_PREFIX}/lib64/libKF5KHtml.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
