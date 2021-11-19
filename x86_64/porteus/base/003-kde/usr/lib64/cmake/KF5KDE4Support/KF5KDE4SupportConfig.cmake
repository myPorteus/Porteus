
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5KDE4SupportConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib64/cmake/KF5KDE4Support" REALPATH)
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

include(CMakeFindDependencyMacro)
find_dependency(KF5KDELibs4Support "5.45.0")

if(NOT TARGET KF5::KDE4Support)
    add_library(KF5::KDE4Support SHARED IMPORTED)

    # Because CMake won't let us alias an imported target, we have to
    # create a new imported target and copy the properties we care about
    set(_copy_props
        INTERFACE_INCLUDE_DIRECTORIES
        INTERFACE_LINK_LIBRARIES
        IMPORTED_CONFIGURATIONS
    )
    get_target_property(_configs KF5::KDELibs4Support IMPORTED_CONFIGURATIONS)
    foreach(_config ${_configs})
        set(_copy_props
            ${_copy_props}
            IMPORTED_LINK_DEPENDENT_LIBRARIES_${_config}
            IMPORTED_LOCATION_${_config}
            IMPORTED_SONAME_${_config}
        )
    endforeach()
    foreach(_prop ${_copy_props})
        get_target_property(_temp_prop KF5::KDELibs4Support "${_prop}")
        set_target_properties(KF5::KDE4Support PROPERTIES "${_prop}" "${_temp_prop}")
    endforeach()

    message(AUTHOR_WARNING
"  The KF5KDE4Support package is deprecated: use
  find_package(KF5KDELibs4Support) or
  find_package(KF5 COMPONENTS KDELibs4Support) instead.")
endif()
