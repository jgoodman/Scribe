package Scribe::Schema::Result::CharacterScene;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('character_scene');
__PACKAGE__->add_columns(
    character_id => { data_type => 'integer', is_nullable => 0, },
    scene_id     => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->add_unique_constraint([ qw/character_id scene_id/ ]);
__PACKAGE__->belongs_to(character => 'Scribe::Schema::Result::Character', 'character_id', { join_type => 'left' });
__PACKAGE__->belongs_to(scene     => 'Scribe::Schema::Result::Scene',     'scene_id',     { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::CharacterScene

=head1 SYNOPSIS

This module abstracts "character_scene", which links a character to a scene.

=head1 METHODS

=cut
