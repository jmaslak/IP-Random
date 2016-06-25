#
# Copyright (C) 2015,2016 Joel C. Maslak
# All Rights Reserved - See License
#
# From JCM::Boilerplate
#
# Modified to allow Perl 5.20 (we want sub signatures)
# Modified to "use" classes that will be relevant so that Dist::Zilla
#   will auto-depend properly

package IP::Random::Boilerplate v0.01.11;
# ABSTRACT: Default Boilerplate for IP::Random

=head1 SYNOPSIS

  use IP::Random::Boilerplate 'script';

=head1 DESCRIPTION

This module sets some default imports, and turns on the strictures I've
come to rely upon.

=head1 WARNINGS

This module makes significant changes in the calling package!

=cut

use v5.20;
use strict;
use warnings;

use feature 'signatures';
no warnings 'experimental::signatures';

use Import::Into;

# So we pick these up with Dist::Zilla
use autodie;
use Carp;
use English;
use namespace::autoclean;

sub import($self) {
    my $target = caller;

    namespace::autoclean->import::into($target);

    strict->import::into($target);
    warnings->import::into($target);
    autodie->import::into($target);

    feature->import::into($target, ':5.20');

    Carp->import::into($target);

    feature->import::into($target, 'postderef');    # Not needed if feature budle >= 5.23.1
    feature->import::into($target, 'signatures');
    
    warnings->unimport::out_of($target, 'experimental::signatures');
    if ($PERL_VERSION lt v5.24.0) {
        warnings->unimport::out_of($target, 'experimental::postderef');
    }
}

1;


