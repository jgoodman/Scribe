package Scribe::Schema::Result::Project;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('project');
__PACKAGE__->add_columns(
    project_id => { data_type => 'serial',  is_nullable => 0, },
    name       => { data_type => 'text',    is_nullable => 0, },
    group_id   => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('project_id');
__PACKAGE__->belongs_to('project_group' => 'Scribe::Schema::Result::ProjectGroup', 'group_id', { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::Project

=head1 SYNOPSIS

This module abstracts "project"

=head1 METHODS

=cut
