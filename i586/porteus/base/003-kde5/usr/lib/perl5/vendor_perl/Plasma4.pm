#***************************************************************************
#                          Plasma4.pm  -  Plasma perl client lib
#                             -------------------
#    begin                : 04-02-2010
#    copyright            : (C) 2010 by Chris Burel
#    email                : chrisburel@gmail.com
# ***************************************************************************

#***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************

package Plasma4::_internal;

use strict;
use warnings;

use KDEUi4;
use base qw(KDEUi4::_internal);

sub init {
    foreach my $c ( @{getClassList()} ) {
        Plasma4::_internal->init_class($c);
    }
    foreach my $e ( @{getEnumList()} ) {
        Plasma4::_internal->init_enum($e);
    }
}

package Plasma4;

use strict;
use warnings;
use KDEUi4;

require Exporter;
require XSLoader;

our $VERSION = '0.01';

XSLoader::load('Plasma4', $VERSION);

Plasma4::_internal::init();

sub import { goto &Exporter::import }

1;
