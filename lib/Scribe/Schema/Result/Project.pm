package Scribe::Schema::Result::Project;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('project');
__PACKAGE__->add_columns(
    project_id => { data_type => 'serial',  is_nullable => 0, },
    number     => { data_type => 'integer', is_nullable => 1, },
    name       => { data_type => 'text',    is_nullable => 0, },
    group_id   => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('project_id');
__PACKAGE__->belongs_to('project_group' => 'Scribe::Schema::Result::ProjectGroup', 'group_id', { join_type => 'left' });
__PACKAGE__->has_many('chapters', 'Scribe::Schema::Result::Chapter', 'chapter_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Project

=head1 SYNOPSIS

This module abstracts "project", which represents either an epic, novel, novella, novelette, or short story.

=head1 COLUMNS

=over

=item project_id

Primary key

=item number

Integer value, the book number used for ordering where it belongs in a project group (book series)

=item name

String value, name of the project.
This is the second value used for ordering where it belongs in a project group.

=item group_id

Foreign key to project_group table

=back

=head1 METHODS

=cut
