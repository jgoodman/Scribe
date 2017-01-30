package Scribe::Schema::Result::CharacterProject;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('character_project');
__PACKAGE__->add_columns(
    character_project_id => { data_type => 'serial',  is_nullable => 0, },
    character_id         => { data_type => 'integer', is_nullable => 0, },
    project_id           => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->set_primary_key('character_project_id');
__PACKAGE__->add_unique_constraint([ qw/character_id project_id/ ]);
__PACKAGE__->belongs_to(character => 'Scribe::Schema::Result::Character', 'character_id', { join_type => 'left' });
__PACKAGE__->belongs_to(project   => 'Scribe::Schema::Result::Project',     'project_id',     { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::CharacterProject

=head1 SYNOPSIS

This module abstracts "character_project", which links a character to a project.

=head1 METHODS

=cut
