package Scribe::Schema::Result::Chapter;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('chapter');
__PACKAGE__->add_columns(
    chapter_id => { data_type => 'serial',  is_nullable => 0, },
    number     => { data_type => 'integer', is_nullable => 0, },
    name       => { data_type => 'text',    is_nullable => 1, },
    project_id => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->set_primary_key('chapter_id');
__PACKAGE__->belongs_to('project' => 'Scribe::Schema::Result::Project', 'project_id', { join_type => 'left' });
__PACKAGE__->has_many('', 'Scribe::Schema::Result::Chapter', 'chapter_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Chapter

=head1 SYNOPSIS

This module abstracts "chapter"

=head1 COLUMNS

=over

=item chapter_id

Primary key

=item number

Integer value, the chapter number used for ordering where it belongs in a project

=item name

String value, optional name of the chapter.
This is the second value used for ordering where it belongs in a project.

=item project_id

Foreign key to the project table

=back

=head1 METHODS

=cut
