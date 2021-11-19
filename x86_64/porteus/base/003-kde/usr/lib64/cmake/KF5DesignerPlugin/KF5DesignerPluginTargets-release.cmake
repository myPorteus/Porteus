#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::kgendesignerplugin" for configuration "Release"
set_property(TARGET KF5::kgendesignerplugin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::kgendesignerplugin PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/kgendesignerplugin"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kgendesignerplugin )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kgendesignerplugin "${_IMPORT_PREFIX}/bin/kgendesignerplugin" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
