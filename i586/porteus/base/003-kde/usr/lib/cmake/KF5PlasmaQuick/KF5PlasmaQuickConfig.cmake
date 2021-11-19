
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5PlasmaQuickConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF5PlasmaQuick" REALPATH)
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

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

include(CMakeFindDependencyMacro)
find_dependency(KF5Plasma "5.45.0")

include("${CMAKE_CURRENT_LIST_DIR}/KF5PlasmaQuickTargets.cmake")

set(PlasmaQuick_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")
set_and_check(PlasmaQuick_INCLUDE_DIR    "${PACKAGE_PREFIX_DIR}/include/KF5")

set(PlasmaQuick_LIBRARIES KF5::PlasmaQuick)

