package Scribe::Schema::Result::GoalNote;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('goal_note');
__PACKAGE__->add_columns(
    goal_id => { data_type => 'integer', is_nullable => 0, },
    note_id => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->add_unique_constraint([ qw/goal_id note_id/ ]);
__PACKAGE__->belongs_to(goal => 'Scribe::Schema::Result::Goal', 'goal_id', { join_type => 'left' });
__PACKAGE__->belongs_to(note => 'Scribe::Schema::Result::Note', 'note_id', { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::GoalNote

=head1 SYNOPSIS

This module abstracts "goal_note", which links a goal to a note.

=head1 METHODS

=cut
