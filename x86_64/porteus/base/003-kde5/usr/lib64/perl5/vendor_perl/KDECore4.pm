#***************************************************************************
#                          KDECore4.pm  -  KDECore perl client lib
#                             -------------------
#    begin                : 07-12-2009
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

package KDECore4::_internal;

use strict;
use warnings;
use QtCore4;
use base qw(Qt::_internal);

sub init {
    $Qt::_internal::arrayTypes{'const KUrl::List&'} = {
        value => [ 'KDE::Url']
    };
    foreach my $c ( @{getClassList()} ) {
        KDECore4::_internal->init_class($c);
    }
    foreach my $e ( @{getEnumList()} ) {
        KDECore4::_internal->init_enum($e);
    }
}

sub normalize_classname {
    my ( $self, $cxxClassName ) = @_;
    if( $cxxClassName =~ m/^K/ ) {
        $cxxClassName =~ s/^K(?=[A-Z])/KDE::/;
    }
    else {
        $cxxClassName = $self->SUPER::normalize_classname( $cxxClassName );
    }
    return $cxxClassName;
}

package KDECore4;

use strict;
use warnings;
use QtCore4;

require XSLoader;

our $VERSION = '0.01';

XSLoader::load('KDECore4', $VERSION);

KDECore4::_internal::init();

1;

package Qt::GlobalSpace;

our @EXPORT_OK;

push @EXPORT_OK, qw( i18n ki18n );

1;
