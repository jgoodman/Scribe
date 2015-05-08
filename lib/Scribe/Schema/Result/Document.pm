package Scribe::Schema::Result::Document;

use strict;
use warnings;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table('document');
__PACKAGE__->add_columns(
    document_id => { data_type => 'serial', is_nullable => 0, },
    name        => { data_type => 'text',   is_nullable => 1, },
    url_address => { data_type => 'text',   is_nullable => 0, },
);

__PACKAGE__->set_primary_key('document_id');

1;

__END__

=head1 NAME

Scribe::Schema::Result::Document

=head1 SYNOPSIS

This module abstracts "document", which represents a document stored on Google Drive

=head1 COLUMNS

=over

=item document_id

Primary key

=item name

String value, name of the document

=item url_address

String value, url to the document stored on Google Drive

=back

=head1 METHODS

=cut
