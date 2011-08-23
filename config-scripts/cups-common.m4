dnl
dnl "$Id$"
dnl
dnl   Common configuration stuff for CUPS Legacy.
dnl
dnl   Copyright 2007-2011 by Apple Inc.
dnl   Copyright 1997-2007 by Easy Software Products, all rights reserved.
dnl
dnl   These coded instructions, statements, and computer programs are the
dnl   property of Apple Inc. and are protected by Federal copyright
dnl   law.  Distribution and use rights are outlined in the file "LICENSE.txt"
dnl   which should have been included with this file.  If this file is
dnl   file is missing or damaged, see the license at "http://www.cups.org/".
dnl

dnl We need at least autoconf 2.60...
AC_PREREQ(2.60)

dnl Set the name of the config header file...
AC_CONFIG_HEADER(config.h)

dnl Version number information...
CUPSLEGACY_VERSION="1.6.0"
AC_SUBST(CUPSLEGACY_VERSION)

dnl Default compiler flags...
CFLAGS="${CFLAGS:=}"
CPPFLAGS="${CPPFLAGS:=}"
LDFLAGS="${LDFLAGS:=}"

dnl Checks for programs...
AC_PROG_AWK
AC_PROG_CC
AC_PROG_CPP
AC_PROG_RANLIB
AC_PATH_PROG(AR,ar)
AC_PATH_PROG(CHMOD,chmod)
AC_PATH_PROG(LD,ld)
AC_PATH_PROG(LN,ln)
AC_PATH_PROG(MV,mv)
AC_PATH_PROG(RM,rm)
AC_PATH_PROG(RMDIR,rmdir)
AC_PATH_PROG(SED,sed)

AC_MSG_CHECKING(for install-sh script)
INSTALL="`pwd`/install-sh"
AC_SUBST(INSTALL)
AC_MSG_RESULT(using $INSTALL)

if test "x$AR" = x; then
	AC_MSG_ERROR([Unable to find required library archive command.])
fi
if test "x$CC" = x; then
	AC_MSG_ERROR([Unable to find required C compiler command.])
fi

dnl Check for pkg-config, which is used for some other tests later on...
AC_PATH_PROG(PKGCONFIG, pkg-config)

dnl Checks for header files.
AC_HEADER_STDC

dnl Checks for string functions.
AC_CHECK_FUNCS(strdup strlcat strlcpy)

dnl Check for random number functions...
AC_CHECK_FUNCS(random lrand48 arc4random)

dnl Checks for signal functions.
case "$uname" in
	Linux | GNU)
		# Do not use sigset on Linux or GNU HURD
		;;
	*)
		# Use sigset on other platforms, if available
		AC_CHECK_FUNCS(sigset)
		;;
esac

AC_CHECK_FUNCS(sigaction)

dnl Checks for wait functions.
AC_CHECK_FUNCS(waitpid wait3)

dnl Flags for "ar" command...
case $uname in
        Darwin* | *BSD*)
                ARFLAGS="-rcv"
                ;;
        *)
                ARFLAGS="crvs"
                ;;
esac

AC_SUBST(ARFLAGS)

dnl
dnl End of "$Id$".
dnl
