package Scribe::Schema::Result::Scene;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('scene');
__PACKAGE__->add_columns(
    scene_id    => { data_type => 'serial',  is_nullable => 0, },
    name        => { data_type => 'text',    is_nullable => 1, },
    summary     => { data_type => 'text',    is_nullable => 1, },
    summ_tasks  => { data_type => 'text',    is_nullable => 1, },
    weight      => { data_type => 'integer', is_nullable => 1, },
    label_id    => { data_type => 'integer', is_nullable => 1, },
    document_id => { data_type => 'integer', is_nullable => 1, },
    chapter_id  => { data_type => 'integer', is_nullable => 1, },
    place_id    => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('scene_id');

__PACKAGE__->belongs_to(label    => 'Scribe::Schema::Result::Label',    'label_id',    { join_type => 'left' });
__PACKAGE__->belongs_to(document => 'Scribe::Schema::Result::Document', 'document_id', { join_type => 'left' });
__PACKAGE__->belongs_to(chapter  => 'Scribe::Schema::Result::Chapter',  'chapter_id',  { join_type => 'left' });
__PACKAGE__->belongs_to(place    => 'Scribe::Schema::Result::Place',    'place_id',    { join_type => 'left' });

__PACKAGE__->has_many('characters', 'Scribe::Schema::Result::CharacterScene', 'scene_id');
__PACKAGE__->has_many('tasks',      'Scribe::Schema::Result::Task',           'scene_id', { order_by => { -asc => [qw/weight task_id/]} });

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
