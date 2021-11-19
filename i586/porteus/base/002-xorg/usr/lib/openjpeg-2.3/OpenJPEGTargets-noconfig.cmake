#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "openjp2" for configuration ""
set_property(TARGET openjp2 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(openjp2 PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "m;-lpthread"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libopenjp2.so.2.3.0"
  IMPORTED_SONAME_NOCONFIG "libopenjp2.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS openjp2 )
list(APPEND _IMPORT_CHECK_FILES_FOR_openjp2 "${_IMPORT_PREFIX}/lib/libopenjp2.so.2.3.0" )

# Import target "openjp2_static" for configuration ""
set_property(TARGET openjp2_static APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(openjp2_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libopenjp2.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS openjp2_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_openjp2_static "${_IMPORT_PREFIX}/lib/libopenjp2.a" )

# Import target "openjpwl" for configuration ""
set_property(TARGET openjpwl APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(openjpwl PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "m"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libopenjpwl.so.2.3.0"
  IMPORTED_SONAME_NOCONFIG "libopenjpwl.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS openjpwl )
list(APPEND _IMPORT_CHECK_FILES_FOR_openjpwl "${_IMPORT_PREFIX}/lib/libopenjpwl.so.2.3.0" )

# Import target "openjpip" for configuration ""
set_property(TARGET openjpip APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(openjpip PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "openjp2"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libopenjpip.so.2.3.0"
  IMPORTED_SONAME_NOCONFIG "libopenjpip.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS openjpip )
list(APPEND _IMPORT_CHECK_FILES_FOR_openjpip "${_IMPORT_PREFIX}/lib/libopenjpip.so.2.3.0" )

# Import target "opj_decompress" for configuration ""
set_property(TARGET opj_decompress APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_decompress PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_decompress"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_decompress )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_decompress "${_IMPORT_PREFIX}/bin/opj_decompress" )

# Import target "opj_compress" for configuration ""
set_property(TARGET opj_compress APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_compress PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_compress"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_compress )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_compress "${_IMPORT_PREFIX}/bin/opj_compress" )

# Import target "opj_dump" for configuration ""
set_property(TARGET opj_dump APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_dump PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_dump"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_dump )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_dump "${_IMPORT_PREFIX}/bin/opj_dump" )

# Import target "opj_jpip_addxml" for configuration ""
set_property(TARGET opj_jpip_addxml APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_jpip_addxml PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_jpip_addxml"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_jpip_addxml )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_jpip_addxml "${_IMPORT_PREFIX}/bin/opj_jpip_addxml" )

# Import target "opj_dec_server" for configuration ""
set_property(TARGET opj_dec_server APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_dec_server PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_dec_server"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_dec_server )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_dec_server "${_IMPORT_PREFIX}/bin/opj_dec_server" )

# Import target "opj_jpip_transcode" for configuration ""
set_property(TARGET opj_jpip_transcode APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_jpip_transcode PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_jpip_transcode"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_jpip_transcode )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_jpip_transcode "${_IMPORT_PREFIX}/bin/opj_jpip_transcode" )

# Import target "opj_jpip_test" for configuration ""
set_property(TARGET opj_jpip_test APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(opj_jpip_test PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/opj_jpip_test"
  )

list(APPEND _IMPORT_CHECK_TARGETS opj_jpip_test )
list(APPEND _IMPORT_CHECK_FILES_FOR_opj_jpip_test "${_IMPORT_PREFIX}/bin/opj_jpip_test" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
