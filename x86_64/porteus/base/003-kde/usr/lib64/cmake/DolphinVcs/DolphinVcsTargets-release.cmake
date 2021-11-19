#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "DolphinVcs" for configuration "Release"
set_property(TARGET DolphinVcs APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(DolphinVcs PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libdolphinvcs.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libdolphinvcs.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS DolphinVcs )
list(APPEND _IMPORT_CHECK_FILES_FOR_DolphinVcs "${_IMPORT_PREFIX}/lib64/libdolphinvcs.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
