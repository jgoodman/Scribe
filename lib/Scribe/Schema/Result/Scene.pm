package Scribe::Schema::Result::Scene;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('scene');
__PACKAGE__->add_columns(
    scene_id   => { data_type => 'serial',  is_nullable => 0, },
    number     => { data_type => 'integer', is_nullable => 0, },
    name       => { data_type => 'text',    is_nullable => 1, },
    chapter_id => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->set_primary_key('scene_id');
__PACKAGE__->belongs_to('chapter' => 'Scribe::Schema::Result::Chapter', 'chapter_id', { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::Scene

=head1 SYNOPSIS

This module abstracts "scene"

=head1 COLUMNS

=over

=item scene_id

Primary key

=item number

Integer value, the scene number used for ordering where it belongs in a chpater

=item name

String value, optional name of the scene.
This is the second value used for ordering where it belongs in a chapter.

=item chapter_id

Foreign key to the chapter table

=back

=head1 METHODS

=cut
