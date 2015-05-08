package Scribe::Schema::Result::ProjectGroup;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('project_group');
__PACKAGE__->add_columns(
    group_id => { data_type => 'serial', is_nullable => 0, },
    name     => { data_type => 'text',   is_nullable => 0, },
);

__PACKAGE__->set_primary_key('group_id');
__PACKAGE__->has_many('projects', 'Scribe::Schema::Result::Project', 'group_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::ProjectGroup

=head1 SYNOPSIS

This module abstracts "project_group",
which represents a collection of projects that relate to each other.
This is synonymous to a "book series" but we cannot really call it
that since not all projects are books; A project could be a short story
hence this module having an ambigious name.

=head1 COLUMNS

=over

=item group_id

Primary key

=item name

String value, name of the group

=back

=head1 METHODS

=cut
