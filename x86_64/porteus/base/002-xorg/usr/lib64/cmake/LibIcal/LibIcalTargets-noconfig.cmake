#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "ical" for configuration ""
set_property(TARGET ical APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(ical PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libical.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libical.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS ical )
list(APPEND _IMPORT_CHECK_FILES_FOR_ical "${_IMPORT_PREFIX}/lib64/libical.so.3.0.4" )

# Import target "ical_cxx" for configuration ""
set_property(TARGET ical_cxx APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(ical_cxx PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libical_cxx.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libical_cxx.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS ical_cxx )
list(APPEND _IMPORT_CHECK_FILES_FOR_ical_cxx "${_IMPORT_PREFIX}/lib64/libical_cxx.so.3.0.4" )

# Import target "icalss" for configuration ""
set_property(TARGET icalss APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(icalss PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libicalss.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libicalss.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS icalss )
list(APPEND _IMPORT_CHECK_FILES_FOR_icalss "${_IMPORT_PREFIX}/lib64/libicalss.so.3.0.4" )

# Import target "icalss_cxx" for configuration ""
set_property(TARGET icalss_cxx APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(icalss_cxx PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libicalss_cxx.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libicalss_cxx.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS icalss_cxx )
list(APPEND _IMPORT_CHECK_FILES_FOR_icalss_cxx "${_IMPORT_PREFIX}/lib64/libicalss_cxx.so.3.0.4" )

# Import target "icalvcal" for configuration ""
set_property(TARGET icalvcal APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(icalvcal PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libicalvcal.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libicalvcal.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS icalvcal )
list(APPEND _IMPORT_CHECK_FILES_FOR_icalvcal "${_IMPORT_PREFIX}/lib64/libicalvcal.so.3.0.4" )

# Import target "ical-glib" for configuration ""
set_property(TARGET ical-glib APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(ical-glib PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib64/libical-glib.so.3.0.4"
  IMPORTED_SONAME_NOCONFIG "libical-glib.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS ical-glib )
list(APPEND _IMPORT_CHECK_FILES_FOR_ical-glib "${_IMPORT_PREFIX}/lib64/libical-glib.so.3.0.4" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
