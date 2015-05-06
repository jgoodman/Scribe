package Scribe::Schema::Result::CharacterGoal;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('character_goal');
__PACKAGE__->add_columns(
    character_id => { data_type => 'integer', is_nullable => 0, },
    goal_id      => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->add_unique_constraint([ qw/character_id goal_id/ ]);
__PACKAGE__->belongs_to(character => 'Scribe::Schema::Result::Character', 'character_id', { join_type => 'left' });
__PACKAGE__->belongs_to(goal      => 'Scribe::Schema::Result::Goal',      'goal_id',      { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::CharacterGoal

=head1 SYNOPSIS

This module abstracts "character_goal", which links
a character to a goal/objective that they are wanting to accomplish

=head1 METHODS

=cut
