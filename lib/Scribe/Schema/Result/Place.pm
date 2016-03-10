package Scribe::Schema::Result::Place;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('place');
__PACKAGE__->add_columns(
    place_id        => { data_type => 'serial',  is_nullable => 0, },
    name            => { data_type => 'text',    is_nullable => 1, },
    parent_place_id => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('place_id');
__PACKAGE__->has_many('notes', 'Scribe::Schema::Result::PlaceNote', 'place_id');
__PACKAGE__->has_many('meta',  'Scribe::Schema::Result::PlaceMeta', 'place_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Place

=head1 SYNOPSIS

This module abstracts "place"

=head1 METHODS

=cut
