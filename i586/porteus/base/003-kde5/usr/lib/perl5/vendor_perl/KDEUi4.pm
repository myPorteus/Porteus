#***************************************************************************
#                          KDEUi4.pm  -  KDEUi perl client lib
#                             -------------------
#    begin                : 03-29-2010
#    copyright            : (C) 2009 by Chris Burel
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

package KDEUi4::_internal;

use strict;
use warnings;

use QtGui4;
use KDECore4;
use base qw(KDECore4::_internal);

sub init {
    foreach my $c ( @{getClassList()} ) {
        KDEUi4::_internal->init_class($c);
    }
    foreach my $e ( @{getEnumList()} ) {
        KDEUi4::_internal->init_enum($e);
    }
}

sub KDE::Application::NEW {
    my $class = shift;
    my $retval = KDE::Application::KApplication( @_ );
    bless( $retval, " $class" );
    Qt::_internal::setThis( $retval );
    setKApp( $retval );
}

package KDEUi4;

use strict;
use warnings;
use QtGui4;
use KDECore4;

require Exporter;
require XSLoader;

our $VERSION = '0.01';

our @EXPORT = qw( kapp );

XSLoader::load('KDEUi4', $VERSION);

KDEUi4::_internal::init();

sub import { goto &Exporter::import }

1;
