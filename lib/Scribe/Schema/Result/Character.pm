package Scribe::Schema::Result::Character;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('character');
__PACKAGE__->add_columns(
    character_id => { data_type => 'serial', is_nullable => 0, },
    name         => { data_type => 'text',   is_nullable => 1, },
);

__PACKAGE__->set_primary_key('character_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Character

=head1 SYNOPSIS

This module abstracts "character"

=head1 METHODS

=cut
