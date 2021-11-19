# config file for phonon experimental library
# This config can not be used directly. Instead find Phonon or Phonon4Qt5.
# If the experimental config is present it will be automatically included.
# If you want to make sure it is present you can specify Experimental as a
# COMPONENT in find_package.

# known at buildtime
get_filename_component(currentDir ${CMAKE_CURRENT_LIST_FILE} PATH) # get the directory where I myself am
get_filename_component(rootDir ${currentDir}/../../../ ABSOLUTE) # get the chosen install prefix

        # Use original install prefix when loaded through a "/usr move"
        # cross-prefix symbolic link such as /lib -> /usr/lib.
        get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
        get_filename_component(_realOrig "/usr/lib/cmake/phonon4qt5" REALPATH)
        if(_realCurr STREQUAL _realOrig)
            set(rootDir "/usr")
        endif()
        unset(_realOrig)
        unset(_realCurr)

if(NOT TARGET Phonon::phonon4qt5experimental)
  include(${currentDir}/PhononExperimentalTargets.cmake)
  set(PHONON_FOUND_EXPERIMENTAL true)
endif()

# Import Phonon if it is not yet available.
if(NOT TARGET Phonon::phonon4qt5)
    message(FATAL_ERROR "PhononExperimental library was found but there is no target for the primary library.")
endif()

set(PHONON_EXPERIMENTAL_LIBRARY Phonon::phonon4qt5experimental)
