package Scribe::Schema::Result::Label;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('label');
__PACKAGE__->add_columns(
    label_id => { data_type => 'serial', is_nullable => 0, },
    name     => { data_type => 'text',   is_nullable => 0, },
    color    => { data_type => 'text',   is_nullable => 0, },
);

__PACKAGE__->set_primary_key('label_id');
__PACKAGE__->add_unique_constraint(label_unique_key_name => [ qw/name/ ]);
__PACKAGE__->has_many(notes => 'Scribe::Schema::Result::Note', 'note_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Label

=head1 SYNOPSIS

This module abstracts "label"

=head1 METHODS

=cut
