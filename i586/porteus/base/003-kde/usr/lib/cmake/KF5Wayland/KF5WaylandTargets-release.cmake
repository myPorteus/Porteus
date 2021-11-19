#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::WaylandClient" for configuration "Release"
set_property(TARGET KF5::WaylandClient APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::WaylandClient PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Concurrent"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5WaylandClient.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5WaylandClient.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::WaylandClient )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::WaylandClient "${_IMPORT_PREFIX}/lib/libKF5WaylandClient.so.5.45.0" )

# Import target "KF5::WaylandServer" for configuration "Release"
set_property(TARGET KF5::WaylandServer APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::WaylandServer PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Concurrent"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libKF5WaylandServer.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5WaylandServer.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::WaylandServer )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::WaylandServer "${_IMPORT_PREFIX}/lib/libKF5WaylandServer.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
