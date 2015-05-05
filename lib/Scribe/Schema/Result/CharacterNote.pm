package Scribe::Schema::Result::CharacterNote;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('character_note');
__PACKAGE__->add_columns(
    character_id => { data_type => 'integer', is_nullable => 0, },
    note_id      => { data_type => 'integer', is_nullable => 0, },
);

__PACKAGE__->add_unique_constraint([ qw/character_id note_id/ ]);
__PACKAGE__->belongs_to(character => 'Scribe::Schema::Result::Character', 'character_id', { join_type => 'left' });
__PACKAGE__->belongs_to(note      => 'Scribe::Schema::Result::Note',      'note_id',      { join_type => 'left' });

1;

__END__

=head1 NAME

Scribe::Schema::Result::CharacterNote

=head1 SYNOPSIS

This module abstracts "character_note"

=head1 METHODS

=cut
