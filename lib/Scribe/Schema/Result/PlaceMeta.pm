package Scribe::Schema::Result::PlaceMeta;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('place_meta');
__PACKAGE__->add_columns(
    meta_id  => { data_type => 'serial',  is_nullable => 0, },
    place_id => { data_type => 'integer', is_nullable => 0, },
    key      => { data_type => 'text',    is_nullable => 1, },
    value    => { data_type => 'text',    is_nullable => 1, },
);

__PACKAGE__->set_primary_key('meta_id');
__PACKAGE__->belongs_to('place' => 'Scribe::Schema::Result::Place', 'place_id', { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::PlaceMeta

=head1 SYNOPSIS

This module abstracts "place_meta".
The intent of this table is to hold metadata in regards to a place.
This may include culture, economics, or anything else... You name it!

=head1 METHODS

=cut
