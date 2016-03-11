package Scribe::Schema::Result::Task;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('task');
__PACKAGE__->add_columns(
    task_id      => { data_type => 'serial',  is_nullable => 0, },
    name         => { data_type => 'text',    is_nullable => 1, },
    summary      => { data_type => 'text',    is_nullable => 1, },
    weight       => { data_type => 'integer', is_nullable => 1, },
    label_id     => { data_type => 'integer', is_nullable => 1, },
    scene_id     => { data_type => 'integer', is_nullable => 1, },
    character_id => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('task_id');

__PACKAGE__->belongs_to(label     => 'Scribe::Schema::Result::Label',     'label_id',     { join_type => 'left' });
__PACKAGE__->belongs_to(scene     => 'Scribe::Schema::Result::Scene',     'scene_id',     { join_type => 'left' });
__PACKAGE__->belongs_to(character => 'Scribe::Schema::Result::Character', 'character_id', { join_type => 'left' });


1;

__END__

=head1 NAME

Scribe::Schema::Result::Task

=head1 SYNOPSIS

This module abstracts a "task", an action (or perhaps event?)
that a character does. Tasks compose into a single scene.

=cut
