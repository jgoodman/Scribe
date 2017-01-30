package Scribe::Schema::Result::AccessUser;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('access_user');
__PACKAGE__->add_columns(
    access_user_id => { data_type => 'serial',  is_nullable => 0, },
    name           => { data_type => 'text',    is_nullable => 0, },
    password       => { data_type => 'text',    is_nullable => 0, },
    email          => { data_type => 'text',    is_nullable => 1, },
    xp             => { data_type => 'integer', is_nullable => 1, },
);

__PACKAGE__->set_primary_key('access_user_id');
__PACKAGE__->add_unique_constraint(access_user_unique_key_name => [ qw/name/ ]);

1;

__END__

=head1 NAME

Scribe::Schema::Result::AccessUser

=head1 SYNOPSIS

This module abstracts a user who can log into the application

=head1 METHODS

=cut
