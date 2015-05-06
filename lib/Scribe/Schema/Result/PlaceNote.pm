package Scribe::Schema::Result::PlaceNote;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('place_note');
__PACKAGE__->add_columns(
    place_id => { data_type => 'integer', is_nullable => 0, },
    note_id  => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->add_unique_constraint([ qw/place_id note_id/ ]);
__PACKAGE__->belongs_to(place => 'Scribe::Schema::Result::Place', 'place_id', { join_type => 'left' });
__PACKAGE__->belongs_to(note  => 'Scribe::Schema::Result::Note',  'note_id',  { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::PlaceNote

=head1 SYNOPSIS

This module abstracts "place_note", which links a place to a note.

=head1 METHODS

=cut
