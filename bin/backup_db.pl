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
GetOptions(
    'help|?' => \$help,
    man      => \$man,
) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

my $c = 'Scribe::_Config';
my $backup_dir = $ENV{'HOME'}.'/.scribe_backup';

mkdir $backup_dir, 0775 unless -e $backup_dir;

my $time   = time;
my $dbhost = $c->dbhost;
my $dbport = 5432;
my $dbname = $c->dbname;
my $dbuser = $c->dbuser;

my $file = "$backup_dir/$dbname.$time.sql";

$ENV{'PGPASSWORD'} = $c->dbpass;
`pg_dump --host=$dbhost --port=$dbport --username=$dbuser --file=$file --verbose $dbname`;

__END__

=head1 NAME

backup_db.pl

=head1 DESCRIPTION

Backup Scribe database tables.

=head1 USAGE

backup_db.pl [options]

=over 8

=item B<h, --help>

Print a brief help message and exits.

=item B<m, --man>

Prints the manual page and exits.

=back

=cut
