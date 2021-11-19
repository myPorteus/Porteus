#!/bin/csh
# Set the system locale.  (no, we don't have a menu for this ;-)
# For a list of locales which are supported by this machine, type:
#   locale -a

# en_US is the Slackware default locale:
setenv LANG en_US

# 'C' is the old Slackware (and UNIX) default, which is 127-bit
# ASCII with a charmap setting of ANSI_X3.4-1968.  These days,
# it's better to use en_US or another modern $LANG setting to
# support extended character sets.
#setenv LANG C

# There is also support for UTF-8 locales, but be aware that
# some programs may possibly misbehave under UTF-8.  In those
# cases, you can set LANG=C before starting them.  Note that
# there are some UTF-8 locales that do not contain UTF-8 or
# utf8 in the locale name, so to test if a locale is UTF-8,
# use this command:
#
# LANG=<locale> locale -k charmap
#
# UTF-8 locales will include "UTF-8" in the output.
#
#setenv LANG en_US.UTF-8

# Another option for en_US:
#setenv LANG en_US.ISO8859-1

# One side effect of the newer locales is that the sort order
# is no longer according to ASCII values, so the sort order will
# change in many places.  Since this isn't usually expected and
# can break scripts, we'll stick with traditional ASCII sorting.
# If you'd prefer the sort algorithm that goes with your $LANG
# setting, comment this out.
setenv LC_COLLATE C

# End of /etc/profile.d/lang.csh

