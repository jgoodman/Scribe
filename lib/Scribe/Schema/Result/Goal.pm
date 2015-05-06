package Scribe::Schema::Result::Goal;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('goal');
__PACKAGE__->add_columns(
    goal_id => { data_type => 'serial', is_nullable => 0, },
    name    => { data_type => 'text',   is_nullable => 0, },
);

__PACKAGE__->set_primary_key('goal_id');
__PACKAGE__->has_many('characters', 'Scribe::Schema::Result::CharacterGoal', 'goal_id');
__PACKAGE__->has_many('notes',      'Scribe::Schema::Result::GoalNote',      'goal_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Goal

=head1 SYNOPSIS

This module abstracts "goal" which represents an objective to obtain.

=head1 METHODS

=cut
