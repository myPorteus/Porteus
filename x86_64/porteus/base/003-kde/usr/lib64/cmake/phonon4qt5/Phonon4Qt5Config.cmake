# config file for phonon library

# known at buildtime
set(PHONON_VERSION "4.10.0")

get_filename_component(currentDir ${CMAKE_CURRENT_LIST_FILE} PATH) # get the directory where I myself am
get_filename_component(rootDir ${currentDir}/../../../ ABSOLUTE) # get the chosen install prefix

        # Use original install prefix when loaded through a "/usr move"
        # cross-prefix symbolic link such as /lib -> /usr/lib.
        get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
        get_filename_component(_realOrig "/usr/lib64/cmake/phonon4qt5" REALPATH)
        if(_realCurr STREQUAL _realOrig)
            set(rootDir "/usr")
        endif()
        unset(_realOrig)
        unset(_realCurr)

set(PHONON_NO_GRAPHICSVIEW true)
set(PHONON_PULSESUPPORT TRUE)
set(PHONON_FIND_EXPERIMENTAL ON)
set(PHONON_QT_COMPAT_HEADERS OFF)

# install locations
set(PHONON_INCLUDE_DIR "${rootDir}/include/phonon4qt5")

set(PHONON_LIBRARY_DIR "${rootDir}/lib64")
set(PHONON_BUILDSYSTEM_DIR "/usr/share/phonon4qt5/buildsystem/")
set(PHONON_LIB_SONAME "phonon4qt5")

if(NOT TARGET Phonon::phonon4qt5)
  include(${currentDir}/PhononTargets.cmake)
endif()

set(PHONON_LIBRARY Phonon::phonon4qt5)

# Find Experimental.
# Iff it was specified as component we require it.
# Else if we built with it we try to find it quietly.
# The latter part is to provide backwards compatibility as a simple finding of
# Phonon would also drag in experimental. To simulate this we'll look for it
# silenetly while not failing if it was not found. Ultimately it was the
# config consumer's responsibility to check if experimental was actually found.
# So nothing changes there. Config consumers can however now use it as a
# component to force an error when it isn't available.
if("${Phonon4Qt5_FIND_COMPONENTS}" MATCHES ".*(Experimental|experimental).*")
    find_package(Phonon4Qt5Experimental ${PHONON_VERSION} EXACT CONFIG REQUIRED
                 PATHS ${currentDir}
                 NO_DEFAULT_PATH)
elseif(PHONON_FIND_EXPERIMENTAL)
    find_package(Phonon4Qt5Experimental ${PHONON_VERSION} EXACT CONFIG QUIET
                 PATHS ${currentDir}
                 NO_DEFAULT_PATH)
endif()

# Convenience.
set(PHONON_LIBRARIES ${PHONON_LIBRARY} ${PHONON_EXPERIMENTAL_LIBRARY})
# The following one is only for compatiblity
set(PHONON_LIBS ${PHONON_LIBRARIES})
set(PHONON_INCLUDES ${PHONON_INCLUDE_DIR} ${PHONON_INCLUDE_DIR}/KDE)
if (PHONON_QT_COMPAT_HEADERS)
    list(APPEND PHONON_INCLUDES ${PHONON_INCLUDE_DIR}/Phonon)
endif()

# Find Internal is included in the backends' finders rather than here.
# http://lists.kde.org/?l=kde-multimedia&m=135934335320148&w=2
