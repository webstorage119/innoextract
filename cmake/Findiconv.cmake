
# Copyright (C) 2012-2013 Daniel Scharrer
#
# This software is provided 'as-is', without any express or implied
# warranty.  In no event will the author(s) be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

# Try to find the iconv library and include path for iconv.h.
# Once done this will define
#
# iconv_FOUND
# iconv_INCLUDE_DIR - where to find iconv.h
# iconv_LIBRARIES - libiconv.so or empty if none was found
# An empty iconv_LIBRARIES is not an error as iconv is often included in the system libc.

# option(iconv_USE_STATIC_LIBS "Statically link libiconv" OFF)

include(UseStaticLibs)
use_static_libs(iconv)

find_path(iconv_INCLUDE_DIR iconv.h DOC "The directory where iconv.h resides")
mark_as_advanced(iconv_INCLUDE_DIR)

# Prefer libraries in the same prefix as the include files
string(REGEX REPLACE "(.*)/include/?" "\\1" iconv_BASE_DIR ${iconv_INCLUDE_DIR})

find_library(iconv_LIBRARY iconv libiconv HINTS "${iconv_BASE_DIR}/lib" DOC "The iconv library")
mark_as_advanced(iconv_LIBRARY)

use_static_libs_restore()

# handle the QUIETLY and REQUIRED arguments and set iconv_FOUND to TRUE if 
# all listed variables are TRUE
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(iconv DEFAULT_MSG iconv_INCLUDE_DIR)

# For some reason, find_package_... uppercases it's first argument. Nice!
if(ICONV_FOUND)
	set(iconv_LIBRARIES)
	if(iconv_LIBRARY)
		list(APPEND iconv_LIBRARIES ${iconv_LIBRARY})
	endif()
endif(ICONV_FOUND)