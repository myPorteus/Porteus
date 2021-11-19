#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Plasma::PotdProvider" for configuration "Release"
set_property(TARGET Plasma::PotdProvider APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Plasma::PotdProvider PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libplasmapotdprovidercore.so.1.0.0"
  IMPORTED_SONAME_RELEASE "libplasmapotdprovidercore.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS Plasma::PotdProvider )
list(APPEND _IMPORT_CHECK_FILES_FOR_Plasma::PotdProvider "${_IMPORT_PREFIX}/lib64/libplasmapotdprovidercore.so.1.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
