package Scribe::Schema::Result::PlaceProject;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('place_project');
__PACKAGE__->add_columns(
    place_project_id => { data_type => 'serial',  is_nullable => 0, },
    place_id         => { data_type => 'integer', is_nullable => 0, },
    project_id       => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->set_primary_key('place_project_id');
__PACKAGE__->add_unique_constraint([ qw/place_id project_id/ ]);
__PACKAGE__->belongs_to(place   => 'Scribe::Schema::Result::Place',   'place_id',   { join_type => 'left' });
__PACKAGE__->belongs_to(project => 'Scribe::Schema::Result::Project', 'project_id', { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::Place

=head1 SYNOPSIS

This module abstracts "place_project", which links a place to a project.

=head1 METHODS

=cut
