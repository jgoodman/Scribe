#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

my $home = $ENV{'HOME'};
my $src  = "$home/github/Scribe";
my $mod  = "$home/perl5/lib/perl5";
my $web  = "$home/public_html/scribe";

my $man;
my $help;
my $setup_db;
GetOptions(
    'help|?'   => \$help,
    man        => \$man,
    'setup-db' => \$setup_db,
) or pod2usage(2);;
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

my @cmds = (
    "rm -rf $mod/Scribe*",
    "rsync -var $src/lib/ $mod/",
    "find $mod/ -type f -name '*.swp' | xargs rm",
    "find $mod/Scribe -type f | xargs chmod 444",
    "find $mod/Scribe -type d | xargs chmod 755",
    "chmod 755 $mod/Scribe",
    "rm -rf $web",
    "mkdir $web",
    "chmod 755 $web",
    "rsync -va $src/.htaccess $web/",
    "rsync -var $src/cgi/ $web/cgi/",
    "find $web/cgi -type f -name '*.swp' | xargs rm",
    "chmod -R 755 $web/cgi",
    "rsync -var $src/db/ $web/db/",
    "find $web/db -type f -name '*.swp' | xargs rm",
    "chmod -R 755 $web/db",
    "rsync -var $src/tt/ $web/tt/",
    "find $web/tt -type f -name '*.swp' | xargs rm",
    "rsync -var $src/media/ $web/media/",
    "find $web/media -type f -name '*.swp' | xargs rm",
    "rsync -var $src/js/ $web/js/",
    "find $web/js -type f -name '*.swp' | xargs rm",
);

push @cmds, "sudo -u jgoodma2 perl -I$mod $src/bin/setup_db.pl" if $setup_db;

foreach my $cmd (@cmds) {
    print "\n---------\n";
    print "$cmd\n";
    print `$cmd`;
}

__END__

=head1 NAME

install.pl

=head1 DESCRIPTION

Install scribe files on a cpanel hosting account
along with optionally setting up the database.

=head1 USAGE

setup.pl [options]

=over 8

=item B<h, --help>

Print a brief help message and exits.

=item B<m, --man>

Prints the manual page and exits.

=item B<s, --setup-db>

By default, this script only copies the files.
Enable this option to execute the setup_db script
as well.

=back

=cut
