package Scribe::_Config;

use strict;
use warnings;

sub server_url { die 'server_url not set' };
sub webroot { die 'webroot not set' };
sub app_dirname { die 'app_dirname not set' };
sub dbhost { die 'dbhost not set' }
sub dbname { die 'dbname not set' }
sub dbport { 5432 }
sub dbuser { die 'dbuser not set' }
sub dbpass { die 'dbpass not set' }

1;

__END__

=head1 NAME

Scribe::_Config

=head1 SYNOPSIS

This module is intended to be modified where each sub is changed to return the config information.

=head1 METHODS

=head2 server_url

The hostname that this application resides on.

Example:

  sub server_url { 'example.com' }

=head2 webroot

The absolute file path to the public_html directory.

Example:

  sub webroot { '/var/www/html' }

=head2 app_dirname

The name of the directory where the scribe application resides in.
This is relative to the webroot.

Example:

  sub app_dirname { 'scribe' }

=head2 dbhost

Hostname of the database server

Example:

  sub dbhost { 'localhost' }

=head2 dbname

Database name that Scribe will connect to.

Example:

  sub dbname { 'scribe' }

=head2 dbport

Database name that Scribe will connect to.

Example:

  sub dbport { 5432 }

=head2 dbuser

Database username that Scribe connect as.

Example:

  sub dbuser { 'scribe' }

=head2 dbpass

Database password that Scribe will use when connecting.

Example:

  sub dbpass { 'some_password' }

=cut
