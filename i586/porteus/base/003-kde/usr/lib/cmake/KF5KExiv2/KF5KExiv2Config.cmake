# KExiv2Config.cmake provides information about the installed KExiv2 library.
# It can be used directly from CMake via find_package(KExiv2 NO_MODULE)
#
# The following CMake variables are provided:
#   KExiv2_VERSION_MAJOR - the major version number of KExiv2
#   KExiv2_VERSION_MINOR - the minor version number of KExiv2
#   KExiv2_VERSION_PATCH - the patch version number of KExiv2
#   KExiv2_INCLUDE_DIRS  - the include directories to use
#
# Additionally, the following imported library targets are created, which may be used directly
# with target_link_libraries():
#   KF5::KExiv2 - the kexiv2 library


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() (ECM variant) #######
####### Any changes to this file will be overwritten by the next CMake run            #######
####### The input file was KF5KExiv2Config.cmake.in                                           #######

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF5KExiv2" REALPATH)
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

include(CMakeFindDependencyMacro OPTIONAL RESULT_VARIABLE _CMakeFindDependencyMacro_FOUND)

if (NOT _CMakeFindDependencyMacro_FOUND)
  macro(find_dependency dep)
    if (NOT ${dep}_FOUND)

      set(ecm_fd_version)
      if (${ARGC} GREATER 1)
        set(ecm_fd_version ${ARGV1})
      endif()
      set(ecm_fd_exact_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_VERSION_EXACT)
        set(ecm_fd_exact_arg EXACT)
      endif()
      set(ecm_fd_quiet_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
        set(ecm_fd_quiet_arg QUIET)
      endif()
      set(ecm_fd_required_arg)
      if(${CMAKE_FIND_PACKAGE_NAME}_FIND_REQUIRED)
        set(ecm_fd_required_arg REQUIRED)
      endif()

      find_package(${dep} ${ecm_fd_version}
          ${ecm_fd_exact_arg}
          ${ecm_fd_quiet_arg}
          ${ecm_fd_required_arg}
      )

      if (NOT ${dep}_FOUND)
        set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "${CMAKE_FIND_PACKAGE_NAME} could not be found because dependency ${dep} could not be found.")
        set(${CMAKE_FIND_PACKAGE_NAME}_FOUND False)
        return()
      endif()

      set(ecm_fd_version)
      set(ecm_fd_required_arg)
      set(ecm_fd_quiet_arg)
      set(ecm_fd_exact_arg)
    endif()
  endmacro()
endif()


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

find_dependency(Qt5Core 5.2.0)
find_dependency(Qt5Gui 5.2.0)

include("${CMAKE_CURRENT_LIST_DIR}/KF5KExiv2Targets.cmake")
