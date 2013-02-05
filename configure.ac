# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.64])
AC_INIT([Game of Life],
        [0.1],
        [android@gunibert.de])

AC_CONFIG_SRCDIR([configure.ac])
#AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([1.11 -Wall -Wno-portability dist-xz no-define no-dist-gzip nostdinc subdir-objects])
AM_MAINTAINER_MODE([enable])
AM_SILENT_RULES([yes])

# Check for programs
AC_PROG_CC
AM_PROG_CC_C_O
AM_PROG_VALAC([0.16.0])

PKG_PROG_PKG_CONFIG([0.24])

GNOME_MAINTAINER_MODE_DEFINES
GNOME_COMPILE_WARNINGS([maximum])

#*******************************************************************************
# Check required libraries
#*******************************************************************************


PKG_CHECK_MODULES([CONWAY],
	gtk+-3.0)

GLIB_GSETTINGS
#*******************************************************************************

AC_CONFIG_FILES([
Makefile
src/Makefile
])
AC_OUTPUT

#**************************************************************************

