package Scribe::Schema::Result::ProjectGroup;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('project_group');
__PACKAGE__->add_columns(
    group_id => { data_type => 'serial', is_nullable => 0, },
    name     => { data_type => 'text',   is_nullable => 0, },
);

__PACKAGE__->set_primary_key('group_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::ProjectGroup

=head1 SYNOPSIS

This module abstracts "project_group"

=head1 METHODS

=cut
