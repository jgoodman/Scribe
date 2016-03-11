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
my $bare_install;
GetOptions(
    'help|?'       => \$help,
    man            => \$man,
    'bare-install' => \$bare_install;
) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

my $c = 'Scribe::_Config';
my $schema = Scribe::Schema->connect('dbi:Pg:database='.$c->dbname.';host='.$c->dbhost.';port=5432', $c->dbuser, $c->dbpass);
$schema->deploy( { add_drop_table => 1 } );

# setup admin user
my $user = $schema->resultset('AccessUser')->new({ name => 'admin', email => 'admin' });
$user->password('b00t');
$user->insert;

exit if $bare_install;

# setup labels
my @labels = (
    { name => 'TODO',           color => 'red' },
    { name => 'In Progress',    color => 'blue' },
    { name => 'Needs Revision', color => 'orange' },
    { name => 'Completed',      color => 'green' },
);

my $label_rs = $schema->resultset('Label');
foreach my $hash (@labels) {
    $label_rs->new($hash)->insert;
}


__END__

=head1 NAME

setup_db.pl

=head1 DESCRIPTION

Create Scribe database tables and initial data.

=head1 USAGE

setup_db.pl [options]

=over 8

=item B<h, --help>

Print a brief help message and exits.

=item B<m, --man>

Prints the manual page and exits.

=item B<b, --bare-install>

Exclude creation of initial data (besides admin user)

=back

=cut
