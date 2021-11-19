#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::LibTaskManager" for configuration "Release"
set_property(TARGET PW::LibTaskManager APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(PW::LibTaskManager PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::Activities;KF5::ConfigCore;KF5::KIOCore;KF5::KIOWidgets;KF5::ProcessCore;KF5::WaylandClient;KF5::WindowSystem;Qt5::X11Extras;KF5::IconThemes"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libtaskmanager.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libtaskmanager.so.6"
  )

list(APPEND _IMPORT_CHECK_TARGETS PW::LibTaskManager )
list(APPEND _IMPORT_CHECK_FILES_FOR_PW::LibTaskManager "${_IMPORT_PREFIX}/lib/libtaskmanager.so.5.12.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
