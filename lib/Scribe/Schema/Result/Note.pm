package Scribe::Schema::Result::Note;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('note');
__PACKAGE__->add_columns(
    note_id     => { data_type => 'serial',  is_nullable => 0, },
    name        => { data_type => 'text',    is_nullable => 1, },
    text        => { data_type => 'text',    is_nullable => 1, },
    label_id    => { data_type => 'integer', is_nullable => 1, },
    weight      => { data_type => 'integer', is_nullable => 1, },
    document_id => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('note_id');
__PACKAGE__->belongs_to(label    => 'Scribe::Schema::Result::Label',    'label_id',    { join_type => 'left' });
__PACKAGE__->belongs_to(document => 'Scribe::Schema::Result::Document', 'document_id', { join_type => 'left' });
__PACKAGE__->has_many('characters', 'Scribe::Schema::Result::CharacterNote', 'note_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Note

=head1 SYNOPSIS

This module abstracts "note"

=head1 METHODS

=cut
