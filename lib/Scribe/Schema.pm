package Scribe::Schema;

use strict;
use warnings;

use base qw/DBIx::Class::Schema/;
our $VERSION = 4;

__PACKAGE__->load_namespaces();

1;

__END__

=head1 NAME

Scribe::Schema

=head1 SYNOPSIS

This module inherits from DBIx::Class:Schema

=cut
