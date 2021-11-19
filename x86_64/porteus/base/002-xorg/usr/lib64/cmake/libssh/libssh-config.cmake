
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was libssh-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib64/cmake/libssh" REALPATH)
if(_realCurr STREQUAL _realOrig)
  set(PACKAGE_PREFIX_DIR "/usr")
endif()
unset(_realOrig)
unset(_realCurr)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/CMakeCache.txt")
    # In tree build
    set_and_check(LIBSSH_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/include")
    set_and_check(LIBSSH_LIBRARIES "${CMAKE_CURRENT_LIST_DIR}/lib/libssh.so")
else()
    set_and_check(LIBSSH_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include")
    set_and_check(LIBSSH_LIBRARIES "${PACKAGE_PREFIX_DIR}/lib64/libssh.so")
endif()

# For backward compatibility
set(LIBSSH_LIBRARY ${LIBSSH_LIBRARIES})

mark_as_advanced(LIBSSH_LIBRARIES LIBSSH_LIBRARY LIBSSH_INCLUDE_DIR)
