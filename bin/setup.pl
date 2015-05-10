#!/usr/bin/env perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Getopt::Long;
use Pod::Usage;

use Scribe::Schema;
use Scribe::_Config;

my $man;
my $help;
my $dry;
my $verbose = 0;
GetOptions(
    'help|?' => \$help,
    man      => \$man,
) or pod2usage(2);;
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

my $c = 'Scribe::_Config';
use DBI;
my $schema = Scribe::Schema->connect('dbi:Pg:database='.$c->dbname.';host='.$c->dbhost.';port=5432', $c->dbuser, $c->dbpass);
$schema->deploy( { add_drop_table => 1 } );

my $user = $schema->resultset('AccessUser')->new({ name => 'admin', email => 'admin' });
$user->password('b00t');
$user->insert;

__END__

=head1 NAME

setup.pl

=head1 DESCRIPTION

This is a script which will create database tables

=head1 USAGE

setup.pl [options]

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=cut
